-- ============================================================
-- Creación y poblado de las tablas carrito y carrito_producto (ecommerce_db3)
-- El carrito se asocia a usuarios ya cargados por
-- data-testing/sql/usuarios-insert.sql, y carrito_producto a
-- productos ya cargados por data-testing/sql/productos-insert.sql
-- (ambos scripts deben correrse primero).
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/carrito-insert.sql
-- ============================================================

SET NAMES utf8mb4;

-- Las tablas se crean acá porque todavía no existen entidades
-- gestionadas por Hibernate (a diferencia de productos).
CREATE TABLE IF NOT EXISTS carrito (
    carrito_id  INT AUTO_INCREMENT PRIMARY KEY,
    user_id     INT NOT NULL UNIQUE,
    CONSTRAINT fk_carrito_usuario
        FOREIGN KEY (user_id) REFERENCES usuarios(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS carrito_producto (
    carrito_id   INT NOT NULL,
    producto_id  BIGINT NOT NULL,
    cantidad     INT NOT NULL,
    PRIMARY KEY (carrito_id, producto_id),
    CONSTRAINT fk_carritoproducto_carrito
        FOREIGN KEY (carrito_id) REFERENCES carrito(carrito_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_carritoproducto_producto
        FOREIGN KEY (producto_id) REFERENCES productos(id)
        ON DELETE CASCADE
);

-- Limpia las tablas y reinicia los contadores de ids, para que el
-- script se pueda correr las veces que haga falta sin duplicar.
DELETE FROM carrito_producto;
DELETE FROM carrito;
ALTER TABLE carrito AUTO_INCREMENT = 1;

-- Un carrito por usuario, referenciado por email en lugar del id
-- numérico, para no depender del orden exacto en que haya quedado
-- cargada la tabla usuarios.
INSERT INTO carrito (user_id) VALUES
    ((SELECT id FROM usuarios WHERE email = 'dolores.pavon@example.com')),
    ((SELECT id FROM usuarios WHERE email = 'juan.perez@example.com')),
    ((SELECT id FROM usuarios WHERE email = 'maria.gonzalez@example.com')),
    ((SELECT id FROM usuarios WHERE email = 'carlos.rodriguez@example.com')),
    ((SELECT id FROM usuarios WHERE email = 'lucia.fernandez@example.com'));

-- Se referencia cada carrito por el email de su usuario y cada
-- producto por nombre (subqueries), en lugar de los ids numéricos.
INSERT INTO carrito_producto (carrito_id, producto_id, cantidad) VALUES
    ((SELECT carrito_id FROM carrito WHERE user_id = (SELECT id FROM usuarios WHERE email = 'dolores.pavon@example.com')),      (SELECT id FROM productos WHERE nombre = 'Teclado mecánico RGB'),   1),
    ((SELECT carrito_id FROM carrito WHERE user_id = (SELECT id FROM usuarios WHERE email = 'dolores.pavon@example.com')),      (SELECT id FROM productos WHERE nombre = 'Mouse inalámbrico'),      2),
    ((SELECT carrito_id FROM carrito WHERE user_id = (SELECT id FROM usuarios WHERE email = 'juan.perez@example.com')),         (SELECT id FROM productos WHERE nombre = 'Monitor 27 pulgadas'),    1),
    ((SELECT carrito_id FROM carrito WHERE user_id = (SELECT id FROM usuarios WHERE email = 'maria.gonzalez@example.com')),     (SELECT id FROM productos WHERE nombre = 'Auriculares Bluetooth'),  1),
    ((SELECT carrito_id FROM carrito WHERE user_id = (SELECT id FROM usuarios WHERE email = 'maria.gonzalez@example.com')),     (SELECT id FROM productos WHERE nombre = 'Webcam Full HD'),         1),
    ((SELECT carrito_id FROM carrito WHERE user_id = (SELECT id FROM usuarios WHERE email = 'carlos.rodriguez@example.com')),   (SELECT id FROM productos WHERE nombre = 'Disco SSD NVMe 1TB'),     2),
    ((SELECT carrito_id FROM carrito WHERE user_id = (SELECT id FROM usuarios WHERE email = 'lucia.fernandez@example.com')),    (SELECT id FROM productos WHERE nombre = 'Silla gamer ergonómica'), 1),
    ((SELECT carrito_id FROM carrito WHERE user_id = (SELECT id FROM usuarios WHERE email = 'lucia.fernandez@example.com')),    (SELECT id FROM productos WHERE nombre = 'Hub USB-C 7 en 1'),       3);
