package com.bsm.chaincode;

import com.owlike.genson.annotation.JsonProperty;
import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

import java.util.Objects;

@DataType()
public final class Mensaje {

    @Property()
    private final String id;

    @Property()
    private final String remitente;

    @Property()
    private final String asunto;

    @Property()
    private final String receptor;

    @Property()
    private final String enCopia;

    @Property()
    private final String texto;

    public Mensaje(@JsonProperty("id") final String id,
                   @JsonProperty("remitente") final String remitente,
                   @JsonProperty("asunto") final String asunto,
                   @JsonProperty("receptor") final String receptor,
                   @JsonProperty("enCopia") final String enCopia,
                   @JsonProperty("texto") final String texto) {
        this.id = id;
        this.remitente = remitente;
        this.asunto = asunto;
        this.receptor = receptor;
        this.enCopia = enCopia;
        this.texto = texto;
        System.out.println("LLEGA 1");
    }

    public String getId() {
        return id;
    }

    public String getRemitente() {
        return remitente;
    }

    public String getAsunto() {
        return asunto;
    }

    public String getReceptor() {
        return receptor;
    }

    public String getEnCopia() {
        return enCopia;
    }

    public String getTexto() {
        return texto;
    }

    @Override
    public boolean equals(final Object obj) {
        if (this == obj) {
            return true;
        }

        if ((obj == null) || (getClass() != obj.getClass())) {
            return false;
        }

        Mensaje other = (Mensaje) obj;

        return Objects.deepEquals(
                new String[] {getId(), getRemitente(), getAsunto(), getReceptor(), getEnCopia(), getTexto()},
                new String[] {other.getId(), other.getRemitente(), other.getAsunto(), other.getReceptor(), other.getEnCopia(), other.getTexto()});
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getRemitente(), getAsunto(), getEnCopia(), getTexto());
    }

    @Override
    public String toString() {
        return this.getClass().getSimpleName() + "@" + Integer.toHexString(hashCode()) + " [id=" + id + ", Remitente="
                + remitente + ", Asunto=" + asunto + ", Receptor=" + receptor + ", enCopia=" + enCopia + ", texto="
                + texto + "]";
    }
}
