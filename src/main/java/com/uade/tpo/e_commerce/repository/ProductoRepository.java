package com.uade.tpo.e_commerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.Producto;

/**
 * JPA Repository para la entidad Producto, proporciona métodos CRUD
 * y consultas personalizadas a la DB, de la tabla Productos.
 * Minimiza el código boilerplate porque no hay que implementar el CRUD básico.
 * ProductoRepository
 */
public interface ProductoRepository extends JpaRepository<Producto, Long> {
    // save, findAll, findById, deleteById, etc. ya vienen implementados por JpaRepository
}
