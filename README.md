# back-ecommerce — PC Hardware Marketplace

Backend REST de un marketplace de componentes de hardware de PC, desarrollado como TPO de
Aplicaciones Interactivas (UADE). Expone una API que permite registrar e identificar usuarios,
navegar el catálogo de productos organizado por categorías, gestionar el contenido del carrito
de compras y consultar el registro de ventas. Está construido con Spring Boot bajo una
arquitectura en capas (Controller / Service / Repository / Model) con persistencia JPA sobre
MySQL, DTOs para desacoplar el dominio de la API, manejo centralizado de errores y seguridad
con autenticación y autorización basada en JWT.

---

## Módulos implementados

| Módulo | Descripción | Estado |
| :--- | :--- | :--- |
| **Usuarios / Autenticación** | Registro con hash BCrypt, login con emisión de JWT, roles (`USER`, `ADMIN`, `VENDEDOR`). | Funcional |
| **Categorías** | ABM completo de categorías de producto. | Funcional |
| **Productos** | Listado, alta, modificación y baja de productos, asociados a una categoría. | Funcional |
| **Carrito** | CRUD del carrito y gestión de los productos que contiene. | Funcional |
| **Ventas** | Consulta del registro histórico de ventas. | Funcional |
| **Seguridad (plus opcional)** | `SecurityConfig` + filtro JWT propio que protege los endpoints de escritura. | Funcional |
| **Manejo de errores** | `@ControllerAdvice` global que traduce excepciones de dominio a códigos HTTP. | Funcional |

---

## Stack tecnológico

| Componente | Versión / Detalle |
| :--- | :--- |
| Java | 17 |
| Spring Boot | 4.1.0 |
| Spring Web | API REST |
| Spring Data JPA + Hibernate | Persistencia |
| Spring Security | Autenticación / autorización |
| JJWT | 0.11.5 — generación y validación de tokens |
| Lombok | Reducción de boilerplate |
| MySQL | Base de datos principal |
| H2 | Base en memoria (alternativa para pruebas) |
| Maven | Gestión de dependencias y build |

---

## Arquitectura en capas

```text
src/main/java/com/uade/tpo/e_commerce/
├── controller/   # @RestController — reciben la request HTTP y devuelven ResponseEntity
├── service/      # @Service + @Transactional — lógica de negocio y validaciones
├── repository/   # Interfaces que extienden JpaRepository — acceso a datos
├── model/        # @Entity — entidades JPA mapeadas a tablas
├── dto/          # Request/Response DTOs — desacoplan las entidades de la API
├── exception/    # Excepciones de dominio + GlobalExceptionHandler (@ControllerAdvice)
├── security/     # JwtUtil (firma/validación) y JwtFilter (filtro por request)
└── config/       # SecurityConfig — reglas de acceso y beans de seguridad
```

Los diagramas de la arquitectura y del modelo de dominio están en [`docs/`](docs/):

- [`DiagramaArquitecturaCapas.puml`](docs/DiagramaArquitecturaCapas.puml)
- [`DiagramaClases_Dominio.puml`](docs/DiagramaClases_Dominio.puml)
- [`DiagramaEntidadesDominio.puml`](docs/DiagramaEntidadesDominio.puml)

Las versiones renderizadas en SVG están en [`docs/imgDiagrams/`](docs/imgDiagrams/).

---

## Modelo de datos (entidades JPA)

| Entidad | Tabla | Atributos principales | Relaciones |
| :--- | :--- | :--- | :--- |
| `Usuario` | `usuarios` | id, nombre, apellido, email (único), password (BCrypt), role | Implementa `UserDetails` de Spring Security |
| `Categoria` | `categorias` | id, nombre | — |
| `Producto` | `productos` | id, nombre, description, precio, stock | `@ManyToOne` → `Categoria`, `@ManyToOne` → `Usuario` (vendedor), `@OneToMany` → `ProductoImagen` (cascade, orphanRemoval) |
| `ProductoImagen` | `producto_imagenes` | id, url, orden | `@ManyToOne` → `Producto`. La de `orden` 0 es la imagen principal |
| `Carrito` | `carrito` | id | `@OneToOne` → `Usuario` (un carrito por usuario) |
| `CarritoProductos` | `carrito_productos` | id, cantidad | `@ManyToOne` → `Carrito`, `@ManyToOne` → `Producto`; único (carrito, producto) |
| `Orden` | `ordenes` | id, fecha, total | `@ManyToOne` → `Usuario` (comprador), `@OneToMany` → `OrdenItem` (cascade) |
| `OrdenItem` | `orden_items` | id, cantidad, precioUnitario | `@ManyToOne` → `Orden`, `@ManyToOne` → `Producto` |

La relación N:M entre `Carrito` y `Producto` se modela de forma explícita mediante la entidad
intermedia `CarritoProductos`, que además guarda la cantidad de cada ítem. La consulta
`findByCarritoId` usa `@EntityGraph` para traer el producto en la misma query y evitar el
problema N+1.

`OrdenItem` guarda el precio del producto al momento de la compra, así un cambio de precio
posterior no altera las órdenes ya generadas.

Un producto tiene **una o más fotos** (entre 1 y 6) en la tabla `producto_imagenes`, relación 1:N con
`Producto`. Con `cascade` y `orphanRemoval`, las imágenes se guardan y se borran junto con el producto,
y al modificarlo las que ya no vienen en la lista se eliminan. `@BatchSize` hace que el listado del
catálogo traiga las imágenes de toda la página en una sola consulta.

---

## API REST

Base URL: `http://localhost:8080`

### Usuarios y autenticación — `/api/usuarios`

| Método | Endpoint | Descripción | Acceso | Respuesta |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/api/usuarios/register` | Registra un usuario nuevo (rol `USER` por defecto) y devuelve sus datos (`UsuarioResponseDTO`, sin contraseña). | Público | `201` / `409` si el email o el nombre de usuario ya existen |
| `POST` | `/api/usuarios/login` | Valida credenciales. El JWT va en la cookie `HttpOnly` `sesion` (header `Set-Cookie`) y el body trae los datos del usuario (`UsuarioResponseDTO`). | Público | `200` / `401` / `404` |
| `POST` | `/api/usuarios/logout` | Borra la cookie de sesión (la devuelve vacía con `Max-Age=0`). | Público | `204` |
| `GET` | `/api/usuarios/me` | Datos del usuario logueado. El front lo usa al cargar la app para saber si hay sesión. | Autenticado | `200` / `401` |

Body de registro:

```json
{ "nombre": "Juan", "apellido": "Perez", "email": "juan@mail.com", "nombreUsuario": "juanp", "password": "1234" }
```

Body de login:

```json
{ "email": "juan@mail.com", "password": "1234" }
```

### Categorías — `/api/categorias`

| Método | Endpoint | Descripción | Acceso | Respuesta |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/categorias` | Lista todas las categorías. | Público | `200` |
| `GET` | `/api/categorias/{id}` | Detalle de una categoría. | Público | `200` / `404` |
| `POST` | `/api/categorias` | Crea una categoría. | Público | `201` |
| `PUT` | `/api/categorias/{id}` | Actualiza una categoría. | Público | `200` / `404` |
| `DELETE` | `/api/categorias/{id}` | Elimina una categoría. | Público | `204` / `404` |

### Productos — `/api/productos`

| Método | Endpoint | Descripción | Acceso | Respuesta |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/productos` | Lista todos los productos como `ProductoResponseDTO`. | Público | `200` |
| `POST` | `/api/productos` | Crea un producto asociado a una categoría existente. | Autenticado | `201` / `400` precio negativo / `404` categoría inexistente |
| `POST` | `/api/productos/imagen` | Sube una imagen (`multipart/form-data`, campo `imagen`, JPG/PNG/WEBP hasta 5 MB) y devuelve `{ "image_url": "http://localhost:8080/images/<uuid>.jpg" }` para usar en el alta o modificación. | Autenticado | `201` / `400` formato inválido / `413` demasiado grande |
| `PUT` | `/api/productos/{id}` | Actualiza un producto. | Autenticado | `200` / `400` / `404` |
| `DELETE` | `/api/productos/{id}` | Elimina un producto. | Autenticado | `204` / `404` |

Body de alta/modificación (`imagenes`: entre 1 y 6 URLs, en orden; la primera es la principal):

```json
{
  "nombre": "RTX 4070", "descripcion": "GPU 12GB GDDR6X", "precio": 850000.0, "stock": 10, "categoriaId": 1,
  "imagenes": ["http://localhost:8080/images/<uuid>.jpg", "http://localhost:8080/images/<uuid>.jpg"]
}
```

Para publicar con archivos, primero se sube cada uno a `POST /api/productos/imagen` y se mandan las URLs devueltas.
La respuesta (`ProductoResponseDTO`) trae `image_url` (la imagen principal) e `imagenes` (todas, en orden).
Sin imágenes o con más de 6 responde `400`.

### Carrito — `/api/carrito`

Las operaciones individuales se limitan al carrito del usuario autenticado; `GET /todos`
es exclusivo de ADMIN. El carrito también se crea automáticamente la primera vez que se usa.

| Método | Endpoint | Descripción | Acceso | Respuesta |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/carrito/todos` | Lista todos los carritos. | ADMIN | `200` |
| `GET` | `/api/carrito` | Carrito con ítems, subtotales y total. | Autenticado | `200` |
| `GET` | `/api/carrito/{id}` | Busca un carrito propio (o cualquiera para ADMIN). | Dueño / ADMIN | `200` / `404` |
| `POST` | `/api/carrito` | Crea el carrito propio si no existe; si existe, lo devuelve. | Autenticado | `200` |
| `POST` | `/api/carrito/items` | Agrega un producto (si ya estaba, suma la cantidad). | Autenticado | `200` / `400` / `404` / `409` sin stock |
| `PUT` | `/api/carrito/items/{productoId}` | Cambia la cantidad de un ítem. | Autenticado | `200` / `400` / `404` / `409` sin stock |
| `DELETE` | `/api/carrito/items/{productoId}` | Saca un producto del carrito. | Autenticado | `200` / `404` |
| `DELETE` | `/api/carrito` | Vacía el carrito. | Autenticado | `204` |
| `DELETE` | `/api/carrito/{id}` | Elimina el carrito y sus ítems. | Dueño / ADMIN | `204` / `404` |
| `POST` | `/api/carrito/checkout` | Compra el carrito: valida y descuenta stock, genera la orden y vacía el carrito. | Autenticado | `201` / `400` carrito vacío / `409` sin stock |

Bodies:

```json
{ "productoId": 1, "cantidad": 2 }
```

```json
{ "cantidad": 3 }
```

El checkout es un método `@Transactional`: si falla cualquier paso (por ejemplo, un producto
sin stock) se hace rollback y no queda stock descontado ni una orden a medio crear.

### Órdenes (mis compras) — `/api/ordenes`

| Método | Endpoint | Descripción | Acceso | Respuesta |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/ordenes` | Compras del usuario autenticado, de la más reciente a la más vieja. | Autenticado | `200` |
| `GET` | `/api/ordenes/{id}` | Detalle de una compra propia. | Autenticado | `200` / `404` si no existe o es de otro usuario |

### Ventas — `/api/ventas`

| Método | Endpoint | Descripción | Acceso | Respuesta |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/ventas` | Histórico de todas las órdenes, con comprador, ítems y total. | `ADMIN` | `200` / `403` |

--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/ventas` | Lista el histórico de ventas registradas. | Autenticado | `200` |

---

## Seguridad

La autenticación es *stateless* y se resuelve con JWT:

1. El usuario se registra en `/api/usuarios/register`. La contraseña se guarda hasheada con **BCrypt**, nunca en texto plano.
2. En `/api/usuarios/login`, el `AuthenticationManager` valida las credenciales y `JwtUtil` firma un token con el email y los roles del usuario.
3. El token **no va en el body**: se manda en el header `Set-Cookie` como cookie `sesion`, que el navegador guarda y reenvía sola en cada request (el front usa `fetch` con `credentials: 'include'`):

   ```text
   Set-Cookie: sesion=<jwt>; Path=/; Max-Age=86400; HttpOnly; SameSite=Strict
   ```

   - `HttpOnly`: JavaScript no la puede leer (`document.cookie`), así un ataque **XSS** no puede robar el token. Por eso el front no lo guarda en `localStorage`.
   - `SameSite=Strict`: el navegador no la envía en requests iniciados desde otro sitio, lo que protege de **CSRF**. El front (`localhost:5173`) y el back (`localhost:8080`) son el mismo sitio: el puerto no cuenta.
   - `Secure` está desactivado porque en desarrollo se usa http; en producción, con HTTPS, va activado.
4. En cada request posterior, `JwtFilter` (registrado antes de `UsernamePasswordAuthenticationFilter`) toma el token, valida la firma y carga la autenticación en el `SecurityContext`.
5. `/api/usuarios/logout` borra la cookie (JavaScript no puede borrar una cookie `HttpOnly`).

Para probar con **Postman** u otro cliente, también se acepta el header. Si viene, tiene prioridad sobre la cookie; el front nunca lo manda:

```text
Authorization: Bearer <token>
```

Postman guarda la cookie del último login y la manda en los requests siguientes. Para probar como otro usuario se usa el header con su token, que se copia de la pestaña *Cookies* de la respuesta del login.

Reglas de acceso definidas en `SecurityConfig`:

| Regla | Endpoints |
| :--- | :--- |
| Público | `POST /api/usuarios/register`, `POST /api/usuarios/login`, `GET /api/productos/**`, `/api/categorias/**`, `GET /images/**` (imágenes de productos) |
| Requiere autenticación | `POST`, `PUT` y `DELETE` sobre `/api/productos/**`, `/api/carrito/**`, `/api/ventas`, y cualquier otra ruta |
| Requiere rol `ADMIN` | `/api/admin/**` |

El enum `Role` define `USER`, `ADMIN` y `VENDEDOR`. Las autoridades se exponen a Spring Security con el prefijo `ROLE_`.

---

## Manejo de errores

`GlobalExceptionHandler` centraliza las excepciones de dominio con `@ControllerAdvice`:

| Excepción | HTTP |
| :--- | :--- |
| `ProductoNotFoundException`, `CategoriaNotFoundException`, `CarritoNotFoundException`, `UsuarioNotFoundException`, `ProductoNoEnCarritoException`, `OrdenNotFoundException` | `404 Not Found` |
| `ContrasenaIncorrectaException` | `401 Unauthorized` |
| `UsuarioAlreadyExistsException`, `StockInsuficienteException`, `ProductoConVentasException` | `409 Conflict` |
| `PrecioNegativoException`, `CantidadInvalidaException`, `CarritoVacioException`, `ImagenInvalidaException`, `IllegalArgumentException`, body inválido, parámetro de URL con tipo inválido, campo faltante en un multipart | `400 Bad Request` |
| `MaxUploadSizeExceededException` (imagen de más de 5 MB) | `413 Content Too Large` |
| URL que no corresponde a ningún endpoint | `404 Not Found` |
| `Exception` (fallback; el detalle queda en el log del servidor, al cliente se le da un mensaje genérico) | `500 Internal Server Error` |

Todas las respuestas de error, incluidos los `401`/`403` que genera `SecurityConfig`, tienen el mismo cuerpo JSON (`ErrorResponse`):

```json
{ "status": 404, "error": "Not Found", "mensaje": "No se encontró el producto con id: 99", "timestamp": "2026-10-23T19:30:00" }
```

---

## Cómo ejecutar el proyecto

### 1. Levantar la base de datos

Con Docker (contenedor MySQL sin contraseña, tal como espera la configuración por defecto):

```bash
docker run --name mysql-open -e MYSQL_ALLOW_EMPTY_PASSWORD=yes -p 3306:3306 -d mysql:8
```

La base `ecommerce_db3` se crea sola gracias a `createDatabaseIfNotExist=true`, y Hibernate genera
las tablas con `spring.jpa.hibernate.ddl-auto=update`.

Como alternativa, `src/main/resources/application.properties` incluye comentada la configuración
de **H2 en memoria**, útil para correr la app sin instalar MySQL.

### 2. Levantar la aplicación

```bash
./mvnw spring-boot:run
```

La API queda disponible en `http://localhost:8080`.

### 3. Cargar los datos (backup de la base)

En [`data-testing/backup/`](data-testing/backup/) hay un backup completo de la base que usa el equipo
(estructura y datos). Es la única fuente de datos de prueba del proyecto.

| Archivo | Qué es |
| :--- | :--- |
| `ecommerce_db3.sql` | Dump de la base: estructura y datos de todas las tablas |
| `restore.sh` | Carga el backup en tu base local |
| `backup.sh` | Actualiza el backup con el estado de tu base local |

Las imágenes de los productos están en la carpeta [`images/`](images/) de la raíz del back, que **se
versiona**: ahí están las del catálogo inicial y las que suben los vendedores (`POST /api/productos/imagen`).
El back las sirve en `http://localhost:8080/images/<archivo>`, que es lo que guarda `producto_imagenes.url`.
Algunos productos usan una URL externa (`placehold.co`), que también es válida.
Si subís imágenes probando la app, aparecen en `git status`: commiteá solo las que correspondan.

**Antes de correr cualquiera de los dos scripts**, el contenedor `mysql-open` tiene que estar corriendo.
Si está apagado, se prende con:

```bash
docker start mysql-open
```

#### Cargar el backup en tu base

Con el back apagado (si Hibernate está conectado mientras se recrean las tablas puede dar errores),
desde la raíz del back:

```bash
bash data-testing/backup/restore.sh
```

> **Atención:** todo lo que tengas cargado en tu base se pierde. Por cada tabla del backup
> (`usuarios`, `productos`, `categorias`, `carrito`, `carrito_productos`, `favoritos`, `ordenes`,
> `orden_items`) se borra la tabla y se vuelve a crear con los datos del backup: no se mezclan.
> Las tablas que no estén en el backup y las otras bases de MySQL no se tocan.
> Si querés guardar lo que tenés antes, corré primero `backup.sh` (y descartá el cambio con
> `git restore data-testing/backup/` si no lo querés commitear).

Al terminar, el script imprime `Base ecommerce_db3 restaurada`. Después levantá el back normalmente.

#### Actualizar el backup

Para guardar el estado de tu base local en el repo, desde la raíz del back:

```bash
bash data-testing/backup/backup.sh
```

Reemplaza `ecommerce_db3.sql` por lo que tengas ahora y al terminar imprime
`Backup generado en data-testing/backup/ecommerce_db3.sql`. Si agregaste productos con imágenes subidas,
commiteá también esas imágenes de `images/`, para que el backup no quede apuntando a archivos que no están.

El dump guarda una fila por línea y no incluye la fecha, así que antes de commitear podés ver
exactamente qué datos cambiaron (y si no cambió nada, git no muestra diferencias):

```bash
git diff data-testing/backup/
```

> El dump incluye la tabla `usuarios` (emails y contraseñas hasheadas con BCrypt).
> No subas al backup usuarios con contraseñas que uses en otros servicios.

#### Cómo correr los scripts en cada sistema

- **Windows:** desde **Git Bash**. No uses `bash` desde PowerShell: según la instalación puede abrir el
  bash de WSL, que no tiene las mismas rutas y el script falla. Para correrlos desde PowerShell, llamá
  directo al bash de Git:

  ```powershell
  & "C:\Program Files\Git\bin\bash.exe" data-testing/backup/restore.sh
  ```

- **macOS / Linux:** desde la terminal, con los mismos comandos `bash data-testing/backup/...`.

Los scripts ubican sus rutas a partir de dónde están, así que también funcionan si los corrés desde otra
carpeta. Si algo falla, el script se corta en ese paso y el error queda en la terminal; el detalle de
cada paso está comentado en los propios scripts.

---

## Configuración

Parámetros relevantes de `src/main/resources/application.properties`:

| Propiedad | Valor por defecto |
| :--- | :--- |
| `spring.datasource.url` | `jdbc:mysql://localhost:3306/ecommerce_db3?createDatabaseIfNotExist=true` |
| `spring.datasource.username` | `root` |
| `spring.jpa.hibernate.ddl-auto` | `update` |
| `jwt.expiration` | `86400000` (24 hs) |
| `app.images.dir` | `images` (carpeta de imágenes de productos; se versiona y se crea al arrancar si no existe) |
| `app.public-url` | `http://localhost:8080` (base de la `image_url` que devuelve la subida) |
| `spring.servlet.multipart.max-file-size` | `5MB` |

> El `jwt.secret` versionado es una clave de desarrollo. En un despliegue real debe moverse a una variable de entorno.

---

## Pendientes / próximos pasos

Alcance que forma parte del enunciado del TPO y todavía no está implementado:

- Carga de **imágenes** en la publicación de un producto.
- Listado de productos **ordenado alfabéticamente** y búsqueda por término.

---

## Integrantes

- Miguel Metz
- Franco Poloni
- Renata García
- Dolores Pavón
