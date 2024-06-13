package com.clases.gateway.controller;

import com.clases.gateway.dto.*;
import com.clases.gateway.service.MensajeService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path="/Mensaje")
@RequiredArgsConstructor
public class MensajeController {

    private final MensajeService MensajeService;

    @PostMapping(path = "/registrarMensaje")
    public ResponseDTO registrarMensaje(@RequestBody RegistrarMensajeDTO dto) {
        return MensajeService.registrarMensaje(dto.getMensajeId(), dto.getRaza(), dto.getAlimentacion(), dto.getDenomOrig(), dto.getOwner(), dto.getValor());}

    @GetMapping(path = "/cargarMensaje")
    public ResponseDTO cargarMensaje(@RequestParam String MensajeId) {
        return MensajeService.cargarMensaje(MensajeId);}

    @DeleteMapping(path = "/borrarMensaje")
    public ResponseDTO borrarMensaje(@RequestParam String MensajeId) {
        return MensajeService.borrarMensaje(MensajeId);}

    @PutMapping(path = "/transferenciaMensaje")
    public ResponseDTO transferAsset(@RequestBody TransferMensajeDTO dto) {
        return MensajeService.transferenciaMensaje(dto.getMensajeId(), dto.getNewOwner(), dto.getNewValue());}

    @GetMapping(path = "/listarMensajees")
    public ResponseDTO listarMensajees() {
        return MensajeService.listarMensajees();}
}
