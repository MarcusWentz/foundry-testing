## Test coverage:

Quick test coverage:

    forge coverage

Detailed branch coverage:

1. Run 

        forge coverage --report lcov && genhtml lcov.info -o report --branch-coverage

2. Check coverage results in

        report/index.html
    
3. Delete the following before pushing to GitHub to keep commits lightweight:

        lcov.info
        reports

Deploy to Goerli network (with EIP-1559 gas transaction):

        forge create --rpc-url $goerliHTTPS_InfuraAPIKey --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage

Deploy to Goerli network (with Legacy gas transaction):

        forge create --legacy --rpc-url https://liberty20.shardeum.org/ --private-key $devTestnetPrivateKey src/Contract.sol:SimpleStorage