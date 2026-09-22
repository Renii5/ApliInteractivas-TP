package com.uade.tpo.e_commerce.exception;

// Se lanza cuando un usuario intenta modificar o eliminar un producto que no publicó (403)
public class ProductoNoPropioException extends RuntimeException {

    public ProductoNoPropioException() {
        super("Solo el vendedor del producto puede modificarlo o eliminarlo");
    }
}
