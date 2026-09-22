package com.uade.tpo.e_commerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Body del PATCH /api/productos/{id}/stock
@Data
@NoArgsConstructor
@AllArgsConstructor
public class StockRequestDTO {
    private Integer stock;
}
