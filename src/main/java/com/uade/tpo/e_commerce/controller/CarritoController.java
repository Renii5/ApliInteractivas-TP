package com.uade.tpo.e_commerce.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
import com.uade.tpo.e_commerce.model.Producto;
import com.uade.tpo.e_commerce.service.CarritoService;

/**
 * Encargado de recibir request http desde los clientes
 * y devolver respuestas http con los datos solicitados.
 * CarritoController
 */
@RestController
@RequestMapping("/api/carrito")
public class CarritoController {

    private final CarritoService carritoService;

    CarritoController(CarritoService carritoService) {
        this.carritoService = carritoService;
    }

    //get http://localhost:8080/api/carrito/1 -> productos del carrito 1
    @GetMapping("/{carritoId}")
    public ResponseEntity<List<ProductoResponseDTO>> getProductosDelCarrito(@PathVariable Long carritoId) {
        List<ProductoResponseDTO> productos = carritoService.getProductosDelCarrito(carritoId);
        ResponseEntity<List<ProductoResponseDTO>> response = new ResponseEntity<>(productos, HttpStatus.OK);
        return response;
    }

        // delete http://localhost:8080/api/carrito/1 -> elimina el carrito 1
    @DeleteMapping("/{carritoId}")
    public ResponseEntity<Void> eliminarCarrito(@PathVariable Long carritoId) {
        carritoService.eliminarCarrito(carritoId);
        return ResponseEntity.noContent().build();
    }


}
