# Tareas pendientes — Backend Marketplace (TPO Aplicaciones Interactivas)

Lista de tareas para completar el backend según la consigna del TPO y los requisitos de aprobación de la 1ra entrega.

**Prioridades:** Alta = requisito de aprobación o bug actual · Media = necesario para un marketplace usable · Baja / Plus = mejora o puntos extra.

---

## Resumen

| # | Tema | Tarea | Prioridad |
|---|---|---|---|
| 01 | Seguridad y usuarios | Reglas por rol en categorías y ventas | Alta |
| 02 | Seguridad y usuarios | Usuario ADMIN para la demo | Alta |
| 03 | Seguridad y usuarios | Limpiar `UsuarioController` y agregar `GET /usuarios/me` | Alta |
| 04 | Seguridad y usuarios | Login y registro con `ResponseEntity`, token en JSON y campo `username` | Media |
| 05 | Seguridad y usuarios | Sesión STATELESS y CORS | Media |
| 06 | Seguridad y usuarios | Handlers 401/403 y `UsernameNotFoundException` | Media |
| 07 | Productos y categorías | Stock en `Producto` y `PATCH /productos/{id}/stock` | Alta |
| 08 | Productos y categorías | Dueño del producto | Alta |
| 09 | Productos y categorías | `GET /productos/{id}` y listado alfabético con filtro por categoría | Alta |
| 10 | Productos y categorías | `CategoriaDTO` con `ResponseEntity` y `@OneToMany` en `Categoria` | Alta |
| 11 | Productos y categorías | Borrado con integridad | Media |
| 12 | Productos y categorías | Imágenes del producto | Baja |
| 13 | Carrito y checkout | Relación `Carrito` → `Usuario` y carrito del usuario logueado | Alta |
| 14 | Carrito y checkout | Arreglar el DELETE del carrito | Alta |
| 15 | Carrito y checkout | Agregar, modificar y eliminar ítems validando stock | Alta |
| 16 | Carrito y checkout | `CarritoResponseDTO` con subtotales y total | Alta |
| 17 | Carrito y checkout | Checkout | Alta |
| 18 | Ventas y órdenes | `Orden` y `OrdenItem` | Alta |
| 19 | Ventas y órdenes | `VentasDTO` con `ResponseEntity` | Alta |
| 20 | Ventas y órdenes | Mis compras: `GET /ordenes` | Media |
| 21 | Datos, calidad y entrega | Scripts SQL alineados con las entidades | Alta |
| 22 | Datos, calidad y entrega | Bean Validation y `ErrorResponse` en JSON | Media |
| 23 | Datos, calidad y entrega | Colección de Postman para el video | Media |
| 24 | Datos, calidad y entrega | Tests unitarios con Mockito | Plus |
| 25 | Datos, calidad y entrega | Docker Compose | Plus |

---

## Seguridad y usuarios

### 1. Reglas por rol en categorías y ventas — Alta
En `SecurityConfig`, cambiar el `permitAll()` de POST/PUT/DELETE sobre `/api/categorias/**` por `hasRole("ADMIN")`, y agregar `GET /api/ventas` con `hasRole("ADMIN")`. Hoy la única regla por rol es sobre `/api/admin/**`, una ruta que no existe, y el profe pide reglas por rol como requisito de aprobación. Conviene también borrar las reglas de `/api/auth/**` y `/api/pedidos/**`, que tampoco existen en el proyecto.

### 2. Usuario ADMIN para la demo — Alta
El registro siempre asigna el rol `USER`, así que hoy no hay forma de tener un admin. Hacer un script SQL (por ejemplo `data-testing/sql/admin-insert.sql`) que, después de registrar un usuario por la API, lo actualice con `UPDATE usuarios SET role = 'ADMIN' WHERE email = '...'`. Sirve para mostrar en el video un 403 con un USER y un 200 con un ADMIN.

### 3. Limpiar `UsuarioController` y agregar `GET /usuarios/me` — Alta
Borrar `getAllUsuarios` (exige un `@RequestParam param` sin sentido y devuelve un string vacío) y `getUsuarioById`, que tampoco hace nada. Agregar `GET /api/usuarios/me`: toma el email del usuario autenticado (`Authentication` o `SecurityContextHolder`), lo busca en el repositorio y devuelve un `UsuarioResponseDTO` con id, nombre, apellido, email y rol, sin la contraseña.

### 4. Login y registro con `ResponseEntity`, token en JSON y campo `username` — Media
- `register` y `login` devuelven hoy un `String` pelado. Cambiarlos a `ResponseEntity`: el registro responde `201`, y el login responde `200` con un JSON tipo `{ "token": "...", "email": "...", "role": "USER" }` (un `LoginResponseDTO`).
- La consigna pide "nombre de usuario" en el registro: agregar `username` (único) en `Usuario` y en `RegisterRequest`, y validar que no se repita.

### 5. Sesión STATELESS y CORS — Media
- En `SecurityConfig`, agregar `.sessionManagement(s -> s.sessionCreationPolicy(SessionCreationPolicy.STATELESS))`. Deja explícito que la API no usa sesión y que la identidad viaja en el JWT, que es lo que justifica el `csrf.disable()`.
- Agregar un bean `CorsConfigurationSource` que permita el origen del front (por ejemplo `http://localhost:5173`), los métodos GET/POST/PUT/PATCH/DELETE y los headers `Authorization` y `Content-Type`.

### 6. Handlers 401/403 y `UsernameNotFoundException` — Media
- Hoy, una request sin token a un endpoint protegido devuelve 403 en lugar de 401. Configurar un `authenticationEntryPoint` que devuelva 401 y un `accessDeniedHandler` que devuelva 403 con un mensaje claro.
- En `GlobalExceptionHandler`, agregar un handler para `UsernameNotFoundException` que responda 404. Hoy cae en el genérico y devuelve 500.

---

## Productos y categorías

### 7. Stock en `Producto` y `PATCH /productos/{id}/stock` — Alta
Agregar `private Integer stock` en `Producto`, `ProductoRequestDTO` y `ProductoResponseDTO`, validando que no sea negativo al crear y al editar. Crear `PATCH /api/productos/{id}/stock` con body `{ "stock": 10 }` para que el vendedor actualice solo el stock. La consigna exige que el usuario maneje el stock y que no se pueda agregar al carrito sin stock.

### 8. Dueño del producto — Alta
Agregar en `Producto` un `@ManyToOne` a `Usuario` llamado `vendedor`. En `createProducto`, asignarlo con el usuario autenticado, tomado del token y no del body. En `updateProducto`, `eliminarProducto` y el PATCH de stock, verificar que el usuario autenticado sea el dueño (o ADMIN); si no, lanzar una excepción que responda 403. Sumar `vendedorId` o `vendedorNombre` al DTO de respuesta.

### 9. `GET /productos/{id}` y listado alfabético con filtro por categoría — Alta
- `GET /api/productos/{id}` devuelve el detalle del producto, o 404 con `ProductoNotFoundException`. La consigna pide la vista de detalle.
- En `ProductoRepository`, agregar `findAllByOrderByNombreAsc()` y `findByCategoriaIdOrderByNombreAsc(Long categoriaId)`.
- `GET /api/productos` acepta `?categoriaId=` opcional: si viene, filtra; si no, lista todo en orden alfabético.

### 10. `CategoriaDTO` con `ResponseEntity` y `@OneToMany` en `Categoria` — Alta
- `CategoriaController` hoy recibe y devuelve la entidad `Categoria` directamente. Crear `CategoriaRequestDTO` (nombre) y `CategoriaResponseDTO` (id, nombre), y hacer el mapeo en `CategoriaService`.
- En `Categoria`, agregar `@OneToMany(mappedBy = "categoria") private List<Producto> productos;` para tener una relación bidireccional que explicar en el parcial. Hay que agregarle `@JsonIgnore` o no exponerla en el DTO, para evitar un bucle infinito al serializar.

### 11. Borrado con integridad — Media
Hoy, borrar una categoría con productos (o un producto que está en un carrito) viola una clave foránea y responde 500. En `borrarCategoria`, verificar antes si tiene productos (`productoRepository.existsByCategoriaId(id)`) y, si tiene, lanzar una excepción que responda 409 Conflict con un mensaje claro. Lo mismo para productos que estén en carritos u órdenes; como alternativa, hacer baja lógica con un campo `activo`.

### 12. Imágenes del producto — Baja
La consigna pide adjuntar una o más fotos al publicar. La versión simple: entidad `ProductoImagen` (id, url, `@ManyToOne` a `Producto`) y en `Producto` un `@OneToMany` con `List<ProductoImagen> imagenes`. El request de producto recibe una lista de URLs. La versión completa sería subir archivos con `MultipartFile`, pero es más compleja.

---

## Carrito y checkout

### 13. Relación `Carrito` → `Usuario` y carrito del usuario logueado — Alta
- En `Carrito`, reemplazar `Long userId` por `@OneToOne` (o `@ManyToOne`) a `Usuario`.
- Cambiar los endpoints para que no reciban `carritoId` por URL: `GET /api/carrito` busca el carrito del usuario autenticado y lo crea si no existe. Hoy cualquier usuario puede ver o borrar el carrito de otro cambiando el id en la URL.

### 14. Arreglar el DELETE del carrito — Alta
Hoy `DELETE /api/carrito/{id}` con productos adentro responde 500, porque las filas de `carrito_productos` apuntan al carrito. Cambiarlo a `DELETE /api/carrito` para "vaciar carrito" (lo que pide la consigna): borrar solo los ítems con `carritoProductosRepository.deleteByCarritoId(...)` y mantener el carrito.

### 15. Agregar, modificar y eliminar ítems validando stock — Alta
- `POST /api/carrito/items` con `{ "productoId": 1, "cantidad": 2 }`: si el producto ya está en el carrito, suma la cantidad; si no, crea el `CarritoProductos`. Si la cantidad supera el stock, lanza una excepción (`StockInsuficienteException`) que responda 400 o 409.
- `PUT /api/carrito/items/{productoId}` con `{ "cantidad": 3 }`: cambia la cantidad, validando stock.
- `DELETE /api/carrito/items/{productoId}`: saca el producto del carrito.
- Agregar una restricción única (carrito, producto) en `CarritoProductos` para que el mismo producto no aparezca dos veces.

### 16. `CarritoResponseDTO` con subtotales y total — Alta
Hoy `GET /api/carrito` devuelve productos sin cantidad ni precio. Crear `CarritoItemDTO` (productoId, nombre, precioUnitario, cantidad, subtotal) y `CarritoResponseDTO` (carritoId, lista de ítems, total). La consigna pide calcular el costo total.

### 17. Checkout — Alta
`POST /api/carrito/checkout`, en un método de service con `@Transactional`:
1. Si el carrito está vacío, error 400.
2. Validar que haya stock de cada ítem; si alguno no tiene, error y no se descuenta nada.
3. Descontar el stock de cada producto.
4. Crear la `Orden` con sus `OrdenItem`, guardando el precio de ese momento.
5. Vaciar el carrito.
6. Devolver la orden con el total.

Depende de las tareas 7 (stock) y 18 (Orden). Además, es un muy buen ejemplo para explicar qué hace `@Transactional`: si algo falla, se revierte todo.

---

## Ventas y órdenes

### 18. `Orden` y `OrdenItem` — Alta
Hoy `Ventas` guarda un `productoId` suelto, sin relación ni comprador. Crear:
- `Orden`: id, fecha, total, `@ManyToOne` a `Usuario` (comprador) y `@OneToMany(mappedBy = "orden", cascade = ALL)` con `List<OrdenItem> items`.
- `OrdenItem`: id, cantidad, precioUnitario, `@ManyToOne` a `Orden` y `@ManyToOne` a `Producto`.

Con repositorios `OrdenRepository` y `OrdenItemRepository`. La alternativa mínima, si no hay tiempo, es cambiar `Ventas.productoId` por un `@ManyToOne` a `Producto`.

### 19. `VentasDTO` con `ResponseEntity` — Alta
`VentasController` devuelve hoy `List<Ventas>` (la entidad) sin `ResponseEntity`. Crear un DTO de respuesta (por ejemplo `OrdenResponseDTO`, con id, fecha, comprador, ítems y total), mapearlo en el service y devolver `ResponseEntity.ok(...)`. Este endpoint queda solo para ADMIN (tarea 1).

### 20. Mis compras: `GET /ordenes` — Media
`GET /api/ordenes` devuelve las órdenes del usuario autenticado (`findByCompradorEmail`), y `GET /api/ordenes/{id}` devuelve el detalle de una. Si la orden no es del usuario, responde 404 o 403.

---

## Datos, calidad y entrega

### 21. Scripts SQL alineados con las entidades — Alta
Hoy los scripts de `data-testing/sql/` no coinciden con lo que genera Hibernate:
- `usuarios-insert` crea una tabla sin `apellido` ni `role` y guarda contraseñas en texto plano, así que el login nunca funciona.
- `productos-insert` no carga `categoria_id`, que es obligatorio.
- `carrito-insert` crea una tabla `carrito_producto` que no es la que usa la entidad.

Qué hacer:
- Sacar todos los `CREATE TABLE` y dejar que Hibernate cree las tablas.
- Crear `categorias-insert.sql`.
- Usar contraseñas hasheadas con BCrypt, o registrar los usuarios por la API.
- Actualizar el orden de ejecución en el README.

### 22. Bean Validation y `ErrorResponse` en JSON — Media
- Agregar la dependencia `spring-boot-starter-validation`. En los DTOs, usar `@NotBlank` (nombre), `@Email` (email), `@Positive`/`@PositiveOrZero` (precio, stock, cantidad) y `@NotNull` (categoriaId). En los controllers, `@Valid @RequestBody`.
- En `GlobalExceptionHandler`, manejar `MethodArgumentNotValidException` con un 400.
- Crear una clase `ErrorResponse` (status, mensaje, timestamp) para que todos los errores respondan JSON y no texto plano. En el handler genérico de 500, no devolver `ex.getMessage()`.

### 23. Colección de Postman para el video — Media
Armar una colección con el flujo completo, en orden, y exportarla al repositorio (por ejemplo `docs/postman/`):
1. Registro.
2. Login, guardando el token en una variable con un script de Tests.
3. Listar categorías y productos.
4. Crear un producto con el token.
5. Intentar crear una categoría como USER (403) y como ADMIN (201).
6. Agregar al carrito, ver el total y hacer checkout.
7. Ver mis compras.

Usar variables `{{baseUrl}}` y `{{token}}`. El video tiene que durar como máximo 5 minutos.

### 24. Tests unitarios con Mockito — Plus
Tests de services con `@ExtendWith(MockitoExtension.class)`, `@Mock` de los repositorios y `@InjectMocks` del service. Casos mínimos:
- Crear un producto con precio negativo lanza una excepción.
- Buscar una categoría inexistente lanza `CategoriaNotFoundException`.
- Agregar al carrito sin stock falla.
- El checkout descuenta el stock.

Hoy el único test es `contextLoads`, y necesita MySQL levantado.

### 25. Docker Compose — Plus
Un `Dockerfile` para el backend (build con Maven y ejecución del jar) y un `docker-compose.yml` con dos servicios: `db` (mysql:8, con volumen) y `backend`. La URL de la base se pasa por variable de entorno (`SPRING_DATASOURCE_URL=jdbc:mysql://db:3306/...`). El profe también pide subir las imágenes a Docker Hub.

---

## Dependencias y orden sugerido

- El **checkout (17)** necesita el **stock (7)** y el modelo de **Orden (18)**.
- Las **reglas por rol (1)** afectan a todos los endpoints: conviene hacerlas primero.

**Orden sugerido:**
1. Tareas 1, 2, 7 y 18, porque desbloquean al resto.
2. Tareas 13 a 17 (carrito y checkout).
3. El resto de las de prioridad alta.
4. Las de prioridad media y los plus.
