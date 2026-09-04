package com.uade.tpo.e_commerce.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.model.Producto;
import com.uade.tpo.e_commerce.dto.ProductoRequestDTO;
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

    ProductoController(ProductoService productoService) {
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

    @PostMapping
    public ResponseEntity<ProductoResponseDTO> createProducto(@RequestBody ProductoRequestDTO productoRequest) {
        ProductoResponseDTO productoCreado = productoService.createProducto(productoRequest);
        return new ResponseEntity<>(productoCreado, HttpStatus.CREATED);
    }

}
