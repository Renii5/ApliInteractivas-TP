package com.uade.tpo.e_commerce.service;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.mockito.Mockito.inOrder;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoInteractions;
import static org.mockito.Mockito.when;

import java.util.List;
import java.util.Optional;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.InOrder;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import com.uade.tpo.e_commerce.dto.CarritoResponseDTO;
import com.uade.tpo.e_commerce.exception.CarritoNotFoundException;
import com.uade.tpo.e_commerce.model.Carrito;
import com.uade.tpo.e_commerce.model.Usuario;
import com.uade.tpo.e_commerce.repository.CarritoProductosRepository;
import com.uade.tpo.e_commerce.repository.CarritoRepository;
import com.uade.tpo.e_commerce.repository.OrdenRepository;
import com.uade.tpo.e_commerce.repository.ProductoRepository;
import com.uade.tpo.e_commerce.repository.UsuarioRepository;

@ExtendWith(MockitoExtension.class)
class CarritoServiceCrudTest {

    private static final String EMAIL = "usuario@example.com";

    @Mock
    private CarritoRepository carritoRepository;
    @Mock
    private CarritoProductosRepository carritoProductosRepository;
    @Mock
    private ProductoRepository productoRepository;
    @Mock
    private UsuarioRepository usuarioRepository;
    @Mock
    private OrdenRepository ordenRepository;
    @Mock
    private OrdenService ordenService;

    @InjectMocks
    private CarritoService carritoService;

    @Test
    void getAllReturnsEveryCart() {
        Carrito carrito = new Carrito(7L, new Usuario());
        when(carritoRepository.findAll()).thenReturn(List.of(carrito));
        when(carritoProductosRepository.findByCarritoId(7L)).thenReturn(List.of());

        List<CarritoResponseDTO> response = carritoService.getAll();

        assertEquals(1, response.size());
        assertEquals(7L, response.get(0).getCarritoId());
    }

    @Test
    void getByIDReturnsOnlyTheAuthenticatedUsersCart() {
        Carrito carrito = new Carrito(7L, new Usuario());
        when(carritoRepository.findByIdAndUsuarioEmail(7L, EMAIL)).thenReturn(Optional.of(carrito));
        when(carritoProductosRepository.findByCarritoId(7L)).thenReturn(List.of());

        CarritoResponseDTO response = carritoService.getByID(7L, EMAIL, false);

        assertEquals(7L, response.getCarritoId());
        verify(carritoRepository).findByIdAndUsuarioEmail(7L, EMAIL);
    }

    @Test
    void getByIDDoesNotExposeAnotherUsersCart() {
        when(carritoRepository.findByIdAndUsuarioEmail(7L, EMAIL)).thenReturn(Optional.empty());

        assertThrows(CarritoNotFoundException.class, () -> carritoService.getByID(7L, EMAIL, false));

        verifyNoInteractions(carritoProductosRepository);
    }

    @Test
    void deleteRemovesItemsBeforeDeletingTheCart() {
        Carrito carrito = new Carrito(7L, new Usuario());
        when(carritoRepository.findByIdAndUsuarioEmail(7L, EMAIL)).thenReturn(Optional.of(carrito));

        carritoService.delete(7L, EMAIL, false);

        InOrder deletionOrder = inOrder(carritoProductosRepository, carritoRepository);
        deletionOrder.verify(carritoProductosRepository).deleteByCarritoId(7L);
        deletionOrder.verify(carritoRepository).delete(carrito);
    }

    @Test
    void addReturnsTheAuthenticatedUsersCart() {
        Carrito carrito = new Carrito(9L, new Usuario());
        when(carritoRepository.findByUsuarioEmail(EMAIL)).thenReturn(Optional.of(carrito));
        when(carritoProductosRepository.findByCarritoId(9L)).thenReturn(List.of());

        CarritoResponseDTO response = carritoService.add(EMAIL);

        assertEquals(9L, response.getCarritoId());
    }
}
