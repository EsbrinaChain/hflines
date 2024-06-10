package com.bsm.chaincode;

import com.owlike.genson.annotation.JsonProperty;
import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

import java.util.List;
import java.util.Objects;

@DataType()
public final class Mensaje {

    @Property()
    private final String id;
    @Property()
    private final String emisor;
    @Property()
    private final String asunto;
    @Property()
    private final String receptor;
    @Property()
    private final String texto;
    @Property()
    private final String enCopia;

    public Mensaje(@JsonProperty("id") final String id,
                   @JsonProperty("emisor") final String emisor,
                   @JsonProperty("asunto") final String asunto,
                   @JsonProperty("receptor") final String receptor,
                   @JsonProperty("texto") final String texto,
                   @JsonProperty("enCopia") final String enCopia) {
        this.id = id;
        this.emisor = emisor;
        this.asunto = asunto;
        this.receptor = receptor;
        this.texto = texto;
        this.enCopia = enCopia;
    }

    public String getId() {
        return id;
    }

    public String getEmisor() {
        return emisor;
    }

    public String getAsunto() {
        return asunto;
    }

    public String getReceptor() {
        return receptor;
    }

    public String getTexto() {
        return texto;
    }

    public String getEnCopia() {
        return enCopia;
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
                new String[] {getId(), getEmisor(), getAsunto(), getReceptor(), getTexto(), getEnCopia()},
                new String[] {other.getId(), other.getEmisor(), other.getAsunto(), other.getReceptor(), other.getTexto(), other.getEnCopia()});
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getEmisor(), getAsunto(), getReceptor(), getTexto(), getEnCopia());
    }

    @Override
    public String toString() {
        return this.getClass().getSimpleName() + "@" + Integer.toHexString(hashCode()) + " [id=" + id + ", emisor="
                + emisor + ", asunto=" + asunto + ", receptor=" + receptor + ", texto=" + texto + ", enCopia=" + enCopia + "]";
    }
}
