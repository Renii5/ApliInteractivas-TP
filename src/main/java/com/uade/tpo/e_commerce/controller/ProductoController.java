package com.uade.tpo.e_commerce.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PatchMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.uade.tpo.e_commerce.dto.FiltrosProductoDTO;
import com.uade.tpo.e_commerce.dto.PaginaProductosDTO;
import com.uade.tpo.e_commerce.dto.ProductoRequestDTO;
import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
import com.uade.tpo.e_commerce.dto.StockRequestDTO;
import com.uade.tpo.e_commerce.service.ImagenService;
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
    private final ImagenService imagenService;

    public ProductoController(ProductoService productoService, ImagenService imagenService) {
        this.productoService = productoService;
        this.imagenService = imagenService;
    }

    // get http://localhost:8080/api/productos -> primera página (9), orden nombre A-Z
    // Todos los parámetros son opcionales y combinables. categoriaId y vendedorId aceptan
    // varios valores (?categoriaId=1&categoriaId=2 o ?categoriaId=1,2): coincide con cualquiera.
    // get .../api/productos?categoriaId=1&vendedorId=3&precioMin=100&precioMax=500
    //     &soloConStock=true&busqueda=rtx&orden=precio_asc&pagina=2&tamanio=9
    // orden: precio_asc | precio_desc | nombre_asc (default). pagina es base 1.
    @GetMapping
    public ResponseEntity<PaginaProductosDTO> getAllProductos(
            @RequestParam(required = false) List<Long> categoriaId,
            @RequestParam(required = false) List<Long> vendedorId,
            @RequestParam(required = false) Double precioMin,
            @RequestParam(required = false) Double precioMax,
            @RequestParam(required = false) Boolean soloConStock,
            @RequestParam(required = false) String busqueda,
            @RequestParam(required = false) String orden,
            @RequestParam(required = false) Integer pagina,
            @RequestParam(required = false) Integer tamanio,
            Authentication authentication) {
        String emailExcluido = emailLogueado(authentication);
        return ResponseEntity.ok(productoService.getAllProductos(categoriaId, vendedorId,
                precioMin, precioMax, soloConStock, busqueda, orden, pagina, tamanio, emailExcluido));
    }

    // get http://localhost:8080/api/productos/filtros -> opciones para la barra lateral de filtros
    // (declarado antes que /{id}; Spring igual prioriza la ruta literal)
    @GetMapping("/filtros")
    public ResponseEntity<FiltrosProductoDTO> getOpcionesFiltros(Authentication authentication) {
        return ResponseEntity.ok(productoService.getOpcionesFiltros(emailLogueado(authentication)));
    }

    // Los endpoints de catálogo son públicos: sin token (o anónimo) devuelve null.
    // Con token, el email del usuario cuyos productos no deben mostrarse (no puede comprarlos).
    private String emailLogueado(Authentication authentication) {
        return (authentication != null && authentication.isAuthenticated()
                && !(authentication instanceof AnonymousAuthenticationToken))
                        ? authentication.getName()
                        : null;
    }

    // get http://localhost:8080/api/productos/mios -> productos publicados por el usuario logueado
    // Authentication lo inyecta Spring Security: es lo que JwtFilter cargó en el SecurityContext
    @GetMapping("/mios")
    public ResponseEntity<List<ProductoResponseDTO>> getMisProductos(Authentication authentication) {
        return ResponseEntity.ok(productoService.getProductosDelVendedor(authentication.getName()));
    }

    // get http://localhost:8080/api/productos/1 -> detalle del producto 1
    @GetMapping("/{id}")
    public ResponseEntity<ProductoResponseDTO> getProductoById(@PathVariable Long id) {
        return ResponseEntity.ok(productoService.getProductoById(id));
    }

    // post http://localhost:8080/api/productos -> publica un producto; el vendedor es el usuario del token
    @PostMapping
    public ResponseEntity<ProductoResponseDTO> createProducto(
            @RequestBody ProductoRequestDTO productoRequest,
            Authentication authentication) {
        ProductoResponseDTO productoCreado = productoService.createProducto(productoRequest, authentication.getName());
        return new ResponseEntity<>(productoCreado, HttpStatus.CREATED);
    }

    // post http://localhost:8080/api/productos/imagen (multipart, campo "imagen") -> guarda la imagen
    // y devuelve { "image_url": "..." }, para enviarla después en el alta o modificación del producto
    @PostMapping(value = "/imagen", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public ResponseEntity<Map<String, String>> subirImagen(@RequestParam("imagen") MultipartFile imagen) {
        return new ResponseEntity<>(Map.of("image_url", imagenService.guardar(imagen)), HttpStatus.CREATED);
    }

    // put http://localhost:8080/api/productos/1 -> modifica el producto 1 (solo su vendedor o un ADMIN)
    @PutMapping("/{id}")
    public ResponseEntity<ProductoResponseDTO> updateProducto(
            @PathVariable Long id,
            @RequestBody ProductoRequestDTO productoRequest,
            Authentication authentication) {
        return ResponseEntity.ok(productoService.updateProducto(id, productoRequest, authentication.getName()));
    }

    // patch http://localhost:8080/api/productos/1/stock -> actualiza solo el stock (solo su vendedor o un ADMIN)
    @PatchMapping("/{id}/stock")
    public ResponseEntity<ProductoResponseDTO> actualizarStock(
            @PathVariable Long id,
            @RequestBody StockRequestDTO request,
            Authentication authentication) {
        return ResponseEntity.ok(productoService.actualizarStock(id, request.getStock(), authentication.getName()));
    }

    // delete http://localhost:8080/api/productos/1 -> elimina el producto 1 (solo su vendedor o un ADMIN)
    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminarProducto(@PathVariable Long id, Authentication authentication) {
        productoService.eliminarProducto(id, authentication.getName());
        return ResponseEntity.noContent().build();
    }
}
