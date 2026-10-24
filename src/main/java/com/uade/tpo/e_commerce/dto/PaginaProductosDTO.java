package com.uade.tpo.e_commerce.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Respuesta del listado de productos: una página + totales para "Selected Products: N" y el paginador
@Data
@NoArgsConstructor
@AllArgsConstructor
public class PaginaProductosDTO {
    private List<ProductoResponseDTO> productos;
    // Total de productos que cumplen los filtros (no solo los de la página)
    private long totalProductos;
    private int totalPaginas;
    // Página devuelta (base 1) y tamaño usado
    private int pagina;
    private int tamanio;
}
