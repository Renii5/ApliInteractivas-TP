-- ============================================================
-- 2) Categorías (ecommerce_db3)
-- Requiere haber corrido antes usuarios-insert.sql
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/categorias-insert.sql
-- ============================================================

SET NAMES utf8mb4;

-- Las categorías no se pueden borrar si tienen productos (FK),
-- por eso se limpian antes los productos y lo que depende de ellos
DELETE FROM orden_items;
DELETE FROM carrito_productos;
DELETE FROM productos;
DELETE FROM categorias;

INSERT INTO categorias (id, nombre) VALUES
    (1, 'Placas de video'),
    (2, 'Procesadores'),
    (3, 'Memorias RAM'),
    (4, 'Almacenamiento'),
    (5, 'Perifericos'),
    (6, 'Monitores');

ALTER TABLE categorias AUTO_INCREMENT = 7;
