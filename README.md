## Test coverage:

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

        report/index.html

3. Delete the following before pushing to GitHub to keep commits lightweight:

        lcov.info
        reports
        
Fork a network and get coverage results:
```shell
forge coverage --fork-url $mainnetHTTPS_InfuraAPIKey --report lcov && genhtml lcov.info -o report --branch-coverage
```
Deploy to Goerli network and verify at the same time on Etherscan (with EIP-1559 gas transaction) (credit: https://docs.moonbeam.network/builders/build/eth-api/verify-contracts/etherscan-plugins/):
```shell
forge create --rpc-url $goerliHTTPS_InfuraAPIKey --etherscan-api-key $etherscanApiKey --verify --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage
```
Deploy to Shardeum Liberty 2.X network (with Legacy gas transaction):
```shell
forge create --legacy --rpc-url https://liberty20.shardeum.org/ --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage
```
Deploy to Taiko L2 network and verify at the same time on Blockscout (with EIP-1559 gas transaction) (credit: https://docs.moonbeam.network/builders/build/eth-api/verify-contracts/etherscan-plugins/):
```shell
forge create --rpc-url https://rpc.test.taiko.xyz --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage --verify --verifier blockscout --verifier-url https://explorer.test.taiko.xyz/api\? 
```
Deploy to Taiko L3 network and verify at the same time on Blockscout (with EIP-1559 gas transaction) (credit: https://docs.moonbeam.network/builders/build/eth-api/verify-contracts/etherscan-plugins/):
```shell
forge create --rpc-url https://rpc.l3test.taiko.xyz --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage --verify --verifier blockscout --verifier-url https://blockscoutapi.l3test.taiko.xyz/api\?
```