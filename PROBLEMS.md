### Please describe found weak places below.

#### Security issues

1. updated 'nokogiri' and 'puma', found vulnerabilities using 'bundler-audit'
2. need to implement authentication and authorization because anyone can see personal data on index and show pages
3. fixed 'params.permit!' issue in 'transaction_controller'

#### Performance issues

1. fixed N+1 issue in 'transaction_controller'
2. changed manager selecting logic to select random manager and not preload all of them
3. added pagination to 'index' page to avoid performance issues

#### Code issues

1. moved 'full_name' logic from model to helper
2. added rubocop to increase code quality
3. removed 'new_large' and 'new_extra_large' actiones since it is code duplication
4. would be good idea to move validation to separate class later

#### Others

1. would be good idea to add tests to cover transaction logic
2. would be good idea to implement some logic to automatically update exchange rates in background
3. would be good idea to change logic of manager selection, not to just select random one
