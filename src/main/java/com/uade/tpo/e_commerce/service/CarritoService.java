package com.uade.tpo.e_commerce.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.uade.tpo.e_commerce.model.CarritoProductos;
import com.uade.tpo.e_commerce.model.Producto;
import com.uade.tpo.e_commerce.repository.CarritoProductosRepository;
import com.uade.tpo.e_commerce.repository.CarritoRepository;

import jakarta.transaction.Transactional;

/**
 * Capa donde reside la lógica de negocio y donde se manejan las transacciones.
 * CarritoService
 */
@Service
@Transactional
public class CarritoService {

    private final CarritoRepository carritoRepository;
    private final CarritoProductosRepository carritoProductosRepository;

    CarritoService(CarritoRepository carritoRepository,
                   CarritoProductosRepository carritoProductosRepository) {
        this.carritoRepository = carritoRepository;
        this.carritoProductosRepository = carritoProductosRepository;
    }

    /**
     * Devuelve los productos que contiene un carrito.
     * Si el carrito no existe se responde 404, para distinguirlo
     * de un carrito que existe pero está vacío (lista vacía).
     */
    public List<Producto> getProductosDelCarrito(Long carritoId) {
        if (!carritoRepository.existsById(carritoId)) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND,
                    "No existe el carrito con id " + carritoId);
        }

        // Cada fila de la tabla intermedia ya trae su Producto asociado
        return carritoProductosRepository.findByCarritoId(carritoId)
                .stream()
                .map(CarritoProductos::getProducto)
                .toList();
    }

}
