### Please describe found weak places below.

#### Security issues

1. There is no authentication and authorization implemented. Any application that deals with monetary transactions needs well thought and extensive authorization mechanism. (I'm not sure if this was beyond the scope of this test as it's just some boilerplate code to implement for gems like devise and pundit).
2. Transactions can be accessed based on DB id: `/transactions/15`. A more secure approach would be to use the UUID to access the transactions: `/transactions/e6948b75-9d3e-4f7f-8f72-f62b88be5a1d`. This way, malicious actors can't guess the ids.
3. The current UUID is too short which will still leave the application vulnerable to enumeration attacks.
4. It's dangerous to hold the `manager_id` in the form, even if it's a hidden field because users could set whichever manager they want. It's better to set the manager when the Transaction is created.
5. Permit specific attributes in the controller instead of permitting all of them.
6. `database.yml` should not be pushed to git. It should be added to `.gitignore` instead.

#### Performance issues

1. Transaction's index has no pagination.
2. Transaction's index has an N+1 queries issue: for every transaction we do a query in the managers table to find the transation's manager.
3. The transaction's index page is not cached. Depending on how frequent we expect the index to change, this can be a good candidate for caching.
4. We need a unique index on the `uid` column in the transactions table.

#### Code issues

1. The views/controller actions for a new transaction contain duplicated code.
2. Alternatively to holding all the logic in one model, we could use Single Table Inheritance for the transactions: SmallTransaction, LargeTransaction, ExtraLargeTransaction, each of them inheriting from Transaction.
3. Tests are completely absent.

#### Others

1. The managers are randomly chosen for extra large transactions. A better approach is to have an Account Manager. The AM will be automatically resposible for any transaction that comes from a specific user.
2. ID can be automatically generated as UUID through postgres. (https://pawelurbanek.com/uuid-order-rails)
3. To hold monetary values we could have used numeric data type instead of using the Money gem.
4. Gems like `rubocop` and `brakeman` can be used to enforce code quality and security. Also gems like annotate_models are a great QoL improvement for developers
