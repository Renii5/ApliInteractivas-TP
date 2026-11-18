package com.uade.tpo.e_commerce.dto;

import java.util.List;

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
    // URLs de las fotos, en orden (la primera es la principal). Se obtienen subiendo cada archivo
    // a POST /api/productos/imagen, o pueden ser URLs externas. Entre 1 y 6.
    private List<String> imagenes;
    private double precio;
    private Integer stock;
    private Long categoriaId;
}
