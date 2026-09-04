package com.uade.tpo.e_commerce.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.model.Producto;
import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
import com.uade.tpo.e_commerce.repository.ProductoRepository;

import jakarta.transaction.Transactional;

/**
 * Capa donde reside la lógica de negocio y donde se manejan las transacciones.
 * ProductoService
 */
@Service
@Transactional
public class ProductoService {

    private final ProductoRepository productoRepository;

    ProductoService(ProductoRepository productoRepository) {
        this.productoRepository = productoRepository;
    }

    public List<ProductoResponseDTO> getAllProductos() {
        // return productoRepository.findAllProductosResponse();
        System.out.println("\n\nSERVICE >> Fetching all productos DTO\n\n");
        return productoRepository.findAll().stream()
                        .map(producto -> new ProductoResponseDTO(
                                producto.getId(),
                                producto.getNombre(),
                                producto.getDescription()
                        ))
                        .toList();

    }
        public void eliminarProducto(Long id) {
        if (!productoRepository.existsById(id)) {
            throw new ProductoNotFoundException("Producto no encontrado con ID: " + id);
        }
        productoRepository.deleteById(id);
    }

}
