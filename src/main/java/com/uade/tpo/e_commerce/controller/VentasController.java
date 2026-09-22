package com.uade.tpo.e_commerce.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.dto.OrdenResponseDTO;
import com.uade.tpo.e_commerce.service.OrdenService;

/**
 * Encargado de recibir request http desde los clientes
 * y devolver respuestas http con los datos solicitados.
 * Histórico completo de ventas: solo ADMIN (regla en SecurityConfig).
 * VentasController
 */
@RestController
@RequestMapping("/api/ventas")
public class VentasController {

    private final OrdenService ordenService;

    public VentasController(OrdenService ordenService) {
        this.ordenService = ordenService;
    }

    //get http://localhost:8080/api/ventas -> listar todas las ventas (órdenes de todos los usuarios)
    @GetMapping
    public ResponseEntity<List<OrdenResponseDTO>> getAllVentas() {
        return ResponseEntity.ok(ordenService.getAllOrdenes());
    }

}
