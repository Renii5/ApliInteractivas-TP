package com.uade.tpo.e_commerce.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.dto.CarritoItemDTO;
import com.uade.tpo.e_commerce.dto.CarritoResponseDTO;
import com.uade.tpo.e_commerce.dto.OrdenResponseDTO;
import com.uade.tpo.e_commerce.exception.CantidadInvalidaException;
import com.uade.tpo.e_commerce.exception.CarritoVacioException;
import com.uade.tpo.e_commerce.exception.ProductoNoEnCarritoException;
import com.uade.tpo.e_commerce.exception.ProductoNotFoundException;
import com.uade.tpo.e_commerce.exception.StockInsuficienteException;
import com.uade.tpo.e_commerce.exception.UsuarioNotFoundException;
import com.uade.tpo.e_commerce.model.Carrito;
import com.uade.tpo.e_commerce.model.CarritoProductos;
import com.uade.tpo.e_commerce.model.Orden;
import com.uade.tpo.e_commerce.model.OrdenItem;
import com.uade.tpo.e_commerce.model.Producto;
import com.uade.tpo.e_commerce.repository.CarritoProductosRepository;
import com.uade.tpo.e_commerce.repository.CarritoRepository;
import com.uade.tpo.e_commerce.repository.OrdenRepository;
import com.uade.tpo.e_commerce.repository.ProductoRepository;
import com.uade.tpo.e_commerce.repository.UsuarioRepository;

import jakarta.transaction.Transactional;

/**
 * Capa donde reside la lógica de negocio y donde se manejan las transacciones.
 * Todas las operaciones trabajan sobre el carrito del usuario autenticado:
 * el email llega desde el token, nunca como parámetro de la URL.
 * CarritoService
 */
@Service
@Transactional
public class CarritoService {

    private final CarritoRepository carritoRepository;
    private final CarritoProductosRepository carritoProductosRepository;
    private final ProductoRepository productoRepository;
    private final UsuarioRepository usuarioRepository;
    private final OrdenRepository ordenRepository;
    private final OrdenService ordenService;

    public CarritoService(CarritoRepository carritoRepository,
                          CarritoProductosRepository carritoProductosRepository,
                          ProductoRepository productoRepository,
                          UsuarioRepository usuarioRepository,
                          OrdenRepository ordenRepository,
                          OrdenService ordenService) {
        this.carritoRepository = carritoRepository;
        this.carritoProductosRepository = carritoProductosRepository;
        this.productoRepository = productoRepository;
        this.usuarioRepository = usuarioRepository;
        this.ordenRepository = ordenRepository;
        this.ordenService = ordenService;
    }

    // Devuelve el carrito del usuario con subtotales y total
    public CarritoResponseDTO getCarrito(String email) {
        return toDTO(obtenerOCrearCarrito(email));
    }

    /**
     * Agrega un producto al carrito. Si ya estaba, suma la cantidad.
     * La cantidad final no puede superar el stock del producto.
     */
    public CarritoResponseDTO agregarItem(String email, Long productoId, Integer cantidad) {
        validarCantidad(cantidad);
        Carrito carrito = obtenerOCrearCarrito(email);
        Producto producto = obtenerProducto(productoId);

        CarritoProductos item = carritoProductosRepository
                .findByCarritoIdAndProductoId(carrito.getId(), productoId)
                .orElse(new CarritoProductos(carrito, producto, 0));

        int nuevaCantidad = item.getCantidad() + cantidad;
        validarStock(producto, nuevaCantidad);

        item.setCantidad(nuevaCantidad);
        carritoProductosRepository.save(item);
        return toDTO(carrito);
    }

    // Reemplaza la cantidad de un producto que ya está en el carrito
    public CarritoResponseDTO modificarCantidad(String email, Long productoId, Integer cantidad) {
        validarCantidad(cantidad);
        Carrito carrito = obtenerOCrearCarrito(email);
        CarritoProductos item = obtenerItem(carrito, productoId);

        validarStock(item.getProducto(), cantidad);

        item.setCantidad(cantidad);
        carritoProductosRepository.save(item);
        return toDTO(carrito);
    }

    // Saca un producto del carrito
    public CarritoResponseDTO eliminarItem(String email, Long productoId) {
        Carrito carrito = obtenerOCrearCarrito(email);
        carritoProductosRepository.delete(obtenerItem(carrito, productoId));
        return toDTO(carrito);
    }

    // Vacía el carrito: borra los ítems pero el carrito se conserva
    public void vaciarCarrito(String email) {
        Carrito carrito = obtenerOCrearCarrito(email);
        carritoProductosRepository.deleteByCarritoId(carrito.getId());
    }

    /**
     * Checkout: convierte el carrito en una Orden.
     * Gracias a @Transactional (de la clase), todos los pasos son una sola transacción:
     * si alguno lanza una excepción se hace rollback y no queda stock descontado
     * ni una orden a medio crear.
     */
    public OrdenResponseDTO checkout(String email) {
        Carrito carrito = obtenerOCrearCarrito(email);
        List<CarritoProductos> items = carritoProductosRepository.findByCarritoId(carrito.getId());

        // 1. No se puede comprar un carrito vacío
        if (items.isEmpty()) {
            throw new CarritoVacioException();
        }

        // 2. Se valida el stock de todos los ítems antes de tocar nada
        for (CarritoProductos item : items) {
            validarStock(item.getProducto(), item.getCantidad());
        }

        Orden orden = new Orden();
        orden.setFecha(LocalDateTime.now());
        orden.setComprador(carrito.getUsuario());

        double total = 0;
        for (CarritoProductos item : items) {
            Producto producto = item.getProducto();

            // 3. Se descuenta el stock (Hibernate lo persiste al terminar la transacción)
            producto.setStock(producto.getStock() - item.getCantidad());

            // 4. Se crea el renglón de la orden con el precio de este momento
            OrdenItem ordenItem = new OrdenItem(producto, item.getCantidad(), producto.getPrecio());
            orden.agregarItem(ordenItem);
            total += ordenItem.getSubtotal();
        }
        orden.setTotal(total);

        // cascade = ALL en Orden.items: se guardan la orden y sus ítems juntos
        Orden guardada = ordenRepository.save(orden);

        // 5. Se vacía el carrito
        carritoProductosRepository.deleteByCarritoId(carrito.getId());

        // 6. Se devuelve la orden generada
        return ordenService.toDTO(guardada);
    }

    // Cada usuario tiene un único carrito: si todavía no lo tiene, se crea en ese momento
    private Carrito obtenerOCrearCarrito(String email) {
        return carritoRepository.findByUsuarioEmail(email)
                .orElseGet(() -> carritoRepository.save(new Carrito(
                        usuarioRepository.findByEmail(email)
                                .orElseThrow(() -> new UsuarioNotFoundException(email)))));
    }

    private CarritoProductos obtenerItem(Carrito carrito, Long productoId) {
        return carritoProductosRepository.findByCarritoIdAndProductoId(carrito.getId(), productoId)
                .orElseThrow(() -> new ProductoNoEnCarritoException(productoId));
    }

    private Producto obtenerProducto(Long productoId) {
        return productoRepository.findById(productoId)
                .orElseThrow(() -> new ProductoNotFoundException(productoId));
    }

    private void validarCantidad(Integer cantidad) {
        if (cantidad == null || cantidad <= 0) {
            throw new CantidadInvalidaException();
        }
    }

    private void validarStock(Producto producto, int cantidad) {
        if (cantidad > producto.getStock()) {
            throw new StockInsuficienteException(producto.getNombre(), producto.getStock());
        }
    }

    // Convierte el carrito en el DTO de respuesta, calculando subtotales y total
    private CarritoResponseDTO toDTO(Carrito carrito) {
        List<CarritoItemDTO> items = carritoProductosRepository.findByCarritoId(carrito.getId())
                .stream()
                .map(item -> {
                    Producto producto = item.getProducto();
                    return new CarritoItemDTO(
                            producto.getId(),
                            producto.getNombre(),
                            producto.getPrecio(),
                            item.getCantidad(),
                            producto.getPrecio() * item.getCantidad(),
                            producto.getStock());
                })
                .toList();

        double total = items.stream().mapToDouble(CarritoItemDTO::getSubtotal).sum();
        return new CarritoResponseDTO(carrito.getId(), items, total);
    }
}
