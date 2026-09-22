UPDATE usuarios
SET role = 'ADMIN'
WHERE email IN (
    'admin@mail.com'
);

-- Verificación: lista los administradores actuales
SELECT id, nombre, apellido, email, nombre_usuario, role
FROM usuarios
WHERE role = 'ADMIN';