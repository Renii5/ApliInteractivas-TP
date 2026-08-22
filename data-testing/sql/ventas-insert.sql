-- ============================================================
-- Creación y poblado de la tabla ventas (ecommerce_db3)
-- Las ventas se asocian a productos ya cargados por
-- data-testing/sql/productos-insert.sql (deben correrse primero).
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/ventas-insert.sql
-- ============================================================

SET NAMES utf8mb4;

-- La tabla se crea acá porque todavía no existe una entidad Venta
-- gestionada por Hibernate (a diferencia de productos).
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

-- Limpia la tabla y reinicia el contador de ids, para que el
-- script se pueda correr las veces que haga falta sin duplicar.
DELETE FROM ventas;
ALTER TABLE ventas AUTO_INCREMENT = 1;

-- Se referencia a cada producto por nombre (subquery) en lugar del id
-- numérico, para no depender del orden exacto en que haya quedado
-- cargada la tabla productos.
INSERT INTO ventas (producto_id, cantidad, precio_unitario, fecha) VALUES
    ((SELECT id FROM productos WHERE nombre = 'Teclado mecánico RGB'),        2, 45000.50,  '2026-06-02 10:15:00'),
    ((SELECT id FROM productos WHERE nombre = 'Mouse inalámbrico'),           1, 22000.00,  '2026-06-03 11:40:00'),
    ((SELECT id FROM productos WHERE nombre = 'Monitor 27 pulgadas'),         1, 380000.00, '2026-06-05 09:00:00'),
    ((SELECT id FROM productos WHERE nombre = 'Auriculares Bluetooth'),       3, 89990.00,  '2026-06-06 16:20:00'),
    ((SELECT id FROM productos WHERE nombre = 'Webcam Full HD'),              1, 54500.00,  '2026-06-08 13:05:00'),
    ((SELECT id FROM productos WHERE nombre = 'Disco SSD NVMe 1TB'),          2, 125000.00, '2026-06-10 18:30:00'),
    ((SELECT id FROM productos WHERE nombre = 'Memoria RAM 16GB DDR4'),       4, 78000.00,  '2026-06-12 12:00:00'),
    ((SELECT id FROM productos WHERE nombre = 'Placa de video RTX 4060'),     1, 890000.00, '2026-06-14 15:45:00'),
    ((SELECT id FROM productos WHERE nombre = 'Notebook 15.6 pulgadas'),      1, 1250000.00,'2026-06-15 10:10:00'),
    ((SELECT id FROM productos WHERE nombre = 'Silla gamer ergonómica'),      1, 320000.00, '2026-06-17 17:00:00'),
    ((SELECT id FROM productos WHERE nombre = 'Hub USB-C 7 en 1'),            5, 35900.00,  '2026-06-18 09:30:00'),
    ((SELECT id FROM productos WHERE nombre = 'Micrófono condensador USB'),   1, 96000.00,  '2026-06-19 14:15:00'),
    ((SELECT id FROM productos WHERE nombre = 'Parlante Bluetooth portátil'), 2, 67500.00,  '2026-06-20 11:00:00'),
    ((SELECT id FROM productos WHERE nombre = 'Cable HDMI 2.1 de 2m'),        6, 12500.00,  '2026-06-21 16:50:00'),
    ((SELECT id FROM productos WHERE nombre = 'Base para notebook'),          3, 28000.00,  '2026-06-22 10:40:00'),
    ((SELECT id FROM productos WHERE nombre = 'Teclado mecánico RGB'),        1, 45000.50,  '2026-06-25 12:25:00'),
    ((SELECT id FROM productos WHERE nombre = 'Monitor 27 pulgadas'),         2, 380000.00, '2026-06-27 09:55:00'),
    ((SELECT id FROM productos WHERE nombre = 'Notebook 15.6 pulgadas'),      1, 1250000.00,'2026-06-29 15:10:00');
