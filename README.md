# balloon-choice
Leverages Zero Knowledge Proofs (Noir, circuits/), and Chainlink VRF to pick a balloon and reveal certain balloons without collapsing the state of the system.

## VRF Txs
Contract: https://etherscan.io/address/0x8c03228b6c30384bc43f6ca3808079b715861c39  
Request: https://etherscan.io/tx/0xa4607cbfeb55a37d6d35bbde463fef2b3a3bbe13ec992748fc1f40730a3cc893  
Request ID: `44891165086996240108778186758015576609333059751135478846937258917230709909448`  
Fulfillment: https://etherscan.io/tx/0x9490a9681b6d14d93e5ae237ec1174b8dcd88b16a6607e6c03a9a6cfc6d16ba4  
RandomWords: 100119918256241682700911812918324539147658175759365887839089947860093261083057  
Result: 1  

## Noir Proofs
Since the salt and balloon ordering are not yet public, users cannot yet know which balloon was picked by the VRF result being "1".  
They can however, be sure (using circuits/hash-gen/proofs/shuffle0.proof), that it was generated correctly and fairly, a balloon has indeed been picked.  
When the time comes to reveal a balloon we will submit a proof using the prove-balloon circuit.

# blueCheck.proof
The blue balloon is safe!  
Rename circuits/prove-balloon/Verifier_blue.toml to Verifier.toml to verify the bluecheck proof  
Run `nargo verify blueCheck` after this to verify the blue balloon.

# pinkCheck.proof
The pink balloon is safe!  
Rename circuits/prove-balloon/Verifier_pink.toml to Verifier.toml to verify the pinkcheck proof  
Run `nargo verify pinkCheck` after this to verify the pink balloon.
