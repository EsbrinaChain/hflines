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
        name = "MensajeTransfer",
        info = @Info(
                title = "MensajeTransfer contract",
                description = "Chaincode para la transacción de Mensajes.",
                version = "0.0.1"))
@Default
public final class MensajeTransfer implements ContractInterface {

    private final Genson genson = new Genson();

    private enum MensajeTransferErrors {
        MENSAJE_NOT_FOUND,
        MENSAJE_ALREADY_EXISTS
    }

    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public Mensaje enviarMensaje(final Context ctx, final String id, final String emisor,
                                 final String asunto, final String receptor, final String texto,
                                 final String enCopia) {

        ChaincodeStub stub = ctx.getStub();

        String state = stub.getStringState(id);

        if (!state.isEmpty()) {
            String errorMessage = String.format("Mensaje %s ya registrado", id);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, MensajeTransferErrors.MENSAJE_ALREADY_EXISTS.toString());
        }

        Mensaje mensaje = new Mensaje(id, emisor, asunto, receptor, texto, enCopia);

        String newState = genson.serialize(mensaje);

        stub.putStringState(id, newState);
        return mensaje;
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public Mensaje verMensaje(final Context ctx, final String id) {
        ChaincodeStub stub = ctx.getStub();
        String state = stub.getStringState(id);

        if (state.isEmpty() || state == null) {
            String errorMessage = String.format("Mensaje %s no existe", id);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, MensajeTransferErrors.MENSAJE_NOT_FOUND.toString());
        }

        Mensaje mensaje = genson.deserialize(state, Mensaje.class);
        return mensaje;
    }

    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public void eliminarMensaje(final Context ctx, final String id) {
        ChaincodeStub stub = ctx.getStub();

        String state = stub.getStringState(id);

        if (state.isEmpty() || state == null) {
            String errorMessage = String.format("Mensaje %s no existe", id);
            System.out.println(errorMessage);
            throw new ChaincodeException(errorMessage, MensajeTransferErrors.MENSAJE_NOT_FOUND.toString());
        }

        stub.delState(id);
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public String listarMensajes(final Context ctx) {
        ChaincodeStub stub = ctx.getStub();

        List<Mensaje> queryResults = new ArrayList<>();
        QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");

        for (KeyValue result: results) {
            Mensaje asset = genson.deserialize(result.getStringValue(), Mensaje.class);
            System.out.println(asset);
            queryResults.add(asset);
        }

        final String response = genson.serialize(queryResults);

        return response;
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public String enviadosPor(final Context ctx, String emisor){
        ChaincodeStub stub = ctx.getStub();

        List<Mensaje> queryResults = new ArrayList<>();
        QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");

        for (KeyValue result: results) {
            Mensaje asset = genson.deserialize(result.getStringValue(), Mensaje.class);
            String emitidoPor=asset.getEmisor();
            if (emisor.equals(emitidoPor)) {
                System.out.println(asset);
                queryResults.add(asset);
            }
        }
        final String response = genson.serialize(queryResults);
        return response;
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public String enviadosA(final Context ctx, String receptor){
        ChaincodeStub stub = ctx.getStub();

        List<Mensaje> queryResults = new ArrayList<>();
        QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");

        for (KeyValue result: results) {
            Mensaje asset = genson.deserialize(result.getStringValue(), Mensaje.class);
            String enviadoA = asset.getReceptor();
            if (receptor.equals(enviadoA)) {
                System.out.println(asset);
                queryResults.add(asset);
            }
        }
        final String response = genson.serialize(queryResults);
        return response;
    }

    @Transaction(intent = Transaction.TYPE.EVALUATE)
    public String buscarEnAsunto(final Context ctx, String txt){
        ChaincodeStub stub = ctx.getStub();

        List<Mensaje> queryResults = new ArrayList<>();
        QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");

        for (KeyValue result: results) {
            Mensaje asset = genson.deserialize(result.getStringValue(), Mensaje.class);
            String textoMensaje = asset.getTexto();
            if (textoMensaje.toLowerCase().contains(txt.toLowerCase())) {
                System.out.println(asset);
                queryResults.add(asset);
            }
        }
        final String response = genson.serialize(queryResults);
        return response;
    }

    @Transaction(intent = Transaction.TYPE.SUBMIT)
    public String eliminarTodosMensajes(final Context ctx) {

        ChaincodeStub stub = ctx.getStub();
        
        List<String> eliminados = new ArrayList<>();
        QueryResultsIterator<KeyValue> results = stub.getStateByRange("", "");

        for (KeyValue result: results) {
            Mensaje asset = genson.deserialize(result.getStringValue(), Mensaje.class);
            String MensajeId = asset.getId();
            stub.delState(MensajeId);
            eliminados.add(MensajeId);
        }
        final String response = genson.serialize(eliminados);
        return response;
    }
}
