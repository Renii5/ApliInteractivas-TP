package com.uade.tpo.e_commerce.exception;

// Hereda de IllegalArgumentException, así el handler que ya existe la responde con 400
public class CarritoVacioException extends IllegalArgumentException {

    public CarritoVacioException() {
        super("El carrito está vacío, no se puede realizar el checkout");
    }
}
