package com.bsm.hflines_ch1;

import com.owlike.genson.annotation.JsonProperty;
import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

import java.util.Objects;

@DataType
public final class Mensaje {

    @Property()
    private final String id;

    @Property()
    private final String emisor;

    @Property()
    private final String subject;

    @Property()
    private final String texto;

    @Property()
    private final String dest;

    public Mensaje(@JsonProperty("id") final String id,
                   @JsonProperty("emisor") final String emisor,
                   @JsonProperty("subject") final String subject,
                   @JsonProperty("texto") final String texto,
                   @JsonProperty("dest") final String dest){
        this.id=id;
        this.emisor=emisor;
        this.subject=subject;
        this.texto=texto;
        this.dest=dest;
    }

    public String getId() { return id; }
    public String getEmisor() { return emisor; }
    public String getSubject() { return subject; }
    public String getTexto() { return texto; }
    public String getDest() { return dest; }

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
                new String[] {getId(), getEmisor(), getSubject(), getTexto(), getDest()},
                new String[] {other.getId(), other.getEmisor(), other.getSubject(), other.getTexto(), other.getDest()});
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getEmisor(), getSubject(), getTexto(), getDest());
    }

    @Override
    public String toString() {
        return this.getClass().getSimpleName() + "@" + Integer.toHexString(hashCode()) + " [id=" + id + ", emisor="
                + emisor + ", subject=" + subject + ", texto=" + texto + ", destinatarios=" + dest + "]";
    }
}
