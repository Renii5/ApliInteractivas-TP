package com.uade.tpo.e_commerce.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.model.Producto;
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
    public List<Producto> getAllProductos() {
        return productoService.getAllProductos();
    }

}
