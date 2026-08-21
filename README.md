# PC Hardware Marketplace (Estilo Compra Gamer)

Plataforma marketplace especializada en la compra y venta de componentes de hardware y computación. Permite la interacción fluida entre compradores y vendedores con gestión de inventario, catálogo, procesamiento de pedidos, favoritos y devoluciones.

---

## Arquitectura y Tecnologías

- **Arquitectura:** Separación en capas (*Controllers / Handlers*, *Services / Business Logic*, *Repositories / Data Access*, *Models / Entities*).
- **Base de Datos:** MySQL (Diseño relacional para usuarios, roles, publicaciones, carritos, órdenes y transacciones).
- **Control de Versiones:** Git / GitHub (Flujo de trabajo basado en ramas por feature/fix).

---

## 📌 Documentación de Endpoints (API Reference)

### Autenticación & Cuenta (`/auth`, `/account`)

| Método | Endpoint | Descripción |
| :--- | :--- | :--- |
| `POST` | `/sign-up/` | Registro de nuevos usuarios en la plataforma. |
| `POST` | `/login/` | Autenticación y generación de token de sesión / JWT. |
| `GET` | `/account/` | Consulta del perfil de usuario autenticado. |

---

### Catálogo y Navegación (`/catalog`)

| Método | Endpoint | Descripción | Estado |
| :--- | :--- | :--- | :--- |
| `GET` | `/catalog/` | Listar todos los productos y componentes disponibles. | ✅ Activo |
| `GET` | `/catalog/?id={id}` | Filtrar productos por categoría o identificador de producto. | ✅ Activo |
| `GET` | `/catalog/?search={param}` | Búsqueda por término/nombre de componente. | ⏳ *Próximamente* |

---

### Compradores (`/buyers` & `/purchases`)

| Método | Endpoint / Acción | Descripción |
| :--- | :--- | :--- |
| `GET` | `/purchases/` | Listar el historial de compras realizadas por el usuario. |
| `POST` | `/favorites/add` *(sugerido)* | Agregar un producto a la lista de favoritos. |
| `POST` | `/cart/add` *(sugerido)* | Añadir componente al carrito de compras. |
| `POST` | `/checkout/` *(sugerido)* | Iniciar flujo de compra / checkout. |
| `POST` | `/payments/` *(sugerido)* | Procesar el pago de la orden generada. |
| `POST` | `/purchases/{id}/refund` | Solicitar devolución de un producto comprado. |

---

### 📦 Vendedores (`/sellers` & `/sales`)

| Método | Endpoint / Acción | Descripción |
| :--- | :--- | :--- |
| `POST` | `/sellers/publish/` | Publicar nuevo producto/componente a la venta. |
| `GET` | `/sales/` | Listar el historial y estado de ventas del vendedor. |
| `PATCH` | `/sales/{id}/refund-status` | Gestionar y aprobar/rechazar solicitudes de devolución. |
| `GET/POST`| `/reviews/` | Gestión y visualización de reseñas y calificaciones de productos. |

---

## Logística y Envíos (Visión General)

El sistema contempla dos modalidades de entrega para cada orden de compra:
1. **Retiro en tienda / Punto de entrega:** Coordinación directa con el punto de distribución o local del vendedor.
2. **Envío a domicilio:** Integración o registro de despacho mediante paquetería/courier.

> *Nota: La logística detallada se aborda a alto nivel dentro del core y puede desacoplarse como microservicio o integración de terceros a futuro.*

---

## 📂 Estructura  de Capas

```text
src/
├── controllers/    # Manejo de peticiones HTTP, validación de entrada y respuestas
├── services/       # Lógica de negocio, reglas de compra, validación de stock
├── repositories/   # Consultas a la base de datos MySQL (Queries / ORM)
├── models/         # Entidades de dominio (User, Product, Order, Category, Review)
├── config/         # Conexión a base de datos y variables de entorno
└── routes/         # Definición y mapeo de rutas y middlewares de auth
