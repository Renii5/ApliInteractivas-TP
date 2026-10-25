package com.uade.tpo.e_commerce.config;

import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// Sirve las imágenes subidas por los vendedores (ImagenService) como archivos estáticos:
// get http://localhost:8080/uploads/<archivo> -> devuelve la imagen guardada en app.uploads.dir
@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final String directorioUploads;

    public WebConfig(@Value("${app.uploads.dir}") String directorioUploads) {
        this.directorioUploads = directorioUploads;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String ubicacion = Paths.get(directorioUploads).toAbsolutePath().normalize().toUri().toString();
        // Spring necesita la "/" final para tratar la ubicación como carpeta
        if (!ubicacion.endsWith("/")) {
            ubicacion += "/";
        }
        registry.addResourceHandler("/uploads/**").addResourceLocations(ubicacion);
    }
}
