package com.uade.tpo.e_commerce.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Todo lo necesario para armar la barra lateral de filtros
@Data
@NoArgsConstructor
@AllArgsConstructor
public class FiltrosProductoDTO {
    private List<OpcionFiltroDTO> categorias;
    private List<OpcionFiltroDTO> vendedores;
    // null si no hay productos
    private Double precioMinimo;
    private Double precioMaximo;
    private long cantidadConStock;
}
