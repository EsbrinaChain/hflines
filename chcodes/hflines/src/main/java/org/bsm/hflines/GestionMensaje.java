package org.bsm.hflines;

import com.owlike.genson.Genson;
import org.hyperledger.fabric.contract.Context;
import org.hyperledger.fabric.contract.ContractInterface;
import org.hyperledger.fabric.contract.annotation.Contract;
import org.hyperledger.fabric.contract.annotation.Default;
import org.hyperledger.fabric.contract.annotation.Info;
import org.hyperledger.fabric.contract.annotation.Transaction;
import org.hyperledger.fabric.shim.ChaincodeException;
import org.hyperledger.fabric.shim.ChaincodeStub;
import org.hyperledger.fabric.shim.ledger.KeyValue;
import org.hyperledger.fabric.shim.ledger.QueryResultsIterator;

import java.util.ArrayList;
import java.util.List;

@Contract(
        name = "GestionMensaje",
        info = @Info(
                title = "GestionMensaje contract",
                description = "Chaincode para el envio de mensajes.",
                version = "0.0.1"))
@Default
public final class GestionMensaje implements ContractInterface{

    private final Genson genson = new Genson();

    private enum MensajeErrors {
        MENSAJE_NOT_FOUND,
        MENSAJE_ALREADY_EXISTS
    }

    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public Mensaje registrarMensaje(final Context ctx, final String id,
                                    final String emisor, final String subject,
                                    final String texto, final String destinatarios) {

        ChaincodeStub stub = ctx.getStub();

        String state = stub.getStringState(id);

        if (!state.isEmpty()) {
            String errorMessage = String.format("Mensaje %s ya registrado", id);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, MensajeErrors.MENSAJE_ALREADY_EXISTS.toString());
        }

        Mensaje Mensaje = new Mensaje(id, emisor, subject, texto, destinatarios);

        String newState = genson.serialize(Mensaje);

        stub.putStringState(id, newState);

        return Mensaje;
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public Mensaje imprimirMensaje(final Context ctx, final String id) {
        ChaincodeStub stub = ctx.getStub();
        String state = stub.getStringState(id);

        if (state.isEmpty() || state == null) {
            String errorMessage = String.format("Mensaje %s no registrado", id);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, MensajeErrors.MENSAJE_NOT_FOUND.toString());
        }

        Mensaje Mensaje = genson.deserialize(state, Mensaje.class);
        return Mensaje;
    }

    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public void borrarMensaje(final Context ctx, final String id) {
        ChaincodeStub stub = ctx.getStub();

        String state = stub.getStringState(id);

        if (state.isEmpty() || state == null) {
            String errorMessage = String.format("Mensaje %s no registrado", id);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, MensajeErrors.MENSAJE_NOT_FOUND.toString());
        }

        stub.delState(id);
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public String listarMensajes(final Context ctx) {
        ChaincodeStub stub = ctx.getStub();

        List<Mensaje> queryResults = new ArrayList<Mensaje>();
        QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");

        for (KeyValue result: results) {
            Mensaje asset = genson.deserialize(result.getStringValue(), Mensaje.class);
            System.out.println(asset);
            queryResults.add(asset);
        }

        final String response = genson.serialize(queryResults);

        return response;
    }

}
