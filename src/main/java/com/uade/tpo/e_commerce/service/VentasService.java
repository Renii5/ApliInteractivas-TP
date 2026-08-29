package com.uade.tpo.e_commerce.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.model.Ventas;
import com.uade.tpo.e_commerce.repository.VentasRepository;

import jakarta.transaction.Transactional;

/**
 * Capa donde reside la lógica de negocio y donde se manejan las transacciones.
 * VentasService
 */
@Service
@Transactional
public class VentasService {

    private final VentasRepository ventasRepository;

    VentasService(VentasRepository ventasRepository) {
        this.ventasRepository = ventasRepository;
    }

    public List<Ventas> getAllVentas() {
        return ventasRepository.findAll();
    }

}
