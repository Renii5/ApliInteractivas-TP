package com.uade.tpo.e_commerce.dto;

import java.time.LocalDateTime;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Respuesta del checkout, de "mis compras" y del histórico de ventas
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrdenResponseDTO {
    private Long id;
    private LocalDateTime fecha;
    // Email de quien realizó la compra
    private String comprador;
    private List<OrdenItemDTO> items;
    private double total;
}
