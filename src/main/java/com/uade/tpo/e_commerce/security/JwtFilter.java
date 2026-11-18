package com.uade.tpo.e_commerce.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.web.filter.OncePerRequestFilter;
import org.springframework.web.util.WebUtils;

import jakarta.servlet.FilterChain;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Set;
import java.util.stream.Collectors;

@Component
//este filtro se ejecuta antes de llamar al controller
//fue configurado en SecurityConfig en la instrucción `addFilterBefore`
public class JwtFilter extends OncePerRequestFilter {
    @Autowired
    private JwtUtil jwtUtil;

    /**
     * Este método se ejecuta en cada petición HTTP para verificar si existe un token JWT válido.
     * Dónde se utiliza:
     * - Se configura en `SecurityConfig` para que se ejecute antes que el filtro de autenticación de Spring Security.
     * - Intercepta todas las peticiones entrantes a la API.
     */
    
    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain) throws ServletException, IOException {
        // 1. Obtiene el JWT de la request: del header Authorization (Postman) o de la cookie "sesion" (front)
        String token = obtenerToken(request);

        // 2. Si vino un token, se valida
        if (token != null) {
            // 4. Valida el token usando `jwtUtil.validateToken()`.
            if (jwtUtil.validateToken(token)) {
                // 5. Si el token es válido, extrae el nombre de usuario y los roles del token.
                String username = jwtUtil.getUsername(token);
                Set<String> roles = jwtUtil.getRoles(token);

                // transformar el conjunto de roles (cadenas de texto)  en la lista de autoridades (permisos) que Spring Security necesita para verificar si el usuario tiene acceso a un recurso.
                var authorities = roles.stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList());
                // usuario ya autenticado 
                // crea un objeto de autenticación con los detalles del usuario y sus roles
                var auth = new UsernamePasswordAuthenticationToken(username, null, authorities);
                // 8. Finalmente, pasa la petición al siguiente filtro en la cadena.
                SecurityContextHolder.getContext().setAuthentication(auth);
            }
        }
        
        filterChain.doFilter(request, response);
    }

    /**
     * Busca el JWT en la request:
     * 1. En el header "Authorization: Bearer <token>", si alguien lo manda a propósito (Postman, otro cliente).
     *    Tiene prioridad porque es explícito: Postman guarda la cookie del último login y la manda siempre,
     *    y así se puede probar un request con el token de otro usuario.
     * 2. Si no hay header, en la cookie HttpOnly "sesion", que el navegador envía sola en cada request.
     *    Es lo que usa el front: nunca manda el header.
     * Devuelve null si no vino token por ninguno de los dos lados.
     */
    private String obtenerToken(HttpServletRequest request) {
        // ej header: Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOi... -> se saca el prefijo "Bearer "
        String header = request.getHeader("Authorization");
        if (header != null && header.startsWith("Bearer ")) {
            return header.substring(7);
        }
        Cookie cookie = WebUtils.getCookie(request, JwtUtil.NOMBRE_COOKIE);
        if (cookie != null && !cookie.getValue().isBlank()) {
            return cookie.getValue();
        }
        return null;
    }
}