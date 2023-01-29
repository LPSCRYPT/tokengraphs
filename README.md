# 👨‍🎤 Edgy Tokens

**Edgy Tokens** is a memetically charged moniker for a smart contract primitive for creating on-chain graph structures using ERC-721 tokens as nodes.

## Problematic

Blockchain tokens are a useful primitive for representing relationships of value. These value relations are generated through combinations of different networks, such as those of communities, markets, smart contracts, and so on. The natively interoperable medium of smart contracts allows tokens to derive additional value from networks external to their own operation - for example, an ERC-20 token might derive its market value largely from liquidity on Uniswap, which in turn derives its value from the ubiquity of the ERC-20 standard. Smart contract modularity allows for robust infrastructures of networked value to grow organically by inheriting from and building atop each other. However, there still exists friction at the layer of interoperability and modularity which frequently results in complex smart contract ecosystems becoming 'kludgy', with networks of dependencies of which minute iterations become either nontrivial or simply impossible without the creation of a new codebase. 

## Solution

To help solve this problem at a fundamental level of smart contract system design, I created a node-edge graph structure primitive. ERC-721 tokens represent promising nodes for on-chain graph structures as they have:
- uniqueness
- value
- existing adoption
- diverse usecases

The token edge EIP takes the form of an abstract contract allowing for the creation of edges between tokens which can compose into arbitrarily complex graph structures. Such structures are so primitive as to have a wide variety of use cases, such as:
- attestation / reputation frameworks
- derivation and royalty trees
- composite token structures (expanding ERC-998 capabilities)
- access control
- adjacency (ie. horizontal relationships, such as portals between metaverse worlds)
- metaverse applications / defining onchain spaciality

More concrete examples will be explicated further on as well as a demonstration of various token graph structures working together to illustrate a how such a primitive can be useful not only in the creation of new smart contract systems, but also for the interoperation of different systems which inherit it.

## Implementation

The abstract Edge contract allows for the creation of edges between any two ERC-721 contracts. the iEdge interface defines an NFT struct as

`struct NFT {`
`address tokenContract`
`uint256 tokenId`
`}`

and edges as a unidirectional relation between two tokens, as in the following pseudocode:

`NFT_A → NFT_B → LinkId → Exists?(bool)`

where the `LinkId` is a `uint256` representing a unique link, of which multiple unique links may exist between any two tokens.

The functions `link` and `unlink` allow for the creation and deletion of edges. 

The virtual functions `_beforeLink`, `_afterLink`, `_beforeUnlink`, and `_afterUnlink` allow for any amount of sanity checking and post-processing to occur within the inheriting contract. 

## Utility

It is evident that token edges can help to streamline a lot of otherwise bespoke logical operations between multiple interacting contracts. Edges create a streamlined way for contracts to read each other's data as relationships defined by the iEdge interface. As these smart contract systems grow in complexity, much of their logic can thus be reduced down to graph traversals.

The true magic happens in the `_before...` and `_after...` virtual functions. Here, developers can define any type of opinionation of an edge relationship. A simple use of this is requiring certain preconditions to be met before edge creation, or the creation of unique edge metadata after linking. More interesting usecases could be the creation of composite token structures, where the edge between two tokens can represent a parent-child relationship, with the parent owning the child using `ERC721Receiver`. This ERC-998 type structure is *just one type* of composable token structure. Token graphs allow for arbitrarily complex composite token structures, as will be illustrated in the example.

![Example of a metaverse application using multiple different kinds of edges to define its logic](https://i.imgur.com/B0gZofE.png)


## Arbitrary Node Types

Node types don't have to just be of a token type. A node can be any well-defined type of composite solidity variables. An edge contract can keep a record of edges between any two arbitrary node types A and B by storing their `A -> B -> Link` association as encoded bytes of their values: ie. `Bytes(A) -> Bytes(B)-> Link`. A node schema can be referenced for easy interpreting and decoding of node types, regardless of their structure.

## First Implementation

Our first usecase of edgy tokens as it relates to crypto art and SuperRare is providing onchain commentary. We can leverage an onchain edge database to create associations between 'commentaries' and particular tokens, as well as defining logic for gatekeeping how commentaries can be produced (ie. only by collectors, artists, et.c.). We feel that this is a strong fit for SuperRare's development goals as the product has multiple open ended usecases that themselves can serve to further the creative expression and associativity of content in the cryptoart space.
