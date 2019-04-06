# A Simple DID

```did:ln:02cd3967dcef276d329156530a333c0292b43eacd8d229d1d9637a699e12d514e9```

The DID subject is comprised of:
* ```did``` : Subject
* ```ln``` : Method
* ```02cd3967dcef276d329156530a333c0292b43eacd8d229d1d9637a699e12d514e9``` : node public key (specific-idstring)

# A Simple DID document

```
{
  "@context": "https://w3id.org/did/v1",
  "id": "did:ln:02cd3967dcef276d329156530a333c0292b43eacd8d229d1d9637a699e12d514e9",
  "channelId":523226:1367:0
  "publicKey": [{
    //owner public key information
    "id": "did:ln:523226:1367:0#keys-1",
    "type": "Secp256k1VerificationKey2018",
    "owner": "02cd3967dcef276d329156530a333c0292b43eacd8d229d1d9637a699e12d514e9",
    "publicKeyPem": "-----BEGIN PUBLIC KEY...END PUBLIC KEY-----\r\n"
  }]
}
```
