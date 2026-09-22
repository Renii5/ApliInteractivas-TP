package com.uade.tpo.e_commerce.exception;

// Se lanza al modificar o sacar un producto que no está en el carrito (404)
public class ProductoNoEnCarritoException extends RuntimeException {

    public ProductoNoEnCarritoException(Long productoId) {
        super("El producto con id " + productoId + " no está en el carrito");
    }
}
