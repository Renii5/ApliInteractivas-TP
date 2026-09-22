-- ============================================================
-- Poblado de prueba para ordenes y orden_items (ecommerce_db3)
-- Reemplaza al viejo ventas-insert.sql: ahora cada venta es una orden
-- con comprador y uno o más ítems. Las tablas las crea Hibernate.
-- Requiere que existan los usuarios (registrados por la API) y los
-- productos referenciados por nombre.
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/ordenes-insert.sql
-- ============================================================

SET NAMES utf8mb4;

DELETE FROM orden_items;
DELETE FROM ordenes;
ALTER TABLE orden_items AUTO_INCREMENT = 1;
ALTER TABLE ordenes AUTO_INCREMENT = 1;

-- El total se guarda en la orden; tiene que coincidir con la suma de sus ítems
INSERT INTO ordenes (id, fecha, total, comprador_id) VALUES
    (1, '2026-06-02 10:15:00', 112001.00, (SELECT id FROM usuarios WHERE email = 'juan.perez@example.com')),
    (2, '2026-06-05 09:00:00', 380000.00, (SELECT id FROM usuarios WHERE email = 'maria.gonzalez@example.com')),
    (3, '2026-06-10 18:30:00', 250000.00, (SELECT id FROM usuarios WHERE email = 'juan.perez@example.com'));

-- precio_unitario es el precio al momento de la compra, no el precio actual del producto
INSERT INTO orden_items (orden_id, producto_id, cantidad, precio_unitario) VALUES
    (1, (SELECT id FROM productos WHERE nombre = 'Teclado mecánico RGB'), 2,  45000.50),
    (1, (SELECT id FROM productos WHERE nombre = 'Mouse inalámbrico'),    1,  22000.00),
    (2, (SELECT id FROM productos WHERE nombre = 'Monitor 27 pulgadas'),  1, 380000.00),
    (3, (SELECT id FROM productos WHERE nombre = 'Disco SSD NVMe 1TB'),   2, 125000.00);
