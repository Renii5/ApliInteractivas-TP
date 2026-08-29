package com.uade.tpo.e_commerce.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "ventas")
public class Ventas {

    /*
    replico esto: 
            CREATE TABLE IF NOT EXISTS ventas (
            id               INT AUTO_INCREMENT PRIMARY KEY,
            producto_id      BIGINT NOT NULL,
            cantidad         INT NOT NULL,
            precio_unitario  DECIMAL(10,2) NOT NULL,
            fecha            DATETIME NOT NULL,
            CONSTRAINT fk_ventas_producto
                FOREIGN KEY (producto_id) REFERENCES productos(id)
                ON DELETE CASCADE
        );
    
    
    */

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private Long productoId;

    @Column(nullable = false)
    private int cantidad;

    @Column(nullable = false)
    private double precioUnitario;

    @Column(nullable = false)
    private java.time.LocalDateTime fecha;

}
