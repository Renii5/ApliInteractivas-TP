package com.uade.tpo.e_commerce.model;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.annotations.BatchSize;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.OrderBy;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "productos")
public class Producto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String nombre;

    @Column
    private String description;

    @Column
    private double precio;

    @Column(nullable = false)
    private Integer stock;

    @ManyToOne(optional = false)
    @JoinColumn(name = "categoria_id", nullable = false)
    private Categoria categoria;

    // Usuario que publicó el producto. Se asigna desde el token, nunca desde el
    // body.
    // Es nullable para no romper los productos que ya existían antes de agregar la
    // columna
    @ManyToOne
    @JoinColumn(name = "vendedor_id")
    private Usuario vendedor;

    // Fotos del producto (relación 1:N con la tabla producto_imagenes).
    // - mappedBy: la FK (producto_id) está del lado de ProductoImagen.
    // - LAZY: las imágenes se traen solo cuando se piden con getImagenes().
    // - cascade ALL + orphanRemoval: al guardar/borrar el producto se guardan/borran sus imágenes,
    //   y una imagen que se saca de la lista se borra de la base (sin repositorio aparte).
    // - BatchSize: en el listado del catálogo trae las imágenes de toda la página en una sola consulta
    //   (en lugar de una consulta por producto, el problema "N+1").
    // - Los Exclude evitan que toString/hashCode de @Data se llamen en bucle entre Producto y ProductoImagen.
    @OneToMany(mappedBy = "producto", fetch = FetchType.LAZY, cascade = CascadeType.ALL, orphanRemoval = true)
    @OrderBy("orden ASC")
    @BatchSize(size = 50)
    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    private List<ProductoImagen> imagenes = new ArrayList<>();

    /**
     * Reemplaza las imágenes del producto por las URLs recibidas, en ese orden (la primera es la principal).
     * Se vacía la misma lista (clear) en lugar de asignar una nueva: con orphanRemoval Hibernate necesita
     * seguir la colección original para saber qué filas borrar.
     */
    public void reemplazarImagenes(List<String> urls) {
        imagenes.clear();
        for (int i = 0; i < urls.size(); i++) {
            ProductoImagen imagen = new ProductoImagen(urls.get(i), i);
            // Mantiene sincronizados los dos lados de la relación bidireccional
            imagen.setProducto(this);
            imagenes.add(imagen);
        }
    }

    /**
     * URL de la imagen principal (la primera), o null si el producto no tiene imágenes.
     * Es la que usan las tarjetas, el carrito, las órdenes y los favoritos.
     */
    public String getImagenPrincipal() {
        return imagenes.isEmpty() ? null : imagenes.get(0).getUrl();
    }
}
