package com.uade.tpo.e_commerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.Ventas;

/**
 * JPA Repository para la entidad Ventas, proporciona métodos CRUD
 * y consultas personalizadas a la DB, de la tabla Ventas.
 * Minimiza el código boilerplate porque no hay que implementar el CRUD básico.
 * VentasRepository 
 */
public interface VentasRepository extends JpaRepository<Ventas, Long> {
    // save, findAll, findById, deleteById, etc. ya vienen implementados por JpaRepository
}
