package com.uade.tpo.e_commerce.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.dto.ProductoResponseDTO;
import com.uade.tpo.e_commerce.exception.ProductoNotFoundException;
import com.uade.tpo.e_commerce.exception.UsuarioNotFoundException;
import com.uade.tpo.e_commerce.model.Favorito;
import com.uade.tpo.e_commerce.model.Producto;
import com.uade.tpo.e_commerce.model.Usuario;
import com.uade.tpo.e_commerce.repository.FavoritoRepository;
import com.uade.tpo.e_commerce.repository.ProductoRepository;
import com.uade.tpo.e_commerce.repository.UsuarioRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class FavoritoService {

    private final FavoritoRepository favoritoRepository;
    private final ProductoRepository productoRepository;
    private final UsuarioRepository usuarioRepository;

    public FavoritoService(
            FavoritoRepository favoritoRepository,
            ProductoRepository productoRepository,
            UsuarioRepository usuarioRepository) {
        this.favoritoRepository = favoritoRepository;
        this.productoRepository = productoRepository;
        this.usuarioRepository = usuarioRepository;
    }

    public List<ProductoResponseDTO> getFavoritos(String email) {
        return favoritoRepository.findByUsuarioEmailOrderByProductoNombreAsc(email)
                .stream()
                .map(favorito -> toDTO(favorito.getProducto()))
                .toList();
    }

    public void agregarFavorito(String email, Long productoId) {
        Usuario usuario = usuarioRepository.findByEmail(email)
                .orElseThrow(() -> new UsuarioNotFoundException(email));
        Producto producto = productoRepository.findById(productoId)
                .orElseThrow(() -> new ProductoNotFoundException(productoId));

        if (!favoritoRepository.existsByUsuarioIdAndProductoId(usuario.getId(), productoId)) {
            favoritoRepository.save(new Favorito(usuario, producto));
        }
    }

    public void eliminarFavorito(String email, Long productoId) {
        favoritoRepository.deleteByUsuarioEmailAndProductoId(email, productoId);
    }

    private ProductoResponseDTO toDTO(Producto producto) {
        return new ProductoResponseDTO(
                producto.getId(),
                producto.getNombre(),
                producto.getDescription(),
                producto.getImageUrl(),
                producto.getPrecio(),
                producto.getStock(),
                producto.getStock() > 0,
                producto.getCategoria().getId(),
                producto.getCategoria().getNombre(),
                producto.getVendedor() != null ? producto.getVendedor().getNombreUsuario() : null);
    }
}
