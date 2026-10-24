package com.uade.tpo.e_commerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Una opción de filtro (categoría o vendedor) con la cantidad de productos que tiene
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OpcionFiltroDTO {
    private Long id;
    private String nombre;
    private long cantidad;
}
