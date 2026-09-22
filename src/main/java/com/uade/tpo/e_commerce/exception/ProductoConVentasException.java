package com.uade.tpo.e_commerce.exception;

// Un producto que ya figura en órdenes no se puede borrar sin romper el histórico (409)
public class ProductoConVentasException extends RuntimeException {

    public ProductoConVentasException() {
        super("No se puede eliminar un producto que ya fue vendido. Puede dejarlo con stock 0");
    }
}
