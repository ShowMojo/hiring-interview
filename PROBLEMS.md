### Please describe found weak places below.

#### Security issues

- used permit! on params which allows users to potentially store malicious data
- adding validation for params[:type] to avoid rendering unwanted views/errors
- potentially adding a authentication and authorization system to allow/prevent
  people from accessing different parts of the app

#### Performance issues

- no pagination for transactions
- use partials to render transactions instead of `foreach`
- avoid using all.sample when database grows this avoid scanning the whole table

#### Code issues

Important:
- redundant actions methods in TransactionsController rendering new transaction page
- refactoring views by using collections, caches and pagination to avoid slow down
- separated conversation logic into a concern

Maybe one day:
- methods in transaction model could potentially be moved into a form object / decorator if grow bigger
- i would add a column for transaction type and save it to db this should help
  to filter transactions easier and avoid calculation in model

#### Others

1. ...
2. ...
3. ...
