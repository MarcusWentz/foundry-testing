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
