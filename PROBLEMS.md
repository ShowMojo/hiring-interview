### Please describe found weak places below.

#### Security issues

1. TransactionsController action `create`: `.permit!` allows user to pass any arguments

#### Performance issues

1. TransactionsController action `create`: load all managers in our memory
2. TransactionsController action `create`: managers can be unevenly loaded

#### Code issues

1. TransactionsController action `create`: unnecessary creation of a manager

#### Others

1. Transaction model: no check uniqueness for transaction uid
2. Transaction model: some methods in model can be moved to `private` section
3. No tests
