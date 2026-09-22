-- ============================================================
-- Asigna el rol ADMIN a usuarios registrados por la API
-- (POST /api/usuarios/register siempre crea los usuarios con rol USER).
-- No hace falta si se cargaron los datos con usuarios-insert.sql,
-- que ya trae a admin@mail.com como ADMIN.
-- Después de correrlo, el usuario tiene que volver a hacer login:
-- el rol viaja dentro del token.
-- Uso:  docker exec -i mysql-open mysql -uroot ecommerce_db3 < data-testing/sql/data-admin.sql
-- ============================================================

UPDATE usuarios
SET role = 'ADMIN'
WHERE email IN (
    'admin@mail.com'
);

-- Verificación: lista los administradores actuales
SELECT id, nombre, apellido, email, nombre_usuario, role
FROM usuarios
WHERE role = 'ADMIN';
