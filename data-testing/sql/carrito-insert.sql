-- ============================================================
-- Poblado de prueba para carrito y carrito_productos (ecommerce_db3)
-- Las tablas las crea Hibernate. Requiere que existan los usuarios
-- (registrados por la API) y los productos referenciados por nombre.
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/carrito-insert.sql
-- ============================================================

SET NAMES utf8mb4;

-- Primero la tabla intermedia, por la FK hacia carrito
DELETE FROM carrito_productos;
DELETE FROM carrito;
ALTER TABLE carrito_productos AUTO_INCREMENT = 1;
ALTER TABLE carrito AUTO_INCREMENT = 1;

-- Un carrito por usuario (usuario_id es UNIQUE). Se referencia al usuario
-- por email para no depender de los ids numéricos.
INSERT INTO carrito (usuario_id) VALUES
    ((SELECT id FROM usuarios WHERE email = 'juan.perez@example.com')),
    ((SELECT id FROM usuarios WHERE email = 'maria.gonzalez@example.com'));

-- Carrito de Juan: setup de escritorio. Carrito de María: queda vacío a propósito.
-- Si un carrito no existe, la API lo crea la primera vez que el usuario lo consulta.
INSERT INTO carrito_productos (carrito_id, producto_id, cantidad) VALUES
    ((SELECT c.id FROM carrito c JOIN usuarios u ON u.id = c.usuario_id WHERE u.email = 'juan.perez@example.com'),
     (SELECT id FROM productos WHERE nombre = 'Teclado mecánico RGB'), 1),
    ((SELECT c.id FROM carrito c JOIN usuarios u ON u.id = c.usuario_id WHERE u.email = 'juan.perez@example.com'),
     (SELECT id FROM productos WHERE nombre = 'Mouse inalámbrico'), 2),
    ((SELECT c.id FROM carrito c JOIN usuarios u ON u.id = c.usuario_id WHERE u.email = 'juan.perez@example.com'),
     (SELECT id FROM productos WHERE nombre = 'Monitor 27 pulgadas'), 1);
