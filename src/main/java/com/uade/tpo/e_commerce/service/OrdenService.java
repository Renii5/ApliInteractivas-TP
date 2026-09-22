package com.uade.tpo.e_commerce.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.dto.OrdenItemDTO;
import com.uade.tpo.e_commerce.dto.OrdenResponseDTO;
import com.uade.tpo.e_commerce.exception.OrdenNotFoundException;
import com.uade.tpo.e_commerce.model.Orden;
import com.uade.tpo.e_commerce.repository.OrdenRepository;

import jakarta.transaction.Transactional;

/**
 * Capa donde reside la lógica de negocio y donde se manejan las transacciones.
 * Consultas de órdenes: histórico completo de ventas (ADMIN) y "mis compras" (usuario).
 * Las órdenes se crean en CarritoService.checkout.
 * OrdenService
 */
@Service
@Transactional
public class OrdenService {

    private final OrdenRepository ordenRepository;

    public OrdenService(OrdenRepository ordenRepository) {
        this.ordenRepository = ordenRepository;
    }

    // Histórico de todas las ventas (solo ADMIN, ver SecurityConfig)
    public List<OrdenResponseDTO> getAllOrdenes() {
        return ordenRepository.findAllByOrderByFechaDesc()
                .stream()
                .map(this::toDTO)
                .toList();
    }

    // Órdenes del usuario autenticado
    public List<OrdenResponseDTO> getOrdenesDelUsuario(String email) {
        return ordenRepository.findByCompradorEmailOrderByFechaDesc(email)
                .stream()
                .map(this::toDTO)
                .toList();
    }

    // Detalle de una orden propia. Si es de otro usuario se responde 404, igual que si no existiera
    public OrdenResponseDTO getOrdenDelUsuario(Long id, String email) {
        return ordenRepository.findByIdAndCompradorEmail(id, email)
                .map(this::toDTO)
                .orElseThrow(() -> new OrdenNotFoundException(id));
    }

    // Convierte la entidad en el DTO que se expone en la API
    public OrdenResponseDTO toDTO(Orden orden) {
        List<OrdenItemDTO> items = orden.getItems()
                .stream()
                .map(item -> new OrdenItemDTO(
                        item.getProducto().getId(),
                        item.getProducto().getNombre(),
                        item.getPrecioUnitario(),
                        item.getCantidad(),
                        item.getSubtotal()))
                .toList();

        return new OrdenResponseDTO(
                orden.getId(),
                orden.getFecha(),
                orden.getComprador().getEmail(),
                items,
                orden.getTotal());
    }
}
