package com.uade.tpo.e_commerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// Datos que envía el cliente para crear o modificar un producto.
// El vendedor no viaja en el body: se toma del token del usuario autenticado
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductoRequestDTO {
    private String nombre;
    private String descripcion;
    private double precio;
    private Integer stock;
    private Long categoriaId;
}
