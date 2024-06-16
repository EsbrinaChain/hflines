package com.clases.gateway.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class EnviarMensajeDTO {

    @ApiModelProperty(value = "Mensaje ID", example = "id numerico")
    String MensajeId;

    @ApiModelProperty(value = "Emisor", example = "nombre del emisor del mensaje")
    String Emisor;

    @ApiModelProperty(value = "Asunto", example = "asunto del mensaje")
    String Asunto;

    @ApiModelProperty(value = "Receptor", example = "nombre del receptor del mensaje")
    String receptor;

    @ApiModelProperty(value = "EnCopia", example = "nombres de los terceros receptores del mensaje")
    String EnCopia;

    @ApiModelProperty(value = "Texto", example = "texto del mensaje")
    String Texto;
}
