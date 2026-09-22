package com.uade.tpo.e_commerce.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProductoResponseDTO {
    private Long id;
    private String nombre;
    private String descripcion;
    private double precio;
    private Integer stock;
    // stock > 0: la consigna pide que se vea cuando un producto no tiene stock
    private boolean disponible;
    private Long categoriaId;
    private String categoriaNombre;
    // Nombre de usuario de quien publicó el producto
    private String vendedor;
}
