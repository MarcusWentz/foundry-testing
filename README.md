## Test coverage:

Quick test coverage:

    forge coverage

Detailed test logs:

    forge test --vvv

Detailed branch coverage:

1. Run 

        forge coverage --report lcov && genhtml lcov.info -o report --branch-coverage

2. Check coverage results in

        report/index.html
    
3. Delete the following before pushing to GitHub to keep commits lightweight:

        lcov.info
        reports

Deploy to Goerli network and verify at the same time on Etherscan (with EIP-1559 gas transaction) (credit: https://docs.moonbeam.network/builders/build/eth-api/verify-contracts/etherscan-plugins/):

        forge create --rpc-url $goerliHTTPS_InfuraAPIKey --etherscan-api-key $etherscanApiKey --verify --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage

Deploy to Shardeum Liberty 2.X network (with Legacy gas transaction):

        forge create --legacy --rpc-url https://liberty20.shardeum.org/ --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage


