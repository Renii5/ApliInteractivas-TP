package com.uade.tpo.e_commerce.exception;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.springframework.web.multipart.support.MissingServletRequestPartException;
import org.springframework.web.servlet.resource.NoResourceFoundException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.http.converter.HttpMessageNotReadableException;

import com.uade.tpo.e_commerce.dto.ErrorResponse;

//TODO: ssanchez - es buena práctica crear excepciones personalizadas para cada error específico, y manejarlas en un controlador de excepciones global con @ControllerAdvice, para centralizar el manejo de errores y evitar repetir código en cada controlador. Por ejemplo, se podría crear una excepción ProductoNotFoundException para manejar el caso cuando no se encuentra un producto, y otra excepción PrecioNegativoException para manejar el caso cuando se intenta guardar un producto con precio negativo. Luego, en el controlador de excepciones global, se podrían manejar estas excepciones y devolver una respuesta adecuada al cliente, como un código de estado HTTP 404 (Not Found) para ProductoNotFoundException, o un código de estado HTTP 400 (Bad Request) para PrecioNegativoException.
// Anotación que indica que esta clase manejará excepciones de forma global para todos los controladores.
// Todas las respuestas de error tienen el mismo cuerpo JSON: ErrorResponse (status, error, mensaje, timestamp)
@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    // Arma la respuesta HTTP con el código de estado y el ErrorResponse en el body (Spring lo convierte a JSON)
    private ResponseEntity<ErrorResponse> respuesta(HttpStatus status, String mensaje) {
        return ResponseEntity.status(status).body(new ErrorResponse(status, mensaje));
    }

    @ExceptionHandler(CategoriaNotFoundException.class)
    public ResponseEntity<ErrorResponse> manejarCategoriaNoEncontrada(CategoriaNotFoundException ex) {
        return respuesta(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    @ExceptionHandler(UsuarioNotFoundException.class)
    public ResponseEntity<ErrorResponse> manejarUsuarioNoEncontrado(UsuarioNotFoundException ex) {
        return respuesta(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    @ExceptionHandler(ContrasenaIncorrectaException.class)
    public ResponseEntity<ErrorResponse> manejarContrasenaIncorrecta(ContrasenaIncorrectaException ex) {
        return respuesta(HttpStatus.UNAUTHORIZED, ex.getMessage());
    }

    @ExceptionHandler(UsuarioAlreadyExistsException.class)
    public ResponseEntity<ErrorResponse> manejarUsuarioExistente(UsuarioAlreadyExistsException ex) {
        return respuesta(HttpStatus.CONFLICT, ex.getMessage());
    }

    // Anotación que indica que este método manejará las excepciones de tipo ProductoNotFoundException.
    @ExceptionHandler(ProductoNotFoundException.class)
    // Este método se ejecuta cuando se lanza una ProductoNotFoundException.
    public ResponseEntity<ErrorResponse> ManejarProductoNoEncontrado(ProductoNotFoundException ex) {
        // Devuelve una respuesta con el código de estado HTTP 404 (Not Found) y en el body el json con el mensaje de error
        return respuesta(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    @ExceptionHandler(CarritoNotFoundException.class)
    public ResponseEntity<ErrorResponse> ManejarCarritoNoEncontrado(CarritoNotFoundException ex) {
        return respuesta(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    @ExceptionHandler(PrecioNegativoException.class)
    public ResponseEntity<ErrorResponse> manejarPrecioNegativo(PrecioNegativoException ex) {
        return respuesta(HttpStatus.BAD_REQUEST, ex.getMessage());
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> manejarArgumentoInvalido(IllegalArgumentException ex) {
        return respuesta(HttpStatus.BAD_REQUEST, ex.getMessage());
    }

    // Error no previsto: el detalle se registra en el log del servidor y al cliente
    // se le devuelve un mensaje genérico, para no exponer información interna
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> manejarErroresGenerales(Exception ex) {
        log.error("Error no controlado", ex);
        return respuesta(HttpStatus.INTERNAL_SERVER_ERROR, "Ocurrió un error interno. Intente nuevamente más tarde");
    }

    // La URL no corresponde a ningún endpoint (ej: /api/productoss)
    @ExceptionHandler(NoResourceFoundException.class)
    public ResponseEntity<ErrorResponse> manejarRecursoInexistente(NoResourceFoundException ex) {
        return respuesta(HttpStatus.NOT_FOUND, "No existe el recurso solicitado");
    }

    // Un parámetro de la URL tiene un tipo inválido (ej: /api/productos/abc cuando se espera un número)
    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<ErrorResponse> manejarParametroInvalido(MethodArgumentTypeMismatchException ex) {
        return respuesta(HttpStatus.BAD_REQUEST, "El parámetro '" + ex.getName() + "' tiene un valor inválido");
    }

    @ExceptionHandler(NombreUsuarioEnUsoException.class)
    public ResponseEntity<ErrorResponse> manejarNombreUsuarioEnUso(NombreUsuarioEnUsoException ex) {
        return respuesta(HttpStatus.CONFLICT, ex.getMessage());
    }

    @ExceptionHandler(UsernameNotFoundException.class)
    public ResponseEntity<ErrorResponse> manejarUsernameNoEncontrado(UsernameNotFoundException ex) {
        return respuesta(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    @ExceptionHandler(AuthenticationException.class)
    public ResponseEntity<ErrorResponse> manejarErrorAutenticacion(AuthenticationException ex) {
        return respuesta(HttpStatus.UNAUTHORIZED, "Error de autenticación");
    }

    @ExceptionHandler(AccessDeniedException.class)
    public ResponseEntity<ErrorResponse> manejarAccesoDenegado(AccessDeniedException ex) {
        return respuesta(HttpStatus.FORBIDDEN, "No tiene permisos para realizar esta acción");
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ErrorResponse> manejarBodyInvalido(HttpMessageNotReadableException ex) {
        return respuesta(HttpStatus.BAD_REQUEST, "El cuerpo de la request falta o tiene un formato inválido");
    }

    @ExceptionHandler(ProductoNoPropioException.class)
    public ResponseEntity<ErrorResponse> manejarProductoNoPropio(ProductoNoPropioException ex) {
        return respuesta(HttpStatus.FORBIDDEN, ex.getMessage());
    }

    @ExceptionHandler(CategoriaConProductosException.class)
    public ResponseEntity<ErrorResponse> manejarCategoriaConProductos(CategoriaConProductosException ex) {
        return respuesta(HttpStatus.CONFLICT, ex.getMessage());
    }

    @ExceptionHandler(StockInsuficienteException.class)
    public ResponseEntity<ErrorResponse> manejarStockInsuficiente(StockInsuficienteException ex) {
        return respuesta(HttpStatus.CONFLICT, ex.getMessage());
    }

    @ExceptionHandler(ProductoNoEnCarritoException.class)
    public ResponseEntity<ErrorResponse> manejarProductoNoEnCarrito(ProductoNoEnCarritoException ex) {
        return respuesta(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    @ExceptionHandler(OrdenNotFoundException.class)
    public ResponseEntity<ErrorResponse> manejarOrdenNoEncontrada(OrdenNotFoundException ex) {
        return respuesta(HttpStatus.NOT_FOUND, ex.getMessage());
    }

    @ExceptionHandler(ProductoConVentasException.class)
    public ResponseEntity<ErrorResponse> manejarProductoConVentas(ProductoConVentasException ex) {
        return respuesta(HttpStatus.CONFLICT, ex.getMessage());
    }

    @ExceptionHandler(ImagenInvalidaException.class)
    public ResponseEntity<ErrorResponse> manejarImagenInvalida(ImagenInvalidaException ex) {
        return respuesta(HttpStatus.BAD_REQUEST, ex.getMessage());
    }

    // El archivo supera spring.servlet.multipart.max-file-size
    @ExceptionHandler(MaxUploadSizeExceededException.class)
    public ResponseEntity<ErrorResponse> manejarArchivoMuyGrande(MaxUploadSizeExceededException ex) {
        return respuesta(HttpStatus.CONTENT_TOO_LARGE, "La imagen supera el tamaño máximo permitido (5 MB)");
    }

    // Falta una parte del multipart (ej: POST /api/productos/imagen sin el campo "imagen")
    @ExceptionHandler(MissingServletRequestPartException.class)
    public ResponseEntity<ErrorResponse> manejarParteFaltante(MissingServletRequestPartException ex) {
        return respuesta(HttpStatus.BAD_REQUEST, "Falta el campo '" + ex.getRequestPartName() + "' en la request");
    }
}
