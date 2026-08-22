package com.uade.tpo.e_commerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.Carrito;

/**
 * JPA Repository para la entidad Carrito.
 * Se usa para verificar que el carrito exista antes de listar su contenido.
 * CarritoRepository
 */
public interface CarritoRepository extends JpaRepository<Carrito, Long> {
    // save, findAll, findById, deleteById, etc. ya vienen implementados por JpaRepository
}
