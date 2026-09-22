package com.uade.tpo.e_commerce.exception;

public class NombreUsuarioEnUsoException extends RuntimeException {
    public NombreUsuarioEnUsoException(String nombreUsuario) {
        super("El nombre de usuario ya está en uso: " + nombreUsuario);
    }
}