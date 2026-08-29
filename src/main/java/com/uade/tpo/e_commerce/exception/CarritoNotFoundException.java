package com.uade.tpo.e_commerce.exception;

public class CarritoNotFoundException extends RuntimeException {
    
    public CarritoNotFoundException(Long id) {
        super("No se encontró el carrito con id: " + id);
    }

    // Constructor: Acepta cualquier String como mensaje.
    public CarritoNotFoundException(String message) {
        super(message);
    }    
}
