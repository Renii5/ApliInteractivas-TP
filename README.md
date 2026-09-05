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
| **Carrito** | Consulta de los productos que contiene un carrito y eliminación del carrito. | Funcional |
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
| `Producto` | `productos` | id, nombre, description, precio | `@ManyToOne` → `Categoria` |
| `Carrito` | `carrito` | id, userId | — |
| `CarritoProductos` | `carrito_productos` | id, cantidad | `@ManyToOne` → `Carrito`, `@ManyToOne` → `Producto` |
| `Ventas` | `ventas` | id, productoId, cantidad, precioUnitario, fecha | — |

La relación N:M entre `Carrito` y `Producto` se modela de forma explícita mediante la entidad
intermedia `CarritoProductos`, que además guarda la cantidad de cada ítem. La consulta
`findByCarritoId` usa `@EntityGraph` para traer el producto en la misma query y evitar el
problema N+1.

---

## API REST

Base URL: `http://localhost:8080`

### Usuarios y autenticación — `/api/usuarios`

| Método | Endpoint | Descripción | Acceso | Respuesta |
| :--- | :--- | :--- | :--- | :--- |
| `POST` | `/api/usuarios/register` | Registra un usuario nuevo (rol `USER` por defecto). | Público | `200` / `409` si el email ya existe |
| `POST` | `/api/usuarios/login` | Valida credenciales y devuelve el JWT. | Público | `200` con token / `401` / `404` |

Body de registro:

```json
{ "nombre": "Juan", "apellido": "Perez", "email": "juan@mail.com", "password": "1234" }
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
| `PUT` | `/api/productos/{id}` | Actualiza un producto. | Autenticado | `200` / `400` / `404` |
| `DELETE` | `/api/productos/{id}` | Elimina un producto. | Autenticado | `204` / `404` |

Body de alta/modificación:

```json
{ "nombre": "RTX 4070", "descripcion": "GPU 12GB GDDR6X", "precio": 850000.0, "categoriaId": 1 }
```

### Carrito — `/api/carrito`

| Método | Endpoint | Descripción | Acceso | Respuesta |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/carrito/{carritoId}` | Lista los productos contenidos en el carrito. | Autenticado | `200` / `404` si el carrito no existe |
| `DELETE` | `/api/carrito/{carritoId}` | Elimina el carrito. | Autenticado | `204` / `404` |

> Un carrito existente pero vacío devuelve `200` con lista vacía; un carrito inexistente devuelve `404`.

### Ventas — `/api/ventas`

| Método | Endpoint | Descripción | Acceso | Respuesta |
| :--- | :--- | :--- | :--- | :--- |
| `GET` | `/api/ventas` | Lista el histórico de ventas registradas. | Autenticado | `200` |

---

## Seguridad (plus opcional)

La autenticación es *stateless* y se resuelve con JWT:

1. El usuario se registra en `/api/usuarios/register`. La contraseña se guarda hasheada con **BCrypt**, nunca en texto plano.
2. En `/api/usuarios/login`, el `AuthenticationManager` valida las credenciales y `JwtUtil` firma un token con el email y los roles del usuario.
3. En cada request posterior, `JwtFilter` (registrado antes de `UsernamePasswordAuthenticationFilter`) lee el header `Authorization`, valida la firma y carga la autenticación en el `SecurityContext`.

Header a enviar en los endpoints protegidos:

```text
Authorization: Bearer <token>
```

Reglas de acceso definidas en `SecurityConfig`:

| Regla | Endpoints |
| :--- | :--- |
| Público | `POST /api/usuarios/register`, `POST /api/usuarios/login`, `GET /api/productos/**`, `/api/categorias/**` |
| Requiere autenticación | `POST`, `PUT` y `DELETE` sobre `/api/productos/**`, `/api/carrito/**`, `/api/ventas`, y cualquier otra ruta |
| Requiere rol `ADMIN` | `/api/admin/**` |

El enum `Role` define `USER`, `ADMIN` y `VENDEDOR`. Las autoridades se exponen a Spring Security con el prefijo `ROLE_`.

---

## Manejo de errores

`GlobalExceptionHandler` centraliza las excepciones de dominio con `@ControllerAdvice`:

| Excepción | HTTP |
| :--- | :--- |
| `ProductoNotFoundException`, `CategoriaNotFoundException`, `CarritoNotFoundException`, `UsuarioNotFoundException` | `404 Not Found` |
| `ContrasenaIncorrectaException` | `401 Unauthorized` |
| `UsuarioAlreadyExistsException` | `409 Conflict` |
| `PrecioNegativoException`, `IllegalArgumentException` | `400 Bad Request` |
| `Exception` (fallback) | `500 Internal Server Error` |

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

### 3. Cargar datos de prueba (opcional)

En [`data-testing/sql/`](data-testing/sql/) hay scripts de poblado. Deben correrse en este orden,
porque hay dependencias por clave foránea: `usuarios-insert.sql`, `productos-insert.sql`,
`carrito-insert.sql` y `ventas-insert.sql`. Cada archivo documenta en su encabezado el comando
`docker exec` con el que se ejecuta contra el contenedor `mysql-open`.

---

## Configuración

Parámetros relevantes de `src/main/resources/application.properties`:

| Propiedad | Valor por defecto |
| :--- | :--- |
| `spring.datasource.url` | `jdbc:mysql://localhost:3306/ecommerce_db3?createDatabaseIfNotExist=true` |
| `spring.datasource.username` | `root` |
| `spring.jpa.hibernate.ddl-auto` | `update` |
| `jwt.expiration` | `86400000` (24 hs) |

> El `jwt.secret` versionado es una clave de desarrollo. En un despliegue real debe moverse a una variable de entorno.

---

## Pendientes / próximos pasos

Alcance que forma parte del enunciado del TPO y todavía no está implementado:

- Control de **stock** en `Producto` y validación al agregar al carrito.
- Endpoints de **alta y baja de ítems** del carrito (`POST` / `DELETE` de un ítem puntual).
- **Checkout** del carrito: cálculo del total, descuento de stock y generación de la venta.
- Carga de **imágenes** en la publicación de un producto.
- Listado de productos **ordenado alfabéticamente** y búsqueda por término.

---

## Integrantes

- Miguel Metz
- Franco Poloni
- Renata García
- Dolores Pavón
