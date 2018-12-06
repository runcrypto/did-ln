# did:⚡:
Lightning Network DID Method

## Background
At the time of writing, there are solutions using blockchains/distributed ledgers that are being used to implement systems providing self-sovereign identities.  Both private (Sovrin) and public (BTCR) blockchain solutions have been created and consolodate around the idea of Digital Identity Documents (DID) in which there has considerable progress in creating a standard (see [https://w3c-ccg.github.io/did-spec/|wc3 DID-spec]).

When thinking about the nature of trust and the current implementation models, the following points come to mind:  
- Trust in the state of a system can be managed by software
- At some point the trust at an edge of the system has to resolve to a Trust Oracle of some kind.
- Secure internet sites, are trusted through a certificate issuing authority which is a form of Trust Oracle.
- The Sovrin network is an instance of Hyperledger Indy that acts as a Trust Oracle, where the user puts their trust in a decentralized consortium of Stewards.
- Trust oracles should be complementary to users making decisions on trust and not authoritative.
- Users should be empowered to make decisions on trust themselves.

One of the problems that creating a decentralised trust model faces is managing the state of the credential, is it valid or invalid at any point in time.  Consider the following points on state:
- For persistent or time limited credentials (National Insurance Numbers/SSL certificates), the state can be rooted in the credential itself.
- Where a credential needs to be revocable, the state needs to be rooted outside of the credential.
- Hyperledger Indy addresses the revocation problem using Cryptographic Accumulators which is complex and not easy to follow.
- The state of blockchains are saved in the UTXO set and not the chain itself which only provides a verifiable record of how the UTXO set came to its current state.

## Proposal
What the Lightning Network method aims to provide is a solution to the state problem by using the lightning network to store the credential state.
- Identity is rooted in ownership of UTXO's
- The owners of UTXO's can be verified using standard signing techniques.
- The lightning network extends the UTXO set and makes it possible to establish peer to peer links (channels) between UTXO's.
- Channels in the lightning network are used to show the state of a relationship between two UTXO's

When proving the credential, the owner is able to verify the ownership of the UTXO (public address) with their private key.  The lightning network provides information on the existence of a channel with the provided Id and that the owners UTXO forms one end of the channel.  The other end of the channel (the providers public address) will be verifyable via a Trust Oracle of the providers choosing (URL endpoint on a company endpoint).

The credential can be revoked at any point by closing the channel between the provider and owner.  This can be performed by either the provider OR the owner.

## In the wild
In a broader sense, whenever friction is added to a transaction (requesting proof of age/salary) then there should be a cost to adding that friction.  This will incentivise requests for proof to be used only when they are nessecary and for owners to adopt the system in the first place.  Having the base layer on the lightning network would help facilitate micropayments being built into agents.
