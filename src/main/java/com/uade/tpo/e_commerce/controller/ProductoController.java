package com.uade.tpo.e_commerce.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.dto.ProductoRequestDTO;
import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
import com.uade.tpo.e_commerce.dto.StockRequestDTO;
import com.uade.tpo.e_commerce.service.ProductoService;

/**
 * Encargado de recibir request http desde los clientes
 * y devolver respuestas http con los datos solicitados.
 * ProductoController
 */
@RestController
@RequestMapping("/api/productos")
public class ProductoController {

    private final ProductoService productoService;

    public ProductoController(ProductoService productoService) {
        this.productoService = productoService;
    }

    // get http://localhost:8080/api/productos -> todos, ordenados alfabéticamente
    // get http://localhost:8080/api/productos?categoriaId=1 -> filtrados por categoría
    // get http://localhost:8080/api/productos?busqueda=rtx -> filtrados por nombre
    @GetMapping
    public ResponseEntity<List<ProductoResponseDTO>> getAllProductos(
            @RequestParam(required = false) Long categoriaId,
            @RequestParam(required = false) String busqueda) {
        return ResponseEntity.ok(productoService.getAllProductos(categoriaId, busqueda));
    }

    // get http://localhost:8080/api/productos/mios -> productos publicados por el usuario logueado
    // Authentication lo inyecta Spring Security: es lo que JwtFilter cargó en el SecurityContext
    @GetMapping("/mios")
    public ResponseEntity<List<ProductoResponseDTO>> getMisProductos(Authentication authentication) {
        return ResponseEntity.ok(productoService.getProductosDelVendedor(authentication.getName()));
    }

    // get http://localhost:8080/api/productos/1 -> detalle del producto 1
    @GetMapping("/{id}")
    public ResponseEntity<ProductoResponseDTO> getProductoById(@PathVariable Long id) {
        return ResponseEntity.ok(productoService.getProductoById(id));
    }

    // post http://localhost:8080/api/productos -> publica un producto; el vendedor es el usuario del token
    @PostMapping
    public ResponseEntity<ProductoResponseDTO> createProducto(
            @RequestBody ProductoRequestDTO productoRequest,
            Authentication authentication) {
        ProductoResponseDTO productoCreado = productoService.createProducto(productoRequest, authentication.getName());
        return new ResponseEntity<>(productoCreado, HttpStatus.CREATED);
    }

    // put http://localhost:8080/api/productos/1 -> modifica el producto 1 (solo su vendedor o un ADMIN)
    @PutMapping("/{id}")
    public ResponseEntity<ProductoResponseDTO> updateProducto(
            @PathVariable Long id,
            @RequestBody ProductoRequestDTO productoRequest,
            Authentication authentication) {
        return ResponseEntity.ok(productoService.updateProducto(id, productoRequest, authentication.getName()));
    }

    // patch http://localhost:8080/api/productos/1/stock -> actualiza solo el stock (solo su vendedor o un ADMIN)
    @PatchMapping("/{id}/stock")
    public ResponseEntity<ProductoResponseDTO> actualizarStock(
            @PathVariable Long id,
            @RequestBody StockRequestDTO request,
            Authentication authentication) {
        return ResponseEntity.ok(productoService.actualizarStock(id, request.getStock(), authentication.getName()));
    }

    // delete http://localhost:8080/api/productos/1 -> elimina el producto 1 (solo su vendedor o un ADMIN)
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarProducto(@PathVariable Long id, Authentication authentication) {
        productoService.eliminarProducto(id, authentication.getName());
        return ResponseEntity.noContent().build();
    }
}
