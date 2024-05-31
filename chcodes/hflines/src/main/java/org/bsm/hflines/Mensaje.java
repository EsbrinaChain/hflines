package org.bsm.hflines;

import com.google.gson.annotations.SerializedName;
import org.hyperledger.fabric.contract.annotation.DataType;
import org.hyperledger.fabric.contract.annotation.Property;

import java.util.List;

@DataType
public final class Mensaje {

    @Property()
    @SerializedName("id") private final String id;

    @Property()
    @SerializedName("emisor") private final String emisor;

    @Property()
    @SerializedName("destinatarios") private final List<String> destinatarios;

    @Property()
    @SerializedName("subject") private final String subject;

    @Property()
    @SerializedName("texto") private final String texto;

    public Mensaje(final String id,
                   final String emisor,
                   final List<String> destinatarios,
                   final String subject,
                   final String texto){
        this.id=id;
        this.emisor=emisor;
        this.destinatarios=destinatarios;
        this.subject=subject;
        this.texto=texto;

    }

    public String getId() { return id; }
    public String getEmisor() { return emisor; }
    public String getSubject() { return subject; }
    public List<String> getDestinatarios() { return destinatarios; }
    public String getTexto() { return texto; }


}
