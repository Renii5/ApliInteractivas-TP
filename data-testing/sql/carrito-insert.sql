-- ============================================================
-- 4) Carrito (opcional) (ecommerce_db3)
-- Requiere haber corrido antes usuarios-insert.sql y productos-insert.sql
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/carrito-insert.sql
-- ============================================================
--
-- Deja un carrito de ejemplo para Lucia con productos de Juan.
-- Maria arranca sin carrito: la API se lo crea la primera vez que lo usa
-- (así el flujo de compra de la colección de Postman empieza vacío).
-- ============================================================

SET NAMES utf8mb4;

DELETE FROM carrito_productos;
DELETE FROM carrito;

INSERT INTO carrito (id, usuario_id) VALUES
    (1, 4);

INSERT INTO carrito_productos (id, carrito_id, producto_id, cantidad) VALUES
    (1, 1, 2, 2),   -- Mouse inalambrico x2
    (2, 1, 5, 1);   -- Monitor 27 pulgadas x1

ALTER TABLE carrito AUTO_INCREMENT = 2;
ALTER TABLE carrito_productos AUTO_INCREMENT = 3;
