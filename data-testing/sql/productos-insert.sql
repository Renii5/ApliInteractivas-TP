-- ============================================================
-- 3) Productos (ecommerce_db3)
-- Requiere haber corrido antes usuarios-insert.sql y categorias-insert.sql
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/productos-insert.sql
-- ============================================================
--
-- Vendedores: Juan (id 3) y Lucia (id 4).
-- El producto 9 tiene stock 0 a propósito, para probar "disponible": false
-- y el error al agregarlo al carrito.
-- ============================================================

SET NAMES utf8mb4;

DELETE FROM orden_items;
DELETE FROM carrito_productos;
DELETE FROM productos;

INSERT INTO productos (id, nombre, description, precio, stock, categoria_id, vendedor_id) VALUES
    ( 1, 'RTX 4070',              'GPU 12GB GDDR6X, DLSS 3',           850000,  5, 1, 3),
    ( 2, 'Mouse inalambrico',     '6 botones, 16000 DPI',               22000, 10, 5, 3),
    ( 3, 'Teclado mecanico',      'Switches rojos, 87 teclas, RGB',     45000,  3, 5, 3),
    ( 4, 'Ryzen 7 7800X3D',       '8 nucleos, 16 hilos, AM5',          520000,  4, 2, 3),
    ( 5, 'Monitor 27 pulgadas',   'QHD 2560x1440, 165Hz, IPS',         380000,  2, 6, 3),
    ( 6, 'RX 7800 XT',            'GPU 16GB GDDR6',                    700000,  6, 1, 4),
    ( 7, 'Memoria RAM 32GB DDR5', '2x16GB, 6000 MHz CL30',             150000,  8, 3, 4),
    ( 8, 'SSD NVMe 1TB',          'Lectura 7000 MB/s, M.2 2280',       125000, 12, 4, 4),
    ( 9, 'Intel Core i5 14600K',  '14 nucleos, LGA1700',               390000,  0, 2, 4),
    (10, 'Auriculares gamer',     'Sonido 7.1, microfono desmontable',  60000,  7, 5, 4);

ALTER TABLE productos AUTO_INCREMENT = 11;
