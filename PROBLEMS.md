### Please describe found weak places below.

#### Security issues

1. Everyone can see the transaction by ID `app/controllers/transactions_controller.rb:8`
2. Everyone can see list of the transactions by `index` action
3. The better find transaction by `uid`
4. Good practice is using permitted_params instead of unsecure `params.permit!`
#### Performance issues

1. No need to get a manager `app/controllers/transactions_controller.rb:13` unless it 
extra_large transaction. Or better remove it here, in a view. And call only in `create` action.
2. In the `index` action no pagination
3. N+1 when calling a .manager in `app/views/transactions:30`
4. `Manager.all.sample` is not optimal way. The better use random from DB 
(E.g. `Manager.order(Arel.sql('RANDOM()')).first`)
#### Code issues

1. In TransactionsController actions `new_large` and `new_extra` are redundant.
2. No any tests here. We can't be sure the code is working properly.
3. Move validation of `Transaction` in a separate class from the model.
#### Others

