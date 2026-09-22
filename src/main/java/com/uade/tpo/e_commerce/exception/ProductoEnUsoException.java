package com.uade.tpo.e_commerce.exception;

// Se lanza al intentar borrar un producto que está cargado en algún carrito (409)
public class ProductoEnUsoException extends RuntimeException {

    public ProductoEnUsoException(Long id) {
        super("No se puede eliminar el producto " + id + " porque está en carritos de compra");
    }
}
