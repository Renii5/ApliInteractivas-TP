package com.uade.tpo.e_commerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Una foto de un producto. Un producto tiene una o más (relación 1:N):
 * del lado "muchos" va el @ManyToOne con la FK producto_id en esta tabla.
 * La de orden 0 es la imagen principal (la que se muestra en las tarjetas y el carrito).
 * ProductoImagen
 */
@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "producto_imagenes")
public class ProductoImagen {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    // URL con la que se sirve la imagen (ej: http://localhost:8080/images/<archivo>) o una URL externa
    @Column(nullable = false, length = 2048)
    private String url;

    // Posición dentro de la galería del producto: 0 = principal
    @Column(nullable = false)
    private Integer orden;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "producto_id", nullable = false)
    private Producto producto;

    public ProductoImagen(String url, Integer orden) {
        this.url = url;
        this.orden = orden;
    }
}
