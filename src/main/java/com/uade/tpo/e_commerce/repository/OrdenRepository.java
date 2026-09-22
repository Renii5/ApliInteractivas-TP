package com.uade.tpo.e_commerce.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.Orden;

/**
 * JPA Repository para la entidad Orden.
 * Los ítems se guardan en cascada con la orden, así que no hace falta
 * guardarlos por separado.
 * OrdenRepository
 */
public interface OrdenRepository extends JpaRepository<Orden, Long> {

    // Todas las órdenes, de la más reciente a la más vieja (histórico de ventas para ADMIN)
    List<Orden> findAllByOrderByFechaDesc();

    // "Mis compras": órdenes del usuario autenticado
    List<Orden> findByCompradorEmailOrderByFechaDesc(String email);

    // Detalle de una orden solo si pertenece al usuario: si no, vuelve vacío y se responde 404
    Optional<Orden> findByIdAndCompradorEmail(Long id, String email);
}
