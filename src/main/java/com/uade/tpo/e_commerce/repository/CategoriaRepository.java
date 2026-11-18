package com.uade.tpo.e_commerce.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.Categoria;


public interface CategoriaRepository extends JpaRepository<Categoria, Long> {

    // Query method: Spring arma el SELECT ... ORDER BY nombre ASC a partir del nombre del método
    List<Categoria> findAllByOrderByNombreAsc();
}
