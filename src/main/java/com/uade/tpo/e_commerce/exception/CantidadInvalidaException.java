package com.uade.tpo.e_commerce.exception;

// Hereda de IllegalArgumentException, así el handler que ya existe la responde con 400
public class CantidadInvalidaException extends IllegalArgumentException {

    public CantidadInvalidaException() {
        super("La cantidad es obligatoria y debe ser mayor a 0");
    }
}
