package com.uade.tpo.e_commerce.exception;

public class ContrasenaIncorrectaException extends RuntimeException {

    public ContrasenaIncorrectaException() {
        super("La contraseña es incorrecta");
    }
}