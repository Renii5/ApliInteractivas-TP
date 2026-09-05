package com.uade.tpo.e_commerce.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.Categoria;


public interface CategoriaRepository extends JpaRepository<Categoria, Long> {
    
}
