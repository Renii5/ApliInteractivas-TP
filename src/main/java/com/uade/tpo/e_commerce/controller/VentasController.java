package com.uade.tpo.e_commerce.controller;

import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.model.Ventas;
import com.uade.tpo.e_commerce.service.VentasService;

/**
 * Encargado de recibir request http desde los clientes
 * y devolver respuestas http con los datos solicitados.
 * VentasController
 */
@RestController
@RequestMapping("/api/ventas")
public class VentasController {

    private final VentasService ventasService;

    VentasController(VentasService ventasService) {
        this.ventasService = ventasService;
    }

    //get http://localhost:8080/api/ventas -> listar todas las ventas
    @GetMapping
    public List<Ventas> getAllVentas() {
        return ventasService.getAllVentas();
    }

}
