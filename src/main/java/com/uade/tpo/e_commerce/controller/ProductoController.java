package com.uade.tpo.e_commerce.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
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

    //get http://localhost:8080/api/productos -> listar todos los productos
    @GetMapping
    public ResponseEntity<List<ProductoResponseDTO>> getAllProductos() {
        System.out.println("\n\nCONTROLLER >> Fetching all productos DTO\n\n");
        List<ProductoResponseDTO> productos = productoService.getAllProductos();
        ResponseEntity<List<ProductoResponseDTO>> response = new ResponseEntity<>(productos, HttpStatus.OK);
        return response;
    }
    
        //delete http://localhost:8080/api/productos/1 -> eliminar el producto 1
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarProducto(@PathVariable Long id) {
        productoService.eliminarProducto(id);
        return ResponseEntity.noContent().build();
    }


}
