### Please describe found weak places below.

#### Security issues

1. param not permited
2. everyone can see all the transaction
3. small action should only create small transaction
4. large action should only create large transaction
5. extra large action should only create extra large transaction
#### Performance issues

1. should have pagination for transaction#index, so it will be faster to load as the number data grow
2. slow manager query with `all.sample` as the number of manager grow
3. unnecessary query manager on every controller actions
#### Code issues

1. complicated business logic, too many if else make other dev hard to follow
2. should follow restful and have separate controller betwen small, large and extra large transaction
3. unnecessary manager_validation and should be automatically assigned in our case
#### Others

1. should have genarate uniq link for current user session or user login if we don't want to list all transaction to everyone
2. improve validation message for extra large when user select different currency from USD, so system shows minimum money in selected currency
3. missing unit and controller test(i prefer to use Rspec)
