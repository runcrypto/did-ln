# A Simple DID

```did:ln:523226:1367:0```

The DID subject is comprised of:
* "DID" : Subject
* "ln" : Method
* "523226:1367:0" : short channel Id (specific-idstring)

# A Simple DID document

```{
  "@context": "https://w3id.org/did/v1",
  "id": "did:ln:523226:1367:0",
  "publicKey": [{
    //owner public key information
    "id": "did:ln:523226:1367:0#keys-1",
    "type": "Secp256k1VerificationKey2018",
    "owner": "02cd3967dcef276d329156530a333c0292b43eacd8d229d1d9637a699e12d514e9",
    "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
  },{
    //provider public key information
   "id": "did:ln:523226:1367:0#keys-2",
    "type": "Secp256k1VerificationKey2018",
    "owner": "02647bf54e30968a2c56dc227bcc4a26bac8df94e4a6710df9a1bb230bbfda7e59",
    "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
  }],
  "authentication": [{
    // this key can be used to authenticate as DID ...9938
    "type": "Secp256k1VerificationKey2018",
    "publicKey": "did:ln:523226:1367:0#keys-1"
  }],
  "service": [{
    "type": "ExampleService",
    "serviceEndpoint": "https://example.com/endpoint/8377464"
  }]
}```
