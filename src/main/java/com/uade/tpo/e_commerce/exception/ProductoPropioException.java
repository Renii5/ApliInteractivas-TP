package com.uade.tpo.e_commerce.exception;

// Se lanza cuando un usuario intenta comprar (carrito/checkout) o marcar como favorito
// un producto que él mismo publicó (403)
public class ProductoPropioException extends RuntimeException {

    public ProductoPropioException(String nombreProducto) {
        super("No podés comprar ni agregar a favoritos tu propio producto: " + nombreProducto);
    }
}
