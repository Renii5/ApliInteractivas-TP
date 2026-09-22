package com.uade.tpo.e_commerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.OrdenItem;

/**
 * JPA Repository para la entidad OrdenItem.
 * OrdenItemRepository
 */
public interface OrdenItemRepository extends JpaRepository<OrdenItem, Long> {

    // Si un producto ya fue vendido no se puede borrar: rompería el histórico de órdenes
    boolean existsByProductoId(Long productoId);
}
