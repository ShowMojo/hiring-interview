### Please describe found weak places below.

#### Security issues

1. The transaction should not be iterable, we might need to use uid as primary key for transaction.
2. I merged 3 type forms(small, large, extra) to one form with consideration of user experience. Each required fields like first_name, last_name and manager are validated and generated according to the amount. If we have the forms separately, then we need to write amount validation for each transaction type, which requires much code.

#### Performance issues

1. The transactions view needs pagination. This can be implemented easily with Pagy or will_paginate gems
2. Server side rendering will not have a good performance.
3. Database Indexing and Caching will improve the performance.

#### Code issues

1. There is a possible issue for a large number of amount
2. assign_manager method in transaction.rb has a possible issue on MySQL. When using MySQL, it needs to be User.order("RAND()").first

#### Others

1. The transaction view needs some search and filter options by amount, manager, from_currency, to_currency etc.
2. Building the front end as single page application will improve the performance.
