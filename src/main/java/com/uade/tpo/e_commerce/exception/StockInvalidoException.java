package com.uade.tpo.e_commerce.exception;

// Hereda de IllegalArgumentException (igual que PrecioNegativoException),
// así el handler que ya existe la responde con 400 sin agregar nada
public class StockInvalidoException extends IllegalArgumentException {

    public StockInvalidoException() {
        super("El stock es obligatorio y no puede ser negativo");
    }
}
