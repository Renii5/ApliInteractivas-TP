package com.uade.tpo.e_commerce.exception;

// Se lanza al intentar borrar una categoría que todavía tiene productos asociados (409)
public class CategoriaConProductosException extends RuntimeException {

    public CategoriaConProductosException(Long id) {
        super("No se puede eliminar la categoría " + id + " porque tiene productos asociados");
    }
}
