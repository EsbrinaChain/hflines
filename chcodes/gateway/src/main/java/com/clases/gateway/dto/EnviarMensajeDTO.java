package com.clases.gateway.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class EnviarMensajeDTO {

    @ApiModelProperty(value = "Mensaje ID", example = "1")
    String MensajeId;

    @ApiModelProperty(value = "Emisor", example = "Miguel Delibes")
    String Emisor;

    @ApiModelProperty(value = "Asunto", example = "Entrega urgente")
    String Asunto;

    @ApiModelProperty(value = "Receptor", example = "Albert Einstein")
    String receptor;

    @ApiModelProperty(value = "EnCopia", example = "Santiago Pérez, Blanca Paz")
    String EnCopia;

    @ApiModelProperty(value = "Texto", example = "Se convoca una reunión.")
    String Texto;
}
