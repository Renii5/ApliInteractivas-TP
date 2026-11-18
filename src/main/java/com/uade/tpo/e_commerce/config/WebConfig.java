package com.uade.tpo.e_commerce.config;

import java.nio.file.Paths;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

// Sirve las imágenes de productos (las del catálogo y las que suben los vendedores) como archivos estáticos:
// get http://localhost:8080/images/<archivo> -> devuelve la imagen guardada en app.images.dir
@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final String directorioImagenes;

    public WebConfig(@Value("${app.images.dir}") String directorioImagenes) {
        this.directorioImagenes = directorioImagenes;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        String ubicacion = Paths.get(directorioImagenes).toAbsolutePath().normalize().toUri().toString();
        // Spring necesita la "/" final para tratar la ubicación como carpeta
        if (!ubicacion.endsWith("/")) {
            ubicacion += "/";
        }
        registry.addResourceHandler("/images/**").addResourceLocations(ubicacion);
    }
}
