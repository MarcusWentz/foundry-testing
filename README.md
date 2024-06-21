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

### Deploy and Verify 

(reference: https://docs.moonbeam.network/builders/build/eth-api/verify-contracts/etherscan-plugins/):

#### Base Sepolia with EIP-1559 Gas (Default)

```shell
forge create src/Contract.sol:SimpleStorage \
--private-key $devTestnetPrivateKey \
--rpc-url $baseSepoliaHTTPS \
--etherscan-api-key $basescanApiKey \
--verify 
```

#### Base Sepolia with Legacy Gas

```shell
forge create src/Contract.sol:SimpleStorage \
--private-key $devTestnetPrivateKey \
--rpc-url $baseSepoliaHTTPS \
--etherscan-api-key $basescanApiKey \
--verify \
--legacy
```

#### Blockscout Updated 

```shell
forge create --rpc-url https://rpc.jolnir.taiko.xyz --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage --verify --verifier blockscout --verifier-url https://blockscoutapi.jolnir.taiko.xyz/api\?
```

#### Blockscout Outdated

```shell
forge create --rpc-url https://rpc.test.taiko.xyz --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage --verify --verifier blockscout --verifier-url https://explorer.test.taiko.xyz/api\? 
```

