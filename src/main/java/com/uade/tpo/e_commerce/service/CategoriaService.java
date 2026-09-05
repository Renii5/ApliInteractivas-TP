package com.uade.tpo.e_commerce.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.uade.tpo.e_commerce.exception.CategoriaNotFoundException;
import com.uade.tpo.e_commerce.model.Categoria;
import com.uade.tpo.e_commerce.repository.CategoriaRepository;

import jakarta.transaction.Transactional;

@Service
@Transactional
public class CategoriaService {

	private final CategoriaRepository categoriaRepository;

	public CategoriaService(CategoriaRepository categoriaRepository) {
		this.categoriaRepository = categoriaRepository;
	}

	public List<Categoria> listarCategorias() {
		return categoriaRepository.findAll();
	}

	public Categoria buscarCategoria(Long id) {
		return categoriaRepository.findById(id)
				.orElseThrow(() -> new CategoriaNotFoundException(id));
	}

	public Categoria agregarCategoria(Categoria categoria) {
		return categoriaRepository.save(categoria);
	}

	public Categoria actualizarCategoria(Long id, Categoria categoriaActualizada) {
		Categoria categoria = buscarCategoria(id);
		categoria.setNombre(categoriaActualizada.getNombre());
		return categoriaRepository.save(categoria);
	}

	public void borrarCategoria(Long id) {
		Categoria categoria = buscarCategoria(id);
		categoriaRepository.delete(categoria);
	}
}
