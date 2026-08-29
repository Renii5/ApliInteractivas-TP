package com.uade.tpo.e_commerce.exception;

public class carritoNotFoundException extends RuntimeException {
    
    public carritoNotFoundException(Long id) {
        super("No se encontró el carrito con id: " + id);
    }

    // Constructor: Acepta cualquier String como mensaje.
    public carritoNotFoundException(String message) {
        super(message);
    }    
}
