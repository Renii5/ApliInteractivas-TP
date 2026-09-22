package com.uade.tpo.e_commerce.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.dto.LoginRequest;
import com.uade.tpo.e_commerce.dto.LoginResponseDTO;
import com.uade.tpo.e_commerce.dto.RegisterRequest;
import com.uade.tpo.e_commerce.dto.UsuarioResponseDTO;
import com.uade.tpo.e_commerce.service.AuthenticationService;
import com.uade.tpo.e_commerce.service.UsuarioService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/usuarios")
@RequiredArgsConstructor
public class UsuarioController {

    private final AuthenticationService authenticationService;
    private final UsuarioService usuarioService;

    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody RegisterRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(authenticationService.register(request));
    }

    @PostMapping("/login")
    public ResponseEntity<LoginResponseDTO> login(@RequestBody LoginRequest request) {
        return ResponseEntity.ok(authenticationService.authenticate(request));
    }

    @GetMapping("/me")
    public ResponseEntity<UsuarioResponseDTO> getUsuarioActual(Authentication authentication) {
        // getName() devuelve el subject del token, que es el email
        return ResponseEntity.ok(usuarioService.getUsuarioPorEmail(authentication.getName()));
    }

}
