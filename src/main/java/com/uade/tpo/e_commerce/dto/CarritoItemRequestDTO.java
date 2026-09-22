package com.uade.tpo.e_commerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Body del POST /api/carrito/items
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CarritoItemRequestDTO {
    private Long productoId;
    private Integer cantidad;
}
