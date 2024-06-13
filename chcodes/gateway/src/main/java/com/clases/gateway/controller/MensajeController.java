package com.clases.gateway.controller;

import com.clases.gateway.dto.*;
import com.clases.gateway.service.MensajeService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping(path="/mensaje")
@RequiredArgsConstructor
public class MensajeController {

    private final MensajeService MensajeService;

    @PostMapping(path = "/enviarMensaje")
    public ResponseDTO enviarMensaje(@RequestBody EnviarMensajeDTO dto) {
        return MensajeService.enviarMensaje(dto.getMensajeId(), dto.getEmisor(), dto.getAsunto(),
                                            dto.getReceptor(), dto.getEnCopia(), dto.getTexto());}

    @GetMapping(path = "/verMensaje")
    public ResponseDTO verMensaje(@RequestParam String MensajeId) {
        return MensajeService.verMensaje(MensajeId);}

    @DeleteMapping(path = "/eliminarMensaje")
    public ResponseDTO eliminarMensaje(@RequestParam String MensajeId) {
        return MensajeService.eliminarMensaje(MensajeId);}

    @GetMapping(path = "/listarMensajes")
    public ResponseDTO listarMensajes() {
        return MensajeService.listarMensajes();}

    @GetMapping(path = "/enviadosPor")
    public ResponseDTO enviadosPor(@RequestParam String emisor) {
        return MensajeService.enviadosPor(emisor);}

    @GetMapping(path = "/enviadosA")
    public ResponseDTO enviadosA(@RequestParam String receptor) {
        return MensajeService.enviadosA(receptor);}

    @GetMapping(path = "/buscarEnAsunto")
    public ResponseDTO buscarEnAsunto(@RequestParam String txt) {
        return MensajeService.buscarEnAsunto(txt); }

    @DeleteMapping(path = "/eliminarTodosMensajes")
    public ResponseDTO eliminarTodosMensaje() {
        return MensajeService.eliminarTodosMensaje();}


}
