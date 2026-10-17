package com.uade.tpo.e_commerce.controller;

import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
import com.uade.tpo.e_commerce.service.FavoritoService;

/**
 * Encargado de recibir request http desde los clientes
 * y devolver respuestas http con los datos solicitados.
 * Todos los favoritos pertenecen al usuario autenticado.
 */
@RestController
@RequestMapping("/api/favoritos")
public class FavoritoController {

    private final FavoritoService favoritoService;

    public FavoritoController(FavoritoService favoritoService) {
        this.favoritoService = favoritoService;
    }

    // GET /api/favoritos -> productos favoritos del usuario autenticado
    @GetMapping
    public ResponseEntity<List<ProductoResponseDTO>> getFavoritos(Authentication authentication) {
        return ResponseEntity.ok(favoritoService.getFavoritos(authentication.getName()));
    }

    // POST /api/favoritos/1 -> agrega el producto 1 a los favoritos
    @PostMapping("/{productoId}")
    public ResponseEntity<Void> agregarFavorito(
            @PathVariable Long productoId,
            Authentication authentication) {
        favoritoService.agregarFavorito(authentication.getName(), productoId);
        return ResponseEntity.noContent().build();
    }

    // DELETE /api/favoritos/1 -> quita el producto 1 de los favoritos
    @DeleteMapping("/{productoId}")
    public ResponseEntity<Void> eliminarFavorito(
            @PathVariable Long productoId,
            Authentication authentication) {
        favoritoService.eliminarFavorito(authentication.getName(), productoId);
        return ResponseEntity.noContent().build();
    }
}
