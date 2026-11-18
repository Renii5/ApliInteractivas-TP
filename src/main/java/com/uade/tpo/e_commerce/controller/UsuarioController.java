package com.uade.tpo.e_commerce.controller;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.uade.tpo.e_commerce.dto.LoginRequest;
import com.uade.tpo.e_commerce.dto.RegisterRequest;
import com.uade.tpo.e_commerce.dto.UsuarioResponseDTO;
import com.uade.tpo.e_commerce.security.JwtUtil;
import com.uade.tpo.e_commerce.service.AuthenticationService;
import com.uade.tpo.e_commerce.service.UsuarioService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/usuarios")
@RequiredArgsConstructor
public class UsuarioController {

    private final AuthenticationService authenticationService;
    private final UsuarioService usuarioService;
    private final JwtUtil jwtUtil;

    @PostMapping("/register")
    public ResponseEntity<UsuarioResponseDTO> register(@RequestBody RegisterRequest request) {
        return ResponseEntity.status(HttpStatus.CREATED).body(authenticationService.register(request));
    }

    // post http://localhost:8080/api/usuarios/login -> valida las credenciales y crea la sesión.
    // El JWT no va en el body: viaja en el header Set-Cookie como cookie HttpOnly ("sesion"),
    // que el navegador guarda y reenvía solo en cada request. En el body van los datos del usuario.
    @PostMapping("/login")
    public ResponseEntity<UsuarioResponseDTO> login(@RequestBody LoginRequest request) {
        String token = authenticationService.authenticate(request);
        UsuarioResponseDTO usuario = usuarioService.getUsuarioPorEmail(request.getEmail());
        return ResponseEntity.ok()
                .header(HttpHeaders.SET_COOKIE, jwtUtil.crearCookie(token).toString())
                .body(usuario);
    }

    // post http://localhost:8080/api/usuarios/logout -> cierra la sesión.
    // JavaScript no puede borrar una cookie HttpOnly: la borra el back mandando la misma cookie vacía con maxAge 0
    @PostMapping("/logout")
    public ResponseEntity<Void> logout() {
        return ResponseEntity.noContent()
                .header(HttpHeaders.SET_COOKIE, jwtUtil.borrarCookie().toString())
                .build();
    }

    // get http://localhost:8080/api/usuarios/me -> datos del usuario logueado.
    // El front lo usa al cargar la app para saber si la cookie de sesión sigue siendo válida
    @GetMapping("/me")
    public ResponseEntity<UsuarioResponseDTO> getUsuarioActual(Authentication authentication) {
        // getName() devuelve el subject del token, que es el email
        return ResponseEntity.ok(usuarioService.getUsuarioPorEmail(authentication.getName()));
    }

}
