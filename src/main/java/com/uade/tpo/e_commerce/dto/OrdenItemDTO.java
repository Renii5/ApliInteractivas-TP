package com.uade.tpo.e_commerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Un renglón de una orden, con el precio que tenía el producto al momento de la compra
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrdenItemDTO {
    private Long productoId;
    private String nombre;
    private double precioUnitario;
    private Integer cantidad;
    private double subtotal;
}
