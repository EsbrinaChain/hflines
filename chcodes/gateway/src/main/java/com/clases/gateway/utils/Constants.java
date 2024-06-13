package com.clases.gateway.utils;

import java.nio.file.Path;
import java.nio.file.Paths;

public final class Constants {

    private Constants(){}

    public static final String MSP_ID_ORG1 = "org1MSP";
    public static final String CHANNEL_NAME = "mychannel";
    public static final String CHAINCODE_MENSAJE_NAME = "chaincode1";

    // Path to crypto materials.
    public static final Path CRYPTO_PATH_ORG1 = Paths.get("/tmp/hyperledger/org1");
    // Path to user certificate.
    public static final Path CERT_PATH_ORG1 = CRYPTO_PATH_ORG1.resolve(Paths.get("/tmp/hyperledger/org1/ca/crypto/ca-cert.pem"));
    // Path to user private key directory.
    public static final Path KEY_DIR_PATH_ORG1 = CRYPTO_PATH_ORG1.resolve(Paths.get("/tmp/hyperledger/org1/ca/crypto/msp/keystore"));
    // Path to peer tls certificate.
    public static final Path TLS_CERT_PATH_ORG1 = CRYPTO_PATH_ORG1.resolve(Paths.get("/tmp/hyperledger/org1/ca/crypto/tls-cert.pem"));

    // Gateway peer end point.
    public static final String PEER_ENDPOINT_ORG1 = "localhost:7051";
    public static final String OVERRIDE_AUTH_ORG1 = "peer1-org1";
}
