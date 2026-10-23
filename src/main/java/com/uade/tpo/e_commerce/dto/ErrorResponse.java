package com.uade.tpo.e_commerce.dto;

import java.time.LocalDateTime;

import org.springframework.http.HttpStatus;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Cuerpo JSON que devuelven TODOS los errores de la API, así el front siempre recibe el mismo formato:
 * { "status": 404, "error": "Not Found", "mensaje": "No se encontró el producto con id: 9", "timestamp": "2026-10-23T19:30:00" }
 * Lo usan GlobalExceptionHandler (errores de negocio) y SecurityConfig (401 y 403).
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class ErrorResponse {
    private int status;
    private String error;
    private String mensaje;
    private String timestamp;

    public ErrorResponse(HttpStatus status, String mensaje) {
        this(status.value(), status.getReasonPhrase(), mensaje, LocalDateTime.now().withNano(0).toString());
    }

    /**
     * Arma el JSON a mano. Lo usa SecurityConfig, porque los 401/403 se responden en el filtro de seguridad,
     * antes de llegar al controller, y ahí no actúa la conversión automática a JSON de Spring MVC.
     */
    public String toJson() {
        return "{\"status\":" + status
                + ",\"error\":\"" + escapar(error)
                + "\",\"mensaje\":\"" + escapar(mensaje)
                + "\",\"timestamp\":\"" + timestamp + "\"}";
    }

    private static String escapar(String texto) {
        return texto == null ? "" : texto.replace("\\", "\\\\").replace("\"", "\\\"");
    }
}
