> The ability to link the issuer to the holder via a lightning channel is
> actually achieved via the HTLC contact on the Bitcoin blockchain and so
> trying to use lightning clients to identify and manage the link just
> adds complexity when the balance of the funding transaction can be
> queried using any blockchain explorer.
>
> This project is now closed but has provided a valuable insite into the
> additional features that smart contracts (multisig / timelock) can add
> to verifiable credentials that warrent further research.

Overview
========

A decentralised identifier (DID) is an identifier that isn’t issued by a
centralised body. A DID is owned by an entity which can verify control
of it using cryptography.

At the time of writing, there are solutions using
blockchains/distributed ledgers that are being used to implement
systems, providing self-sovereign identities.

Both private ([Sovrin](https://sovrin.org/)) and public
([BTCR](https://w3c-ccg.github.io/didm-btcr/)) blockchain solutions are
in development and consolidate around the idea of Digital Identity
Documents (DID) in which there has considerable progress in creating a
standard (see https://w3c-ccg.github.io/did-spec/).

Use cases
=========

-   Businesses selling restricted items such as alcohol or ciggarettes,
    may limit acceptable credentials to government issued ones

-   Potential employers may limit educational credentials to recognised
    schools or universities.

-   Door security systems may limit credentials to employees of
    companies renting space in shared office buildings.

-   Homeowners may limit credentials to a tradesman, assigned to perform
    a particular job by a serviceing company.

Specification
=============

There are 3 main components to Decentralised IDentifiers:

-   DID

-   DID Document

-   DID Method

They are used together to define an implementation.

DID
---

The DID is a unique reference that is used to root trust in the contents
of the DID Document. Control of a DID needs to be verified using public.

A DID is a unique identifier which must be persistent and immutable.

The DID method needs to ensure that two entities cannot claim ownership
of the same DID.

There is a comparison in the specification of UUID’s which are
decentralised as a result of their uniqueness, in the same way that
Bitcoin addresses are also generated to avoid collisions.

An entity can use a DID to present a DID Document to another entity and
verify that they are the owner of that DID. This mechanism is similar
somewhat to providing a service with your email address and then
clicking a verify link in an email that is subsequently sent to that
address.

DID Document
------------

A DID Document contains metadata about a DID. The DID Document is what
is exchanged during a interaction between two entities.

The DID Document contains a public key to verify ownership of the DID,
using a DID Method.

The DID Document consists of the following parts:

  -- -------------- -----------------------------------------
     the DID        
     id             Identifier for the authentication entry
     type           type of the authentication entry
     controller     the DID providing authentication
     publicKeyPem   the public key of the DID
  -- -------------- -----------------------------------------

method
======

Creating a DID requires that a DID can be linked to a public key. The
common implementation of this requires that a reference to the DID
exists with a reference to the private key.

Bitcoin generates addresses that can be linked back to public keys and
so having a UID generated in the same way that a bitcoin address is
generated would satisfy the need to derive the UID from a public key.

Introduction
============

The DID-LN implementation aims to provide a method for storing the state
of a DID using a lightning network channel id as the unique reference in
the DID. When the DID is to be revoked, the channel is closed.

Problem Domain
==============

In this section, we explore the problems that need to be addressed in
order to develop an identity system. We look at other systems and how
they have tackled the problem and also provide some options around
possible solutions for this implementation.

Trust
-----

The bitcoin mantra is very apt here “Don’t trust: verify”. The goal of
any decentralised identity system should be to minimise the amount of
trust required and instead make any claims verifiable.

### Trust Triad

DID’s provide methods for verifying 3 key pieces of data in credentials:

-   The Owner is who they say they are

-   The Provider has supplied the credential

-   The credential is valid and has not been revoked

Each piece of data can be evaluated independently and adds to the
information that the Requestor needs to make an informed decision about
trust. It is possible for one or more of the endpoints needed for
automatic verification to be unavailable and alternate methods for
completing the trust triad to be used.

### Trust Models

The trust model is very similar to legacy certificate authority systems
where an agent will have a number of trusted root certificates. These
are based on chains of trust which are typically pre-loaded on devices
and not modified. An agent should be empowered to choose which providers
are trusted. When thinking about the nature of trust and the current
implementation models, the following points come to mind:

-   Trust in the state of a system can be managed by software

-   At some point the trust at an edge of the system has to resolve to a
    Trust Oracle of some kind.

-   Secure internet sites, are trusted through a certificate issuing
    authority which is a form of Trust Oracle.

-   The Sovrin network is an instance of Hyperledger Indy that acts as a
    Trust Oracle, where the user puts their trust in a decentralized
    consortium of Stewards.

-   Trust oracles should be complementary to users making decisions on
    trust and not authoritative.

-   Users should be empowered to make decisions on trust themselves.

State Management
----------------

One of the problems that creating a decentralised trust model faces is
managing the state of the DID Document: is it valid or invalid at any
point in time. Consider the following points on state:

-   For persistent or time limited DID Document (National Insurance
    Numbers/SSL certificates), the state can be rooted in the credential
    itself.

-   Where a credential needs to be revocable, the state needs to be
    rooted outside of the credential.

-   Hyperledger Indy addresses the revocation problem using
    Cryptographic Accumulators.

-   The state of blockchains are saved in the UTXO set and not the chain
    itself which only provides a verifiable record of how the UTXO set
    came to its current state.

Analysis
========

The state management requires a link between two UTXO owners. This link
is to be transient and given the scope of identity credential management
will result in a high volume of links being created and destroyed.

Blockchain selection
--------------------

Using the Bitcoin blockchain for this use case is not viable as it is
not suited to handling the transaction volume needed. To address the
tansaction volume requirement, a separate blockchain is required.

The elements project is an open source blockchain implementation that
can be deployed as either a standalone blockchain or sidechain with 2
way peg and so will be the codebase to be deployed.

### Dedicated Blockchain

If choosing to launch a new blockchain, the problem of issuing and
trading tokens would present problems with price manipulation. Along
with this, there may be backlash in the market with the launch of ’yet
another blockchain’ that needs justification during marketing cycles and
with wider technical communities.

### Sidechain

By having a sidechain, many of the issues with starting a dedicated
blockchain are avoided. The sidechain builds on the reputation of the
bitcoin network and tokens are tied to the price and liquidity of the
BTC token. It is a lot easier to justify the existance of a sidechain
and validity of the project that has no revenue generation scheme built
in (i.e. creator premine).

Storing State
-------------

Transactional volume is one problem, the other is in the way that state
is recorded. Current implementations use data in transactions to record
state in the blockchain which, as discussed previously, does not fit
with the idea of state being stored in the blockchain as immuntable and
is a square peg in a round hole scenario. State needs to be stored in
the UTXO set and so the following methods have been assessed.

### Multisig Wallet

A link between two identities could be created with a multisig 1 of 2
wallet. Using BIP174 (Partially Signed Bitcoin Transaction) it should be
possible to verify ownership of one of the keys without making an
onchain transaction (also see
https://blockstream.com/2019/02/04/standardizing-bitcoin-proof-of-reserves/).

### Lightning Channels

An implementation of the multisig wallet solution is already in
existence, with additional features added on, in the lightning network.
It makes sense to use he existing functionality with lightning to build
he solution on. There are channel identifiers that can be used to
reference the link and a communication network that may be utilised to
perform the state queries.

Summary
-------

### Limitations

For every channel, an on-chain transaction is required:

-   Transaction costs

-   a number of confirmations are required before the channel is
    established.

Managing channels:

-   Channel factories can be used to open batches of channels.

-   Closing a channel can be forced to close after 30 seconds.

### Trade-offs

A couple of things can be done to limit the impact of the limitations:
alternate public blockchains to Bitcoin could be used with faster block
times and lower fees. Transaction costs and confirmations could be
avoided altogetherby running a federated sidechain.

### In the wild

In a broader sense, whenever friction is added to a transaction
(requesting proof of age/salary) then there should be a cost to adding
that friction. This will incentivise requests for proof to be used only
when they are nessecary and for owners to adopt the system in the first
place. Having the base layer on the lightning network would help
facilitate micropayments being built into agents.

Design
======

What the Lightning Network method aims to provide is a solution to the
state problem by using the lightning network to store the DID Document
state.

-   Identity is rooted in ownership of UTXO’s

-   The owners of UTXO’s can be verified using standard signing
    techniques.

-   The lightning network extends the UTXO set and makes it possible to
    establish peer to peer links (channels) between UTXO’s.

-   Channels in the lightning network are used to show the state of a
    relationship between two UTXO’s

When proving the credential, the owner is able to verify the ownership
of the UTXO (public address) with their private key. The lightning
network provides information on the existence of a channel with the
provided Id and that the owners UTXO forms one end of the channel. The
other end of the channel (the providers public address) will be
verifyable via a Trust Oracle of the providers choosing (URL endpoint on
a company endpoint).\
The DID Document can be revoked at any point by closing the channel
between the provider and owner. This can be performed by either the
provider OR the owner.

document creation
-----------------

Entity, Issuer and Signer can all be the same entity, different entities
or any mixture of.

1.  entity gets a DID using the DID Method

2.  entity requests a blank DID Document from the issuer

3.  the issuer creates a DID Document using a Document Descriptor Object

4.  the entity reviews / completes the DID document and adds a digital signature

5.  the issuer reviews the DID document and adds a digital signature

[entity]{}[getDID(pubkey)]{}[method]{}[DID]{}

[entity]{}[createDoc()]{}[issuer]{}[doc]{}

[entity]{}[updateDoc(DID,auth,...)]{}[entity]{}

[entity]{}[sign(doc)]{}[signer]{}[doc]{}

[signer]{}[validate(doc)]{}[method]{}[bool true/false]{}

[signer]{}[updateDoc(signature)]{}[signer]{}
