## Foundry Testing

### Test coverage

Quick test coverage:
```shell
forge coverage
```
Detailed test logs:
```shell
forge test --vvv
```
Detailed branch coverage:

1. Run 
```shell
forge coverage --report lcov && genhtml lcov.info -o report --branch-coverage
```
2. Check coverage results in
```
report/index.html
```
3. Delete the following before pushing to GitHub to keep commits lightweight:
```
lcov.info
reports
```     
Fork a network and get coverage results:
```shell
forge coverage --fork-url $mainnetHTTPS_InfuraAPIKey --report lcov && genhtml lcov.info -o report --branch-coverage
```
Forge gas tests:
```shell
forge test --gas-report
```
Forge contract sizes:
```shell
forge build --sizes
```
### Deploy and Verify 

(reference: https://docs.moonbeam.network/builders/build/eth-api/verify-contracts/etherscan-plugins/):

#### Base Sepolia with EIP-1559 Gas (Default)

```shell
forge create src/Contract.sol:SimpleStorage \
--private-key $devTestnetPrivateKey \
--rpc-url $baseSepoliaHTTPS \
--etherscan-api-key $basescanApiKey \
--broadcast \
--verify 
```

#### Base Sepolia with Legacy Gas

```shell
forge create src/Contract.sol:SimpleStorage \
--private-key $devTestnetPrivateKey \
--rpc-url $baseSepoliaHTTPS \
--etherscan-api-key $basescanApiKey \
--verify \
--broadcast \
--legacy
```

#### Etherscan Verify Contract Already Deployed 

Useful for UniswapV2Pair (ERC-20 LP token deployed from UniswapV2Factory):

UniswapV2Factory.sol with library imports:

https://github.com/Uniswap/v2-core/blob/master/contracts/UniswapV2Pair.sol

Single file deployment to copy and paste quickly:

https://etherscan.io/token/0xa2107fa5b38d9bbd2c461d6edf11b11a50f6b974#code

```shell
forge verify-contract \
--rpc-url $baseSepoliaHTTPS \
<contract_address> \
src/UniswapV2Pair.sol:UniswapV2Pair \
--etherscan-api-key $basescanApiKey  
```

#### Blockscout Deploy and Verify

```shell
forge create src/Contract.sol:SimpleStorage \
--private-key $devTestnetPrivateKey \
--rpc-url https://sepolia.unichain.org \
--broadcast \
--verify \
--verifier blockscout \
--verifier-url https://unichain-sepolia.blockscout.com/api/
```

### Blockscout Verify Contract Already Deployed
```shell
forge verify-contract \
--rpc-url https://sepolia.unichain.org \
<contract_address> \
src/Contract.sol:SimpleStorage \
--verifier blockscout \
--verifier-url https://unichain-sepolia.blockscout.com/api/
```

### Fluent Testnet  

#### Deploy and Verify 

```shell
forge create src/Contract.sol:SimpleStorage \
--private-key $devTestnetPrivateKey \
--rpc-url https://rpc.testnet.fluent.xyz/ \
--broadcast \
--verify \
--verifier blockscout \
--verifier-url https://testnet.fluentscan.xyz/api/
```

#### Verify Contract Already Deployed

```shell
forge verify-contract \
--rpc-url https://rpc.testnet.fluent.xyz/ \
<contract_address> \
src/Contract.sol:SimpleStorage \
--verifier blockscout \
--verifier-url https://testnet.fluentscan.xyz/api/
```

### Testnet Bridges Sepolia to L2 EVM Rollups

#### Base Sepolia 

https://superbridge.app/base-sepolia

#### Optimism Sepolia

https://superbridge.app/op-sepolia

