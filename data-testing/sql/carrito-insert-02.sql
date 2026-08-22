-- ============================================================
-- Poblado de prueba para carrito y carrito_productos (ecommerce_db3)
-- Requiere haber corrido antes productos-insert.sql (ids 1..15)
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/carrito-insert.sql
-- ============================================================

SET NAMES utf8mb4;

-- Primero la tabla intermedia, por si más adelante se agrega una FK
DELETE FROM carrito_productos;
DELETE FROM carrito;
ALTER TABLE carrito_productos AUTO_INCREMENT = 1;
ALTER TABLE carrito AUTO_INCREMENT = 1;

-- Tres carritos de tres usuarios distintos
INSERT INTO carrito (id, user_id) VALUES
    (1, 100),
    (2, 101),
    (3, 102);

-- Carrito 1: setup de escritorio (4 productos)
-- Carrito 2: un solo producto
-- Carrito 3: queda vacío a propósito, para probar la lista vacía
INSERT INTO carrito_productos (carrito_id, producto_id, cantidad) VALUES
    (1,  1, 1),   -- Teclado mecánico RGB
    (1,  2, 2),   -- Mouse inalámbrico
    (1,  3, 1),   -- Monitor 27 pulgadas
    (1, 11, 1),   -- Hub USB-C 7 en 1
    (2,  9, 1);   -- Notebook 15.6 pulgadas
