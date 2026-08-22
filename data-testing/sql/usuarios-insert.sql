-- ============================================================
-- Creación y poblado de la tabla usuarios (ecommerce_db3)
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/usuarios-insert.sql
-- ============================================================

SET NAMES utf8mb4;

-- La tabla se crea acá porque todavía no existe una entidad Usuario
-- gestionada por Hibernate (a diferencia de productos).
CREATE TABLE IF NOT EXISTS usuarios (
    id               INT AUTO_INCREMENT PRIMARY KEY,
    nombre           VARCHAR(100) NOT NULL,
    email            VARCHAR(150) NOT NULL UNIQUE,
    password         VARCHAR(255) NOT NULL,
    fecha_registro   DATETIME NOT NULL
);

-- Limpia la tabla y reinicia el contador de ids, para que el
-- script se pueda correr las veces que haga falta sin duplicar.
DELETE FROM usuarios;
ALTER TABLE usuarios AUTO_INCREMENT = 1;

INSERT INTO usuarios (nombre, email, password, fecha_registro) VALUES
    ('Dolores Pavón',     'dolores.pavon@example.com',   'password123', '2026-05-02 09:00:00'),
    ('Juan Pérez',        'juan.perez@example.com',      'password123', '2026-05-05 10:30:00'),
    ('María González',    'maria.gonzalez@example.com',  'password123', '2026-05-08 14:15:00'),
    ('Carlos Rodríguez',  'carlos.rodriguez@example.com','password123', '2026-05-12 11:45:00'),
    ('Lucía Fernández',   'lucia.fernandez@example.com', 'password123', '2026-05-18 16:20:00'),
    ('Martín López',      'martin.lopez@example.com',    'password123', '2026-05-22 08:50:00'),
    ('Sofía Martínez',    'sofia.martinez@example.com',  'password123', '2026-05-27 13:05:00'),
    ('Diego Sánchez',     'diego.sanchez@example.com',   'password123', '2026-06-01 17:40:00');
