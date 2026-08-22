-- ============================================================
-- Poblado inicial de la tabla productos (ecommerce_db3)
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/productos-insert.sql
-- ============================================================

SET NAMES utf8mb4;

-- Limpia la tabla y reinicia el contador de ids, para que el
-- script se pueda correr las veces que haga falta sin duplicar.
DELETE FROM productos;
ALTER TABLE productos AUTO_INCREMENT = 1;

INSERT INTO productos (nombre, description, precio) VALUES
    ('Teclado mecánico RGB',        'Switches rojos, 87 teclas, retroiluminado',      45000.50),
    ('Mouse inalámbrico',           '6 botones programables, 16000 DPI',              22000.00),
    ('Monitor 27 pulgadas',         'QHD 2560x1440, 165Hz, panel IPS',               380000.00),
    ('Auriculares Bluetooth',       'Cancelación activa de ruido, 30h de batería',     89990.00),
    ('Webcam Full HD',              '1080p 60fps con micrófono estéreo',               54500.00),
    ('Disco SSD NVMe 1TB',          'Lectura 7000 MB/s, formato M.2 2280',            125000.00),
    ('Memoria RAM 16GB DDR4',       '3200 MHz CL16, disipador de aluminio',            78000.00),
    ('Placa de video RTX 4060',     '8GB GDDR6, ray tracing y DLSS 3',                890000.00),
    ('Notebook 15.6 pulgadas',      'Core i5, 16GB RAM, SSD 512GB',                  1250000.00),
    ('Silla gamer ergonómica',      'Soporte lumbar, apoyabrazos 4D, reclinable',     320000.00),
    ('Hub USB-C 7 en 1',            'HDMI 4K, 2x USB 3.0, SD, microSD, PD 100W',       35900.00),
    ('Micrófono condensador USB',   'Patrón cardioide, brazo articulado incluido',     96000.00),
    ('Parlante Bluetooth portátil', 'Resistente al agua IPX7, 20h de autonomía',       67500.00),
    ('Cable HDMI 2.1 de 2m',        'Soporta 4K 120Hz y 8K 60Hz',                      12500.00),
    ('Base para notebook',          'Aluminio, altura regulable, hasta 17 pulgadas',   28000.00);
