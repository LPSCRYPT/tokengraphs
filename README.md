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

EdgyTokens uses a monolithic data storage architecture inherited by modular logical opinionations in a similar manner to that of Lens Protocol.

`EdgeHub` is the data storage monoloth which stores all edge data, as well as simple metadata in for form of a `bytes` array.

`EdgeBase` enforces that any `Edge` implementation will reference a valid `EdgeHub` store.

`Edge` allows for the creation of simple edges. The virtual functions `_beforeLink`, `_afterLink`, `_beforeUnlink`, and `_afterUnlink` allow for any amount of sanity checking and post-processing to occur within the inheriting contract. This is where additional logic modules may be inserted, opinionating the nature of edges in any number of ways which could amongst many other possibilities, service the use cases illustrated above.

An NFT is represented as the following struct:

`struct NFT {`
`address tokenContract`
`uint256 tokenId`
`}`

and edges as a unidirectional relation between two tokens, as in the following pseudocode:

`NFT_A → NFT_B → LinkId → Exists?(bool)`

where the `LinkId` is a `uint256` representing a unique link, of which multiple unique links may exist between any two tokens.

`EdgeHub` stores the address of the calling contract in the edge path, as: 

`EdgeContractAddress → NFT_A → NFT_B → LinkId → Exists?(bool)`

This allows the EdgeHub to store a massive variety of different edge types from differently opinionated Edge contracts. 

## Utility

It is evident that token edges can help to streamline a lot of otherwise bespoke logical operations between multiple interacting contracts. Edges create a streamlined way for contracts to read each other's data as relationships defined by the iEdge interface. As these smart contract systems grow in complexity, much of their logic can thus be reduced down to graph traversals.

The true magic happens in the `_before...` and `_after...` virtual functions. Here, developers can define any type of opinionation of an edge relationship. A simple use of this is requiring certain preconditions to be met before edge creation, or the creation of unique edge metadata after linking. More interesting usecases could be the creation of composite token structures, where the edge between two tokens can represent a parent-child relationship, with the parent owning the child using `ERC721Receiver`. This ERC-998 type structure is *just one type* of composable token structure. Token graphs allow for arbitrarily complex composite token structures, as will be illustrated in the example.

---

Use Cases: Enrich Lens Protocol by creating additional relationality between users and content.

Strictly superior composable token implementation compared to ERC-998, strictly more extensible than EIP-4786.
