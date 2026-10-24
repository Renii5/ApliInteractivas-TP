package com.uade.tpo.e_commerce.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

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
    @JsonProperty("image_url")
    private String imageUrl;
    private double precio;
    private Integer stock;
    // stock > 0: la consigna pide que se vea cuando un producto no tiene stock
    private boolean disponible;
    private Long categoriaId;
    private String categoriaNombre;
    // Nombre de usuario de quien publicó el producto
    private String vendedor;
}
