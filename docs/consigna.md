# Trabajo Práctico Obligatorio — Sistema de E-Commerce

**Aplicaciones Interactivas**
*Encabezado del documento original: "Primer Cuatrimestre 2025"*

---

## Enunciado

Una empresa solicitó el desarrollo de una aplicación web que les permita a los sus clientes realizar compras de forma online debido a la transformación digital que está realizando dicha empresa.

Además, se desea disponer de un sistema que permita la publicación de un producto que se quiere vender por dicha plataforma como también gestionar el mismo (modificar, eliminar, etc).

En pos de todo lo detallado, se deja constancia de todos los requerimientos (casos de uso) que debe contemplar dicha aplicación web:

---

## Requerimientos (casos de uso)

### 1. Gestión de Usuarios

- **Registrar** al usuario que genera la compra. Esta registración debe solicitar:
  - nombre de usuario
  - mail
  - contraseña
  - nombre
  - apellido
- **Login** de usuario para poder identificar a los usuarios que quieran operar en el sitio. El mismo solicitará el **mail** y la **contraseña**.

### 2. Catálogo de Productos

- Una vez que el usuario se autentique, deberá visualizar la **home** del sitio, en donde se deben ver dos secciones:
  - Un listado de productos ordenados **alfabéticamente**.
  - Un listado de los tipos de productos que vende el sitio (las **categorías**).
- Al seleccionar alguno de los productos que se visualizan, podrá ir al **detalle** del mismo, en donde visualizará una imagen más ampliada junto a su descripción.
- En dicho detalle, podrá realizar el agregado del producto al catálogo.
- En caso de que el producto **no tenga stock**, el usuario visualizará dicha casuística y **no podrá agregarlo al carrito**.

### 3. Carrito de Compras

- **Gestión del carrito**, en el cual podrá:
  - agregar un ítem
  - vaciar el carrito
  - eliminar un ítem del carrito
- Podrá realizar el **checkout** del carrito, calculando el **costo total** de los productos.
- Una vez realizado el checkout del carrito (**sin procesamiento de pago**), se **descontará el stock** de dicho producto. Se deberá **validar si hay stock** correspondiente.

### 4. Gestión de Productos

- El usuario podrá realizar el **alta de una publicación** de un producto adjuntando **una o más fotos** del producto a vender. En dicha publicación deberá adjuntar la **descripción** del producto junto con la **categoría** a la cual pertenece.
- El usuario que crea dicho producto podrá **manejar el stock** del mismo.
- El usuario podrá **eliminar** dicho producto.

---

## Requisitos para la entrega

El trabajo por realizar es el siguiente:

- Desarrollar una **aplicación web** que permita cumplir con los requerimientos enumerados.
- A partir del negocio entregado, agregar la **capa de persistencia**.
- Construir una **API REST** para acceder a la información mencionada en su totalidad (completa o filtrada).

---

## Resumen de entregables

| # | Entregable | Detalle |
|---|------------|---------|
| 1 | Aplicación web | Cumple todos los casos de uso listados |
| 2 | Capa de persistencia | Sobre el negocio entregado |
| 3 | API REST | Acceso completo o filtrado a la información |
