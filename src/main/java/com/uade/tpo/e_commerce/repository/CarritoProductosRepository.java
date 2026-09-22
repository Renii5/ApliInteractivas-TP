package com.uade.tpo.e_commerce.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.CarritoProductos;

/**
 * JPA Repository de la tabla intermedia carrito_productos.
 * CarritoProductosRepository
 */
public interface CarritoProductosRepository extends JpaRepository<CarritoProductos, Long> {

    // Query Method: Spring Data navega la relación (carrito.id) y arma el join solo.
    // @EntityGraph trae el Producto en la misma consulta y evita el problema N+1.
    @EntityGraph(attributePaths = "producto")
    List<CarritoProductos> findByCarritoId(Long carritoId);

    // Busca un producto puntual dentro del carrito (para sumar cantidad, modificarlo o sacarlo)
    Optional<CarritoProductos> findByCarritoIdAndProductoId(Long carritoId, Long productoId);

    // Vacía el carrito: borra sus ítems pero conserva el carrito
    void deleteByCarritoId(Long carritoId);

    // Saca el producto de todos los carritos (se usa antes de borrar el producto)
    void deleteByProductoId(Long productoId);
}
