package com.uade.tpo.e_commerce.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.Carrito;

/**
 * JPA Repository para la entidad Carrito.
 * CarritoRepository
 */
public interface CarritoRepository extends JpaRepository<Carrito, Long> {

    // Query Method: navega la relación carrito.usuario.email.
    // Se usa para obtener el carrito del usuario autenticado (el email viene del token)
    Optional<Carrito> findByUsuarioEmail(String email);
}
