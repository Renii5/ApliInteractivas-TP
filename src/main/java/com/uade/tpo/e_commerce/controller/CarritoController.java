package com.uade.tpo.e_commerce.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.dto.CantidadRequestDTO;
import com.uade.tpo.e_commerce.dto.CarritoItemRequestDTO;
import com.uade.tpo.e_commerce.dto.CarritoResponseDTO;
import com.uade.tpo.e_commerce.dto.OrdenResponseDTO;
import com.uade.tpo.e_commerce.service.CarritoService;

/**
 * Encargado de recibir request http desde los clientes
 * y devolver respuestas http con los datos solicitados.
 * Ningún endpoint recibe el id del carrito: siempre se usa el del usuario del token,
 * así nadie puede ver o modificar el carrito de otro.
 * CarritoController
 */
@RestController
@RequestMapping("/api/carrito")
public class CarritoController {

    private final CarritoService carritoService;

    public CarritoController(CarritoService carritoService) {
        this.carritoService = carritoService;
    }

    // get http://localhost:8080/api/carrito -> carrito del usuario logueado, con subtotales y total
    @GetMapping
    public ResponseEntity<CarritoResponseDTO> getCarrito(Authentication authentication) {
        return ResponseEntity.ok(carritoService.getCarrito(authentication.getName()));
    }

    // post http://localhost:8080/api/carrito/items -> agrega un producto { "productoId": 1, "cantidad": 2 }
    @PostMapping("/items")
    public ResponseEntity<CarritoResponseDTO> agregarItem(
            @RequestBody CarritoItemRequestDTO request,
            Authentication authentication) {
        return ResponseEntity.ok(carritoService.agregarItem(
                authentication.getName(), request.getProductoId(), request.getCantidad()));
    }

    // put http://localhost:8080/api/carrito/items/1 -> cambia la cantidad del producto 1 { "cantidad": 3 }
    @PutMapping("/items/{productoId}")
    public ResponseEntity<CarritoResponseDTO> modificarCantidad(
            @PathVariable Long productoId,
            @RequestBody CantidadRequestDTO request,
            Authentication authentication) {
        return ResponseEntity.ok(carritoService.modificarCantidad(
                authentication.getName(), productoId, request.getCantidad()));
    }

    // delete http://localhost:8080/api/carrito/items/1 -> saca el producto 1 del carrito
    @DeleteMapping("/items/{productoId}")
    public ResponseEntity<CarritoResponseDTO> eliminarItem(
            @PathVariable Long productoId,
            Authentication authentication) {
        return ResponseEntity.ok(carritoService.eliminarItem(authentication.getName(), productoId));
    }

    // delete http://localhost:8080/api/carrito -> vacía el carrito (el carrito se conserva)
    @DeleteMapping
    public ResponseEntity<Void> vaciarCarrito(Authentication authentication) {
        carritoService.vaciarCarrito(authentication.getName());
        return ResponseEntity.noContent().build();
    }

    // post http://localhost:8080/api/carrito/checkout -> compra el carrito y genera la orden
    @PostMapping("/checkout")
    public ResponseEntity<OrdenResponseDTO> checkout(Authentication authentication) {
        OrdenResponseDTO orden = carritoService.checkout(authentication.getName());
        return new ResponseEntity<>(orden, HttpStatus.CREATED);
    }
}
