package com.uade.tpo.e_commerce.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.dto.ProductoRequestDTO;
import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
import com.uade.tpo.e_commerce.exception.CategoriaNotFoundException;
import com.uade.tpo.e_commerce.exception.PrecioNegativoException;
import com.uade.tpo.e_commerce.exception.ProductoEnUsoException;
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
import com.uade.tpo.e_commerce.repository.ProductoRepository;
import com.uade.tpo.e_commerce.repository.UsuarioRepository;

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

    public ProductoService(ProductoRepository productoRepository,
                           CategoriaRepository categoriaRepository,
                           UsuarioRepository usuarioRepository,
                           CarritoProductosRepository carritoProductosRepository) {
        this.productoRepository = productoRepository;
        this.categoriaRepository = categoriaRepository;
        this.usuarioRepository = usuarioRepository;
        this.carritoProductosRepository = carritoProductosRepository;
    }

    // Listado ordenado alfabéticamente, con filtro opcional por categoría o por nombre
    public List<ProductoResponseDTO> getAllProductos(Long categoriaId, String busqueda) {
        List<Producto> productos;
        if (categoriaId != null) {
            productos = productoRepository.findByCategoriaIdOrderByNombreAsc(categoriaId);
        } else if (busqueda != null && !busqueda.isBlank()) {
            productos = productoRepository.findByNombreContainingIgnoreCaseOrderByNombreAsc(busqueda);
        } else {
            productos = productoRepository.findAllByOrderByNombreAsc();
        }
        return productos.stream().map(this::toDTO).toList();
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

        // Si está en algún carrito, borrarlo violaría la FK de carrito_productos: se responde 409
        if (carritoProductosRepository.existsByProductoId(id)) {
            throw new ProductoEnUsoException(id);
        }
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
