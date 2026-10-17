package com.uade.tpo.e_commerce.repository;

import java.util.List;

import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;

import com.uade.tpo.e_commerce.model.Favorito;

public interface FavoritoRepository extends JpaRepository<Favorito, Long> {

    @EntityGraph(attributePaths = {"producto", "producto.categoria", "producto.vendedor"})
    List<Favorito> findByUsuarioEmailOrderByProductoNombreAsc(String email);

    boolean existsByUsuarioIdAndProductoId(Long usuarioId, Long productoId);

    void deleteByUsuarioEmailAndProductoId(String email, Long productoId);

    void deleteByProductoId(Long productoId);
}
