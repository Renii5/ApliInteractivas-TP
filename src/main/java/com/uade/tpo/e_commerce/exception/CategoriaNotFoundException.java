package com.uade.tpo.e_commerce.exception;

public class CategoriaNotFoundException extends RuntimeException {

    public CategoriaNotFoundException(Long id) {
        super("No se encontró la categoría con id: " + id);
    }
}