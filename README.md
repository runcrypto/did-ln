# did:⚡:
Lightning Network DID Method

## Background
At the time of writing, there are solutions using blockchains/distributed ledgers that are being used to implement systems providing self-sovereign identities.  Both private (Sovrin) and public (BTCR) blockchain solutions have been created and consolodate around the idea of Digital Identity Documents (DID) in which there has considerable progress in creating a standard (see https://w3c-ccg.github.io/did-spec/).

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
- Hyperledger Indy addresses the revocation problem using Cryptographic Accumulators.
- The state of blockchains are saved in the UTXO set and not the chain itself which only provides a verifiable record of how the UTXO set came to its current state.

## The State Problem
In order to address the state problem, we need to create a link between two UTXO owners.  This link is to be tranient and given the scope of identity credential management will result in a high volume of links being created and destroyed.

### Blockchain selection
Using the Bitcoin blockchain for this use case is not viable as it is not suited to handling the transaction volume needed.  To address the tansaction volume requirement, a separate blockchain is required.

The elements project is an open source blockchain implementation that can be deployed as either a standalone blockchain or sidechain with 2 way peg and so will be the codebase to be deployed.

#### Dedicated Blockchain
If choosing to launch a new blockchain, the problem of issuing and trading tokens would present problems with price manipulation.  Along with this, there may be backlash in the market with the launch of 'yet another blockchain' that needs justification during marketing cycles and with wider technical communities.

#### Sidechain
By having a sidechain, many of the issues with starting a dedicated blockchain are avoided.  The sidechain builds on the reputation of the bitcoin network and tokens are tied to the price and liquidity of the BTC token. It is a lot easier to justify the existance of a sidechain and validity of the project that has no revenue generation scheme built in (i.e. creator premine).

### Storing state
Transactional volume is one problem, the other is in the way that state is recorded.  Current implementations use data in transactions to record state in the blockchain which, as discussed previously, does not fit with the idea of state being stored in the blockchain as immuntable and is a square peg in a round hole scenario.  State needs to be stored in the UTXO set and so the following methods have been assessed.

#### Multisig Wallet
A link between two identities could be created with a multisig 1 of 2 wallet.  Using BIP174 (Partially Signed Bitcoin Transaction) it should be possible to verify ownership of one of the keys without making an onchain transaction (also see https://blockstream.com/2019/02/04/standardizing-bitcoin-proof-of-reserves/).

#### Lightning Channels
An implementation of the multisig wallet solution is already in existence, with additional features added on, in the lightning network.  It makes sense to use he existing functionality with lightning to build he solution on.  There are channel identifiers that can be used to reference the link and a communication network that may be utilised to perform the state queries.

## Proposal
What the Lightning Network method aims to provide is a solution to the state problem by using the lightning network to store the credential state.
- Identity is rooted in ownership of UTXO's
- The owners of UTXO's can be verified using standard signing techniques.
- The lightning network extends the UTXO set and makes it possible to establish peer to peer links (channels) between UTXO's.
- Channels in the lightning network are used to show the state of a relationship between two UTXO's

When proving the credential, the owner is able to verify the ownership of the UTXO (public address) with their private key.  The lightning network provides information on the existence of a channel with the provided Id and that the owners UTXO forms one end of the channel.  The other end of the channel (the providers public address) will be verifyable via a Trust Oracle of the providers choosing (URL endpoint on a company endpoint).

The credential can be revoked at any point by closing the channel between the provider and owner.  This can be performed by either the provider OR the owner.

### Trust Triad
DID's provide methods for verifying 3 key pieces of data in credentials:
- The Owner is who they say they are
- The Provider has supplied the credential
- The credential is valid and has not been revoked
Each piece of data can be evaluated independently and adds to the information that the Requestor needs to make an informed decision about trust.
It is possible for one or more of the endpoints needed for automatic verification to be unavailable and alternate methods for completing the trust triad to be used.

The trust model is very similar to legacy certificate authority systems where an agent will have a number of trusted root certificates.  These are based on chains of trust which are typically pre-loaded on devices and not modified.
An agent should be empowered to choose which providers are trusted.

### Use cases
- Businesses selling restricted items such as alcohol or ciggarettes, may limit acceptable credentials to government issued ones
- Potential employers may limit educational credentials to recognised schools or universities.
- Door security systems may limit credentials to employees of companies renting space in shared office buildings.
- Homeowners may limit credentials to a tradesman, assigned to perform a particular job by a serviceing company.

## Limitations
For every channel, an on-chain transaction is required:
- Transaction costs
- a number of confirmations are required before the channel is established.

### Managing channels
- Channel factories can be used to open batches of channels.
- Closing a channel can be forced to close after 30 seconds.

### Trade-offs
A couple of things can be done to limit the impact of the limitations: alternate public blockchains to Bitcoin could be used with faster block times and lower fees.  Transaction costs and confirmations could be avoided altogetherby running a federated sidechain.

## In the wild
In a broader sense, whenever friction is added to a transaction (requesting proof of age/salary) then there should be a cost to adding that friction.  This will incentivise requests for proof to be used only when they are nessecary and for owners to adopt the system in the first place.  Having the base layer on the lightning network would help facilitate micropayments being built into agents.
