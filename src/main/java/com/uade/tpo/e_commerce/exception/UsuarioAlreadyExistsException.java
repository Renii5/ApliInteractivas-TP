package com.uade.tpo.e_commerce.exception;

public class UsuarioAlreadyExistsException extends RuntimeException {

    public UsuarioAlreadyExistsException(String email) {
        super("Ya existe un usuario registrado con el email: " + email);
    }
}