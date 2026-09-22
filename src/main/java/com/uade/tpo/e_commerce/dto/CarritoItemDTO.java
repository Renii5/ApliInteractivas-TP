package com.uade.tpo.e_commerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Un renglón del carrito, con su subtotal ya calculado
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CarritoItemDTO {
    private Long productoId;
    private String nombre;
    private double precioUnitario;
    private Integer cantidad;
    private double subtotal;
    // Stock actual del producto, para que el front avise si ya no alcanza
    private Integer stockDisponible;
}
