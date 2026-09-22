package com.uade.tpo.e_commerce.model;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

/**
 * Orden de compra generada en el checkout. Reemplaza a la vieja entidad Ventas:
 * ahora cada venta sabe quién compró y agrupa todos los productos de esa compra.
 * Orden
 */
@Getter
@Setter
@NoArgsConstructor
@Entity
@Table(name = "ordenes")
public class Orden {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private LocalDateTime fecha;

    @Column(nullable = false)
    private double total;

    @ManyToOne(optional = false)
    @JoinColumn(name = "comprador_id", nullable = false)
    private Usuario comprador;

    // cascade = ALL: al guardar la orden se guardan también sus ítems, sin repositorio aparte.
    // mappedBy indica que la FK está del lado de OrdenItem (columna orden_id)
    @OneToMany(mappedBy = "orden", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrdenItem> items = new ArrayList<>();

    // Mantiene sincronizados los dos lados de la relación bidireccional
    public void agregarItem(OrdenItem item) {
        item.setOrden(this);
        items.add(item);
    }
}
