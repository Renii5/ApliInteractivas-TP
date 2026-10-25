package com.uade.tpo.e_commerce.exception;

// Se lanza cuando el archivo subido como imagen de producto falta o no es una imagen aceptada (400)
public class ImagenInvalidaException extends RuntimeException {

    public ImagenInvalidaException(String mensaje) {
        super(mensaje);
    }
}
