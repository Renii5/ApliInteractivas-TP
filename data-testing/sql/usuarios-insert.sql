-- ============================================================
-- 1) Usuarios (ecommerce_db3)
-- Este script va PRIMERO: limpia toda la base (en orden, por las FK)
-- y carga los usuarios de prueba.
-- Las tablas las crea Hibernate: levantar la aplicación al menos una vez antes.
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/usuarios-insert.sql
-- ============================================================
--
-- Usuarios cargados (las contraseñas están hasheadas con BCrypt):
--   admin@mail.com  / admin123  -> ADMIN
--   juan@mail.com   / 1234      -> USER (vendedor)
--   lucia@mail.com  / 1234      -> USER (vendedora)
--   maria@mail.com  / 1234      -> USER (compradora)
-- ============================================================

SET NAMES utf8mb4;

-- Limpieza completa: primero las tablas que dependen de otras
DELETE FROM orden_items;
DELETE FROM ordenes;
DELETE FROM carrito_productos;
DELETE FROM carrito;
DELETE FROM productos;
DELETE FROM categorias;
DELETE FROM usuarios;

INSERT INTO usuarios (id, nombre, apellido, email, nombre_usuario, password, role) VALUES
    (1, 'Maria', 'Lopez',     'maria@mail.com', 'marial', '$2a$10$EmF/DGh1.RsQDxBJjNCZBuGGemFtYgHRhzW266RDYV6cfdyFCR.EC', 'USER'),
    (2, 'Admin', 'Sistema',   'admin@mail.com', 'admin',  '$2a$10$9T014H7vIuDrG/TG.SsOVO42RTz0SuLOdCaNjjbuncc3WmkviIsAi', 'ADMIN'),
    (3, 'Juan',  'Perez',     'juan@mail.com',  'juanp',  '$2a$10$eaxFuvnt7pTASxb3hxtF2O6IzuBZAaqKUWKLrEFRnbyhwegOG9NFS', 'USER'),
    (4, 'Lucia', 'Fernandez', 'lucia@mail.com', 'luciaf', '$2a$10$VG.qiZ0KQ6YepXh4P2POcuq3Ga75SE3PQ5I/bqHSpdPLGPXSbOieS', 'USER');

ALTER TABLE usuarios AUTO_INCREMENT = 5;
