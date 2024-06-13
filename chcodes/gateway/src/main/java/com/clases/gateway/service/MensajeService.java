package com.clases.gateway.service;

import com.clases.gateway.dto.ResponseDTO;
import com.clases.gateway.utils.Constants;
import com.clases.gateway.repository.FabricGateway;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonParser;
import lombok.RequiredArgsConstructor;
import org.hyperledger.fabric.client.Contract;
import org.springframework.stereotype.Service;

import java.nio.charset.StandardCharsets;

@Service
@RequiredArgsConstructor
public class MensajeService {

    public final FabricGateway fabricGateway;

    private final Gson gson = new GsonBuilder().setPrettyPrinting().create();

    public ResponseDTO registrarMensaje(final String MensajeID, final String raza, final String alimentacion,
                                   final String denomOrig, final String owner, final int valor) {

        ResponseDTO response = new ResponseDTO();

        try (var gateway = fabricGateway.createConnection().connect()) {
            var network = gateway.getNetwork(Constants.CHANNEL_NAME);

            // Get the smart contract from the network.
            Contract contract = network.getContract(Constants.CHAINCODE_Mensaje_NAME);
            byte[] result = contract.submitTransaction("registrarMensaje", MensajeID, raza, alimentacion, denomOrig, owner, String.valueOf(valor));

            response.setCode("0");
            response.setData(prettyJson(result));
        } catch (Exception e) {
            response.setCode("1");
            response.setData(e.getMessage());
        }

        return response;
    }

    public ResponseDTO cargarMensaje(final String MensajeID) {

        ResponseDTO response = new ResponseDTO();

        try (var gateway = fabricGateway.createConnection().connect()) {
            var network = gateway.getNetwork(Constants.CHANNEL_NAME);

            // Get the smart contract from the network.
            Contract contract = network.getContract(Constants.CHAINCODE_Mensaje_NAME);
            byte[] result  = contract.submitTransaction("imprimirMensaje", MensajeID);

            response.setCode("0");
            response.setData(prettyJson(result));
        } catch (Exception e) {
            response.setCode("1");
            response.setData(e.getMessage());
        }

        return response;
    }

    public ResponseDTO borrarMensaje(final String MensajeID) {

        ResponseDTO response = new ResponseDTO();

        try (var gateway = fabricGateway.createConnection().connect()) {
            var network = gateway.getNetwork(Constants.CHANNEL_NAME);

            // Get the smart contract from the network.
            Contract contract = network.getContract(Constants.CHAINCODE_Mensaje_NAME);
            contract.submitTransaction("borrarMensaje", MensajeID);

            response.setCode("0");
            response.setData("Mensaje Borrado");
        } catch (Exception e) {
            response.setCode("1");
            response.setData(e.getMessage());
        }

        return response;
    }

    public ResponseDTO transferenciaMensaje(final String MensajeID, final String newOwner, final int newValue) {

        ResponseDTO response = new ResponseDTO();

        try (var gateway = fabricGateway.createConnection().connect()) {
            var network = gateway.getNetwork(Constants.CHANNEL_NAME);

            // Get the smart contract from the network.
            Contract contract = network.getContract(Constants.CHAINCODE_Mensaje_NAME);
            byte[] result = contract.submitTransaction("transferenciaMensaje", MensajeID, newOwner, String.valueOf(newValue));

            response.setCode("0");
            response.setData("New owner " + newOwner );
        } catch (Exception e) {
            response.setCode("1");
            response.setData(e.getMessage());
        }

        return response;
    }

    public ResponseDTO listarMensajees() {

        ResponseDTO response = new ResponseDTO();

        try (var gateway = fabricGateway.createConnection().connect()) {
            var network = gateway.getNetwork(Constants.CHANNEL_NAME);

            // Get the smart contract from the network.
            Contract contract = network.getContract(Constants.CHAINCODE_Mensaje_NAME);
            byte[] result  = contract.submitTransaction("listarMensajees");

            response.setCode("0");
            response.setData(prettyJson(result));
        } catch (Exception e) {
            response.setCode("1");
            response.setData(e.getMessage());
        }

        return response;
    }

    private String prettyJson(final byte[] json) {
        return prettyJson(new String(json, StandardCharsets.UTF_8));
    }

    private String prettyJson(final String json) {
        var parsedJson = JsonParser.parseString(json);
        return gson.toJson(parsedJson);
    }


}
