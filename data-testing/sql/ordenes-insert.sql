-- ============================================================
-- 5) Órdenes (opcional) (ecommerce_db3)
-- Cada orden es una compra con su comprador y uno o más ítems.
-- Requiere haber corrido antes usuarios-insert.sql y productos-insert.sql
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/ordenes-insert.sql
-- ============================================================
--
-- Son compras pasadas: el stock de productos-insert.sql ya las tiene descontadas.
-- - Orden 1: Maria compra 1 SSD NVMe 1TB (de Lucia)
-- - Orden 2: Lucia compra 1 Teclado mecanico y 1 Mouse inalambrico (de Juan)
-- ============================================================

SET NAMES utf8mb4;

DELETE FROM orden_items;
DELETE FROM ordenes;

-- El total tiene que coincidir con la suma de los ítems
INSERT INTO ordenes (id, fecha, total, comprador_id) VALUES
    (1, '2026-09-15 10:30:00', 125000, 1),
    (2, '2026-09-18 18:45:00',  67000, 4);

-- precio_unitario es el precio al momento de la compra, no el precio actual del producto
INSERT INTO orden_items (id, orden_id, producto_id, cantidad, precio_unitario) VALUES
    (1, 1, 8, 1, 125000),
    (2, 2, 3, 1,  45000),
    (3, 2, 2, 1,  22000);

ALTER TABLE ordenes AUTO_INCREMENT = 3;
ALTER TABLE orden_items AUTO_INCREMENT = 4;
