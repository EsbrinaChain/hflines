package org.bsm.hflines;

import com.owlike.genson.annotation.JsonProperty;
import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

import java.util.List;
import java.util.Objects;

@DataType
public final class Mensaje {

    @Property()
    private final String id;

    @Property()
    private final String emisor;

    @Property()
    private final List<String> destinatarios;

    @Property()
    private final String subject;

    @Property()
    private final String texto;

    public Mensaje(@JsonProperty("id") final String id,
                   @JsonProperty("emisor") final String emisor,
                   @JsonProperty("subject") final String subject,
                   @JsonProperty("texto") final String texto,
                   @JsonProperty("destinarios") final List<String> destinatarios){
        this.id=id;
        this.emisor=emisor;
        this.subject=subject;
        this.texto=texto;
        this.destinatarios=destinatarios;
    }

    public String getId() { return id; }
    public String getEmisor() { return emisor; }
    public String getSubject() { return subject; }
    public List<String> getDestinatarios() { return destinatarios; }
    public String getTexto() { return texto; }

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
                new String[] {getId(), getEmisor(), getSubject(), getTexto(), getDestinatarios().toString()},
                new String[] {other.getId(), other.getEmisor(), other.getSubject(), other.getTexto(), other.getDestinatarios().toString()});
    }

    @Override
    public int hashCode() {
        return Objects.hash(getId(), getEmisor(), getSubject(),  getTexto(), getDestinatarios().toString());
    }

    @Override
    public String toString() {
        return this.getClass().getSimpleName() + "@" + Integer.toHexString(hashCode()) + " [id=" + id + ", emisor="
                + emisor + ", subject=" + subject + ", texto=" + texto + ", destinatarios=" + destinatarios + "]";
    }
}
