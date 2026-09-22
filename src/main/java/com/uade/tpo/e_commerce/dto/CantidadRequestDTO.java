package com.uade.tpo.e_commerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Body del PUT /api/carrito/items/{productoId}
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CantidadRequestDTO {
    private Integer cantidad;
}
