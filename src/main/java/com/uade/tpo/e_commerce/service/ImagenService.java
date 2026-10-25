package com.uade.tpo.e_commerce.service;

import java.io.IOException;
import java.io.InputStream;
import java.io.UncheckedIOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.uade.tpo.e_commerce.exception.ImagenInvalidaException;

/**
 * Guarda en disco las imágenes de productos que suben los vendedores
 * y devuelve la URL pública con la que se sirven (ver WebConfig).
 * ImagenService
 */
@Service
public class ImagenService {

    // Tipos de imagen aceptados -> extensión con la que se guarda el archivo
    private static final Map<String, String> EXTENSIONES = Map.of(
            "image/jpeg", "jpg",
            "image/png", "png",
            "image/webp", "webp");

    private final Path directorio;
    private final String urlPublica;

    public ImagenService(@Value("${app.uploads.dir}") String directorio,
            @Value("${app.public-url}") String urlPublica) throws IOException {
        this.directorio = Paths.get(directorio).toAbsolutePath().normalize();
        // Sin "/" final para no generar URLs con doble barra
        this.urlPublica = urlPublica.replaceAll("/+$", "");
        // La carpeta no se versiona: se crea al arrancar si no existe
        Files.createDirectories(this.directorio);
    }

    public String guardar(MultipartFile archivo) {
        if (archivo == null || archivo.isEmpty()) {
            throw new ImagenInvalidaException("Debe enviar un archivo de imagen");
        }
        String extension = EXTENSIONES.get(archivo.getContentType());
        if (extension == null) {
            throw new ImagenInvalidaException("Formato de imagen no soportado. Use JPG, PNG o WEBP");
        }
        // El Content-Type lo declara el cliente: se verifica también el contenido real del archivo
        if (!coincideContenido(archivo, extension)) {
            throw new ImagenInvalidaException("El archivo no es una imagen válida");
        }

        // Nombre generado: nunca se usa el nombre original (evita choques y rutas como "../")
        String nombre = UUID.randomUUID() + "." + extension;
        try (InputStream entrada = archivo.getInputStream()) {
            Files.copy(entrada, directorio.resolve(nombre));
        } catch (IOException e) {
            throw new UncheckedIOException("No se pudo guardar la imagen", e);
        }
        return urlPublica + "/uploads/" + nombre;
    }

    // Compara los primeros bytes del archivo con la firma de cada formato
    private boolean coincideContenido(MultipartFile archivo, String extension) {
        byte[] cabecera;
        try (InputStream entrada = archivo.getInputStream()) {
            cabecera = entrada.readNBytes(12);
        } catch (IOException e) {
            return false;
        }
        return switch (extension) {
            case "jpg" -> empiezaCon(cabecera, 0, new byte[] { (byte) 0xFF, (byte) 0xD8, (byte) 0xFF });
            case "png" -> empiezaCon(cabecera, 0, new byte[] { (byte) 0x89, 'P', 'N', 'G' });
            case "webp" -> empiezaCon(cabecera, 0, "RIFF".getBytes(StandardCharsets.US_ASCII))
                    && empiezaCon(cabecera, 8, "WEBP".getBytes(StandardCharsets.US_ASCII));
            default -> false;
        };
    }

    private boolean empiezaCon(byte[] datos, int desde, byte[] firma) {
        return datos.length >= desde + firma.length
                && Arrays.equals(datos, desde, desde + firma.length, firma, 0, firma.length);
    }
}
