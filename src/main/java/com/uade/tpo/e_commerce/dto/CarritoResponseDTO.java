package com.uade.tpo.e_commerce.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Respuesta de GET /api/carrito: ítems con subtotales y el total del carrito
@Data
@NoArgsConstructor
@AllArgsConstructor
public class CarritoResponseDTO {
    private Long carritoId;
    private List<CarritoItemDTO> items;
    private double total;
}
