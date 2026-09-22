package com.uade.tpo.e_commerce.exception;

// Se lanza cuando se pide más cantidad de la que hay en stock (409)
public class StockInsuficienteException extends RuntimeException {

    public StockInsuficienteException(String producto, int disponible) {
        super("Stock insuficiente para \"" + producto + "\". Disponible: " + disponible);
    }
}
