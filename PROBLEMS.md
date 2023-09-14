### Please describe found weak places below.

#### Security issues

1. Use strong parameters for `TransactionsController`
2. Add authentication logic for access (e.g. Devise)
3. Add authorization logic in case different user roles (e.g. Pundit)

#### Performance issues

1. Add pagination for transactions list (e.g. Kaminari)
2. [+] Fix n+1 problem by including managers to the transaction list query
3. [+] Replace `Manager.all.sample` query with `Manager.order("RANDOM()").first`

#### Code issues

1. [+] Get rid of redundant `new_large` & `new_extra_large` actions
2. [+] Random manager is needed for extra large transactions only. Could be selected on the model side.
3. [+] Use PostgreSQL UUID as a primary key
4. Get rid of `new_small`, `new_large`, and `new_extra` views, use single dynamic form instead.
5. [+] Use decorators to access combined attributes (e.g. Draper)
6. Use code style linter (e.g. Rubocop)
7. Use service objects to manage transactions
8. Use bigint for cents columns, extend validations
9. Add specs

#### Others

1. [+] Dockerise application for local development
2. Use tool to identify possible n+1 problems (e.g. Bullet)
