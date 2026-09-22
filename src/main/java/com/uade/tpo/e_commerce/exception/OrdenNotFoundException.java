package com.uade.tpo.e_commerce.exception;

// Orden inexistente o de otro usuario: en ambos casos 404, para no revelar órdenes ajenas
public class OrdenNotFoundException extends RuntimeException {

    public OrdenNotFoundException(Long id) {
        super("No se encontró la orden con id: " + id);
    }
}
