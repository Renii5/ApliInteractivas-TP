package com.uade.tpo.e_commerce.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.dto.CategoriaRequestDTO;
import com.uade.tpo.e_commerce.dto.CategoriaResponseDTO;
import com.uade.tpo.e_commerce.exception.CategoriaConProductosException;
import com.uade.tpo.e_commerce.exception.CategoriaNotFoundException;
import com.uade.tpo.e_commerce.model.Categoria;
import com.uade.tpo.e_commerce.repository.CategoriaRepository;
import com.uade.tpo.e_commerce.repository.ProductoRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CategoriaService {

	private final CategoriaRepository categoriaRepository;
	private final ProductoRepository productoRepository;

	public CategoriaService(CategoriaRepository categoriaRepository,
							ProductoRepository productoRepository) {
		this.categoriaRepository = categoriaRepository;
		this.productoRepository = productoRepository;
	}

	public List<CategoriaResponseDTO> listarCategorias() {
		return categoriaRepository.findAll().stream().map(this::toDTO).toList();
	}

	public CategoriaResponseDTO buscarCategoria(Long id) {
		return toDTO(obtenerCategoria(id));
	}

	public CategoriaResponseDTO agregarCategoria(CategoriaRequestDTO request) {
		Categoria categoria = new Categoria();
		categoria.setNombre(request.getNombre());
		return toDTO(categoriaRepository.save(categoria));
	}

	public CategoriaResponseDTO actualizarCategoria(Long id, CategoriaRequestDTO request) {
		Categoria categoria = obtenerCategoria(id);
		categoria.setNombre(request.getNombre());
		return toDTO(categoriaRepository.save(categoria));
	}

	public void borrarCategoria(Long id) {
		Categoria categoria = obtenerCategoria(id);
		// Si tiene productos, borrarla violaría la FK de productos.categoria_id: se responde 409
		if (productoRepository.existsByCategoriaId(id)) {
			throw new CategoriaConProductosException(id);
		}
		categoriaRepository.delete(categoria);
	}

	// Busca la entidad o lanza 404; uso interno del service
	private Categoria obtenerCategoria(Long id) {
		return categoriaRepository.findById(id)
				.orElseThrow(() -> new CategoriaNotFoundException(id));
	}

	// Convierte la entidad en el DTO que se expone en la API
	private CategoriaResponseDTO toDTO(Categoria categoria) {
		return new CategoriaResponseDTO(categoria.getId(), categoria.getNombre());
	}
}
