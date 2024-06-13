package com.clases.gateway.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class TransferMensajeDTO {


    @ApiModelProperty(value = "Mensaje ID", example = "1")
    String MensajeId;

    @ApiModelProperty(value = "Nuevo owner", example = "Paco")
    String newOwner;

    @ApiModelProperty(value = "Nuevo valor", example = "80")
    int newValue;

}
