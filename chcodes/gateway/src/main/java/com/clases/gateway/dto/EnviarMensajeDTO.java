package com.clases.gateway.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class enviarMensajeDTO {

    @ApiModelProperty(value = "Mensaje ID", example = "1")
    String MensajeId;

    @ApiModelProperty(value = "Emisor", example = "Miguel Delibes")
    String emisor;

    @ApiModelProperty(value = "Asunto", example = "Entrega urgente")
    String asunto;

    @ApiModelProperty(value = "Receptor", example = "Albert Einstein")
    String receptor;

    @ApiModelProperty(value = "EnCopia", example = "Santiago Pérez, Blanca Paz")
    String enCopia;

    @ApiModelProperty(value = "Texto", example = "Se convoca una reunión.")
    int texto;
}
