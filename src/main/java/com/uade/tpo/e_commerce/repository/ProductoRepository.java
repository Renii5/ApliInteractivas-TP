package com.uade.tpo.e_commerce.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import com.uade.tpo.e_commerce.model.Producto;

/**
 * JPA Repository para la entidad Producto, proporciona métodos CRUD
 * y consultas personalizadas a la DB, de la tabla Productos.
 * Minimiza el código boilerplate porque no hay que implementar el CRUD básico.
 * ProductoRepository
 */
public interface ProductoRepository extends JpaRepository<Producto, Long>, JpaSpecificationExecutor<Producto> {
    // save, findAll, findById, deleteById, etc. ya vienen implementados por JpaRepository

    // Query Methods: Spring Data arma la consulta SQL a partir del nombre del método

    // SELECT * FROM productos ORDER BY nombre ASC
    List<Producto> findAllByOrderByNombreAsc();

    // SELECT * FROM productos WHERE categoria_id = ? ORDER BY nombre ASC
    List<Producto> findByCategoriaIdOrderByNombreAsc(Long categoriaId);

    // SELECT * FROM productos WHERE LOWER(nombre) LIKE LOWER('%texto%') ORDER BY nombre ASC
    List<Producto> findByNombreContainingIgnoreCaseOrderByNombreAsc(String nombre);

    // Productos publicados por un vendedor, navegando la relación vendedor.email
    List<Producto> findByVendedorEmailOrderByNombreAsc(String email);

    // true si la categoría tiene al menos un producto (se usa antes de borrarla)
    boolean existsByCategoriaId(Long categoriaId);

    // Opciones de filtro: [id, nombre, cantidad de productos]
    @Query("select p.categoria.id, p.categoria.nombre, count(p) from Producto p "
            + "group by p.categoria.id, p.categoria.nombre order by p.categoria.nombre")
    List<Object[]> contarPorCategoria();

    @Query("select p.vendedor.id, p.vendedor.nombreUsuario, count(p) from Producto p "
            + "where p.vendedor is not null "
            + "group by p.vendedor.id, p.vendedor.nombreUsuario order by p.vendedor.nombreUsuario")
    List<Object[]> contarPorVendedor();

    @Query("select min(p.precio) from Producto p")
    Double precioMinimo();

    @Query("select max(p.precio) from Producto p")
    Double precioMaximo();

    long countByStockGreaterThan(Integer stock);
}
