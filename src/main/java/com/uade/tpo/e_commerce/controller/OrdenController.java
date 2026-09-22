package com.uade.tpo.e_commerce.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.dto.OrdenResponseDTO;
import com.uade.tpo.e_commerce.service.OrdenService;

/**
 * Encargado de recibir request http desde los clientes
 * y devolver respuestas http con los datos solicitados.
 * "Mis compras": órdenes del usuario autenticado.
 * OrdenController
 */
@RestController
@RequestMapping("/api/ordenes")
public class OrdenController {

    private final OrdenService ordenService;

    public OrdenController(OrdenService ordenService) {
        this.ordenService = ordenService;
    }

    // get http://localhost:8080/api/ordenes -> compras del usuario logueado, de la más reciente a la más vieja
    @GetMapping
    public ResponseEntity<List<OrdenResponseDTO>> getMisOrdenes(Authentication authentication) {
        return ResponseEntity.ok(ordenService.getOrdenesDelUsuario(authentication.getName()));
    }

    // get http://localhost:8080/api/ordenes/1 -> detalle de la orden 1 (404 si no es del usuario)
    @GetMapping("/{id}")
    public ResponseEntity<OrdenResponseDTO> getOrden(@PathVariable Long id, Authentication authentication) {
        return ResponseEntity.ok(ordenService.getOrdenDelUsuario(id, authentication.getName()));
    }
}
