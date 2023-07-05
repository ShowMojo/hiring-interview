### Please describe found weak places below.

#### Security issues

1. Adding Authentication/Authorization mechanisms would be reasonable.
2. Transaction creation doesn't permit parameters, accepts all params, can be manipulated.
3. During transaction creation, type is defined by parameter, should be determined with amounts.
   Ambiguous and also may cause security issues.

#### Performance issues

1. N+1 query problem in index, should use '.includes' to get rid of this.
2. Pagination would be good in index for performance reasons, if we have
   thousands or millions of transactions fetching them all doesn't make sense.
   Some filters functionality also would be good from users perspective.
3. ...
#### Code issues

1. No rubocop validation
2. new_large and new_extra_large methods are not necessary
3. Mandatory to cover at least critical functionality with tests
4. Hardcoded money numbers. Also implementation of .large? method was wrong.(true for extra larges too!)

#### Others
1. Validates client information only for large transactions
2. Doesn't show errors when it can not create
3. Transaction doesn't store information about it's type and type is determined dynamically.
   Would be better for filtering and also would make information more consistent as if in the futere
   we change definition of transaction types old transactions type would remain as in the moment of creation
4. hardcoded error texts, I18 would be better to store texts together, also hardcoded money numbers not good
5. Gemfile needs some cleanup, if rubocop was added, ordering of gems would be changed. Also some unused gems.