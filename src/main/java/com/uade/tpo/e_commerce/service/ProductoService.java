package com.uade.tpo.e_commerce.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.dto.FiltrosProductoDTO;
import com.uade.tpo.e_commerce.dto.OpcionFiltroDTO;
import com.uade.tpo.e_commerce.dto.PaginaProductosDTO;
import com.uade.tpo.e_commerce.dto.ProductoRequestDTO;
import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
import com.uade.tpo.e_commerce.exception.CategoriaNotFoundException;
import com.uade.tpo.e_commerce.exception.PrecioNegativoException;
import com.uade.tpo.e_commerce.exception.ProductoConVentasException;
import com.uade.tpo.e_commerce.exception.ProductoNoPropioException;
import com.uade.tpo.e_commerce.exception.ProductoNotFoundException;
import com.uade.tpo.e_commerce.exception.StockInvalidoException;
import com.uade.tpo.e_commerce.exception.UsuarioNotFoundException;
import com.uade.tpo.e_commerce.model.Categoria;
import com.uade.tpo.e_commerce.model.Producto;
import com.uade.tpo.e_commerce.model.Role;
import com.uade.tpo.e_commerce.model.Usuario;
import com.uade.tpo.e_commerce.repository.CarritoProductosRepository;
import com.uade.tpo.e_commerce.repository.CategoriaRepository;
import com.uade.tpo.e_commerce.repository.FavoritoRepository;
import com.uade.tpo.e_commerce.repository.OrdenItemRepository;
import com.uade.tpo.e_commerce.repository.ProductoRepository;
import com.uade.tpo.e_commerce.repository.UsuarioRepository;

import jakarta.persistence.criteria.Predicate;
import jakarta.transaction.Transactional;

/**
 * Capa donde reside la lógica de negocio y donde se manejan las transacciones.
 * ProductoService
 */
@Service
@Transactional
public class ProductoService {

    private final ProductoRepository productoRepository;
    private final CategoriaRepository categoriaRepository;
    private final UsuarioRepository usuarioRepository;
    private final CarritoProductosRepository carritoProductosRepository;
    private final FavoritoRepository favoritoRepository;
    private final OrdenItemRepository ordenItemRepository;

    public ProductoService(ProductoRepository productoRepository,
                           CategoriaRepository categoriaRepository,
                           UsuarioRepository usuarioRepository,
                           CarritoProductosRepository carritoProductosRepository,
                           FavoritoRepository favoritoRepository,
                           OrdenItemRepository ordenItemRepository) {
        this.productoRepository = productoRepository;
        this.categoriaRepository = categoriaRepository;
        this.usuarioRepository = usuarioRepository;
        this.carritoProductosRepository = carritoProductosRepository;
        this.favoritoRepository = favoritoRepository;
        this.ordenItemRepository = ordenItemRepository;
    }

    private static final int TAMANIO_PAGINA_DEFAULT = 9;
    private static final int TAMANIO_PAGINA_MAXIMO = 100;

    // Listado con filtros combinables (AND entre filtros, OR dentro de categorías/vendedores),
    // orden y paginación (página base 1). Todos los parámetros son opcionales.
    @Transactional(Transactional.TxType.SUPPORTS)
    public PaginaProductosDTO getAllProductos(List<Long> categoriaIds, List<Long> vendedorIds,
            Double precioMin, Double precioMax, Boolean soloConStock, String busqueda,
            String orden, Integer pagina, Integer tamanio) {

        Specification<Producto> spec = (root, query, cb) -> {
            List<Predicate> predicados = new ArrayList<>();
            if (categoriaIds != null && !categoriaIds.isEmpty()) {
                predicados.add(root.get("categoria").get("id").in(categoriaIds));
            }
            if (vendedorIds != null && !vendedorIds.isEmpty()) {
                predicados.add(root.get("vendedor").get("id").in(vendedorIds));
            }
            if (precioMin != null) {
                predicados.add(cb.greaterThanOrEqualTo(root.<Double>get("precio"), precioMin));
            }
            if (precioMax != null) {
                predicados.add(cb.lessThanOrEqualTo(root.<Double>get("precio"), precioMax));
            }
            if (Boolean.TRUE.equals(soloConStock)) {
                predicados.add(cb.greaterThan(root.<Integer>get("stock"), 0));
            }
            if (busqueda != null && !busqueda.isBlank()) {
                predicados.add(cb.like(cb.lower(root.<String>get("nombre")),
                        "%" + busqueda.trim().toLowerCase() + "%"));
            }
            return cb.and(predicados.toArray(new Predicate[0]));
        };

        int numeroPagina = (pagina == null || pagina < 1) ? 1 : pagina;
        int tam = (tamanio == null || tamanio < 1) ? TAMANIO_PAGINA_DEFAULT
                : Math.min(tamanio, TAMANIO_PAGINA_MAXIMO);
        // id como desempate para que la paginación sea estable
        Pageable pageable = PageRequest.of(numeroPagina - 1, tam, resolverOrden(orden).and(Sort.by("id")));

        Page<Producto> resultado = productoRepository.findAll(spec, pageable);
        return new PaginaProductosDTO(
                resultado.getContent().stream().map(this::toDTO).toList(),
                resultado.getTotalElements(),
                resultado.getTotalPages(),
                numeroPagina,
                tam);
    }

    // Orden por defecto (o valor desconocido): nombre A-Z, como el listado original
    private Sort resolverOrden(String orden) {
        if ("precio_asc".equalsIgnoreCase(orden)) {
            return Sort.by(Sort.Direction.ASC, "precio");
        }
        if ("precio_desc".equalsIgnoreCase(orden)) {
            return Sort.by(Sort.Direction.DESC, "precio");
        }
        return Sort.by(Sort.Direction.ASC, "nombre");
    }

    // Datos para la barra lateral de filtros
    @Transactional(Transactional.TxType.SUPPORTS)
    public FiltrosProductoDTO getOpcionesFiltros() {
        return new FiltrosProductoDTO(
                aOpciones(productoRepository.contarPorCategoria()),
                aOpciones(productoRepository.contarPorVendedor()),
                productoRepository.precioMinimo(),
                productoRepository.precioMaximo(),
                productoRepository.countByStockGreaterThan(0));
    }

    private List<OpcionFiltroDTO> aOpciones(List<Object[]> filas) {
        return filas.stream()
                .map(f -> new OpcionFiltroDTO((Long) f[0], (String) f[1], (Long) f[2]))
                .toList();
    }

    public ProductoResponseDTO getProductoById(Long id) {
        return toDTO(obtenerProducto(id));
    }

    // Productos publicados por el usuario autenticado
    public List<ProductoResponseDTO> getProductosDelVendedor(String email) {
        return productoRepository.findByVendedorEmailOrderByNombreAsc(email)
                .stream()
                .map(this::toDTO)
                .toList();
    }

    public ProductoResponseDTO createProducto(ProductoRequestDTO productoRequest, String email) {
        validarPrecio(productoRequest.getPrecio());
        validarStock(productoRequest.getStock());

        Producto producto = new Producto();
        producto.setNombre(productoRequest.getNombre());
        producto.setDescription(productoRequest.getDescripcion());
        producto.setPrecio(productoRequest.getPrecio());
        producto.setStock(productoRequest.getStock());
        producto.setCategoria(obtenerCategoria(productoRequest.getCategoriaId()));
        // El vendedor es siempre el usuario del token, nunca un dato del body
        producto.setVendedor(obtenerUsuario(email));

        return toDTO(productoRepository.save(producto));
    }

    public ProductoResponseDTO updateProducto(Long id, ProductoRequestDTO productoRequest, String email) {
        validarPrecio(productoRequest.getPrecio());
        validarStock(productoRequest.getStock());

        Producto producto = obtenerProducto(id);
        validarDueno(producto, email);

        producto.setNombre(productoRequest.getNombre());
        producto.setDescription(productoRequest.getDescripcion());
        producto.setPrecio(productoRequest.getPrecio());
        producto.setStock(productoRequest.getStock());
        producto.setCategoria(obtenerCategoria(productoRequest.getCategoriaId()));

        return toDTO(productoRepository.save(producto));
    }

    public ProductoResponseDTO actualizarStock(Long id, Integer stock, String email) {
        validarStock(stock);

        Producto producto = obtenerProducto(id);
        validarDueno(producto, email);

        producto.setStock(stock);
        return toDTO(productoRepository.save(producto));
    }

    public void eliminarProducto(Long id, String email) {
        Producto producto = obtenerProducto(id);
        validarDueno(producto, email);

        // Si ya se vendió, borrarlo rompería el histórico de órdenes (FK de orden_items)
        if (ordenItemRepository.existsByProductoId(id)) {
            throw new ProductoConVentasException();
        }

        // Primero se saca de los carritos que lo tengan: si no, borrarlo violaría
        // la FK de carrito_productos. Todo corre en la misma transacción (@Transactional)
        carritoProductosRepository.deleteByProductoId(id);
        favoritoRepository.deleteByProductoId(id);
        productoRepository.delete(producto);
    }

    // Autorización por dueño del recurso: además del rol (SecurityConfig),
    // se valida que el usuario del token sea el vendedor del producto, o un ADMIN
    private void validarDueno(Producto producto, String email) {
        Usuario usuario = obtenerUsuario(email);
        boolean esAdmin = usuario.getRole() == Role.ADMIN;
        boolean esDueno = producto.getVendedor() != null
                && producto.getVendedor().getId().equals(usuario.getId());
        if (!esAdmin && !esDueno) {
            throw new ProductoNoPropioException();
        }
    }

    private void validarPrecio(double precio) {
        if (precio < 0) {
            throw new PrecioNegativoException();
        }
    }

    private void validarStock(Integer stock) {
        if (stock == null || stock < 0) {
            throw new StockInvalidoException();
        }
    }

    private Producto obtenerProducto(Long id) {
        return productoRepository.findById(id)
                .orElseThrow(() -> new ProductoNotFoundException(id));
    }

    private Categoria obtenerCategoria(Long categoriaId) {
        return categoriaRepository.findById(categoriaId)
                .orElseThrow(() -> new CategoriaNotFoundException(categoriaId));
    }

    private Usuario obtenerUsuario(String email) {
        return usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new UsuarioNotFoundException(email));
    }

    // Convierte la entidad en el DTO que se expone en la API
    private ProductoResponseDTO toDTO(Producto producto) {
        return new ProductoResponseDTO(
                producto.getId(),
                producto.getNombre(),
                producto.getDescription(),
                producto.getPrecio(),
                producto.getStock(),
                producto.getStock() > 0,
                producto.getCategoria().getId(),
                producto.getCategoria().getNombre(),
                producto.getVendedor() != null ? producto.getVendedor().getNombreUsuario() : null);
    }
}
