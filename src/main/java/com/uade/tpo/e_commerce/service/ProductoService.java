package com.uade.tpo.e_commerce.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.dto.ProductoRequestDTO;
import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
import com.uade.tpo.e_commerce.exception.CategoriaNotFoundException;
import com.uade.tpo.e_commerce.exception.PrecioNegativoException;
import com.uade.tpo.e_commerce.exception.ProductoNotFoundException;
import com.uade.tpo.e_commerce.model.Categoria;
import com.uade.tpo.e_commerce.model.Producto;
import com.uade.tpo.e_commerce.repository.CategoriaRepository;
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
    private final CategoriaRepository categoriaRepository;

    public ProductoService(ProductoRepository productoRepository,
                            CategoriaRepository categoriaRepository) {
        this.productoRepository = productoRepository;
        this.categoriaRepository = categoriaRepository;
    }

    public List<ProductoResponseDTO> getAllProductos() {
        // return productoRepository.findAllProductosResponse();
        System.out.println("\n\nSERVICE >> Fetching all productos DTO\n\n");
        return productoRepository.findAll().stream()
                        .map(producto -> new ProductoResponseDTO(
                                producto.getId(),
                                producto.getNombre(),
                            producto.getDescription(),
                            producto.getPrecio(),
                            producto.getCategoria().getId(),
                            producto.getCategoria().getNombre()
                        ))
                        .toList();

    }
        public void eliminarProducto(Long id) {
        if (!productoRepository.existsById(id)) {
            throw new ProductoNotFoundException("Producto no encontrado con ID: " + id);
        }
        productoRepository.deleteById(id);
    }

    public ProductoResponseDTO createProducto(ProductoRequestDTO productoRequest) {
    if (productoRequest.getPrecio() < 0) {
        throw new PrecioNegativoException();
    }

    Producto producto = new Producto();
        Categoria categoria = categoriaRepository.findById(productoRequest.getCategoriaId())
            .orElseThrow(() -> new CategoriaNotFoundException(productoRequest.getCategoriaId()));
    producto.setNombre(productoRequest.getNombre());
    producto.setDescription(productoRequest.getDescripcion()); 
    producto.setPrecio(productoRequest.getPrecio());
        producto.setCategoria(categoria);

    Producto productoGuardado = productoRepository.save(producto);

    return new ProductoResponseDTO(
            productoGuardado.getId(),
            productoGuardado.getNombre(),
            productoGuardado.getDescription(),
            productoGuardado.getPrecio(),
            productoGuardado.getCategoria().getId(),
            productoGuardado.getCategoria().getNombre()
    );
}

            public ProductoResponseDTO updateProducto(Long id, ProductoRequestDTO productoRequest) {
            if (productoRequest.getPrecio() < 0) {
                throw new PrecioNegativoException();
            }

            Producto producto = productoRepository.findById(id)
                .orElseThrow(() -> new ProductoNotFoundException("Producto no encontrado con ID: " + id));
            Categoria categoria = categoriaRepository.findById(productoRequest.getCategoriaId())
                .orElseThrow(() -> new CategoriaNotFoundException(productoRequest.getCategoriaId()));

            producto.setNombre(productoRequest.getNombre());
            producto.setDescription(productoRequest.getDescripcion());
            producto.setPrecio(productoRequest.getPrecio());
            producto.setCategoria(categoria);

            Producto productoActualizado = productoRepository.save(producto);
            return new ProductoResponseDTO(
                productoActualizado.getId(),
                productoActualizado.getNombre(),
                productoActualizado.getDescription(),
                productoActualizado.getPrecio(),
                productoActualizado.getCategoria().getId(),
                productoActualizado.getCategoria().getNombre()
            );
            }

}
