package com.bsm.chaincode;

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
        name = "MensajeOp",
        info = @Info(
                title = "MensajeOp contract",
                description = "Chaincode para la transacción de mensajes",
                version = "0.0.1"))
@Default
public final class MensajeOp implements ContractInterface {

    private final Genson genson = new Genson();

    private enum MensajeOpErrors {
        MENSAJE_NOT_FOUND,
        MENSAJE_ALREADY_EXISTS
    }

    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public Mensaje enviarMensaje(final Context ctx, final String id, final String remitente,
                                 final String asunto, final String receptor, final String enCopia,
                                 final String texto) {

        ChaincodeStub stub = ctx.getStub();

        String state = stub.getStringState(id);

        if (!state.isEmpty()) {
            String errorMessage = String.format("Mensaje con Id %s ya registrado", id);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, MensajeOpErrors.MENSAJE_ALREADY_EXISTS.toString());
        }

        Mensaje msj = new Mensaje(id, remitente, asunto, receptor, enCopia, texto);

        String newState = genson.serialize(msj);

        stub.putStringState(id, newState);

        return msj;
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public Mensaje verMensaje(final Context ctx, final String id) {
        ChaincodeStub stub = ctx.getStub();
        String state = stub.getStringState(id);

        if (state.isEmpty() || state == null) {
            String errorMessage = String.format("El mensaje con Id= %s no existe!", id);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, MensajeOpErrors.MENSAJE_NOT_FOUND.toString());
        }

        Mensaje msj = genson.deserialize(state, Mensaje.class);
        return msj;
    }

    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public void eliminarMensaje(final Context ctx, final String id) {
        ChaincodeStub stub = ctx.getStub();

        String state = stub.getStringState(id);

        if (state.isEmpty() || state == null) {
            String errorMessage = String.format("El mensaje con Id= %s no existe!", id);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, MensajeOpErrors.MENSAJE_NOT_FOUND.toString());
        }
        stub.delState(id);
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public String mostrarMensajes(final Context ctx) {
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
