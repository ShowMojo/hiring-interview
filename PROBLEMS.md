### Please describe found weak places below.

#### Security issues

1. Issue with possible mass assignment vulnerability in `TransactionController`. Fixed with strong parameters. Even better would be to implement FormObject: https://github.com/Selleo/pattern#form
2. Update to newer version of Rails, it's always good to have the newest stable version.
3. Add Brakeman and Bundler Audit to check for security issues.

#### Performance issues

1. N+1 query in `TransactionController`. Fixed with `includes`.
2. We should add pagination to index method in `TransactionController`. It's not a good idea to load all transactions at once.
3. Modified pulling random manager to use `order` and `limit` instead of `sample`. It's more efficient for larger db of managers.
#### Code issues

1. We should starting with adding some tests to the project. 
2. Error handling in `TransactionController`. There is no information about errors for example in `create` action. We could add some error messages to the response.
3. A bit of copy-paste code. Unnecessary `new` actions for each type of transaction. DRYed up `new` action so it handles all types of transactions.
4. In `Transaction` model we have some magic numbers like `1000` and `100`. It's better to move them to constants.
5. Another thing in `Transaction` model is that we can't be sure if `#generate_uid` will generate unique uid. It's better to use `SecureRandom#uuid` for that, which makes sure that `uid` will be uniq also consider to close in transaction.
6. It would be better to use `enum` or `const` for `Transaction` type, because it's used in many places and potential refactoring in feature would be easier. Even better we could extract it to separate class.
#### Others

1. You can make a transaction with lower amount than it should be. For example, you can choose transaction type 1000USD+ and make it a 100USD transaction. It's misinformative. 
2. There is unnecessary `bigint` type for manager_id. Normal int would be enough.
3. We should change type for `from_amount_cents` and `to_amount_cents` to bigint for bigger amounts to avoid overflow.
4. We could use i18n for error messages and add some more information to them. For example, we could add information when the transaction failed and why.
5. We could add Rubocop to check for code style issues.
