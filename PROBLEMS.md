### Please describe found weak places below.

#### Security issues

1. No authentication in place. I would recommend to implement authentication and access control with manager and client roles. `Pundit` is a good gem to start with.
2. Noticed vulnerabilities in Puma and Nokogiri gems using `bundler-audit`. Updated gems.
3. Whitelisting controller input params allows to avoid unpredicted data manipulations.

#### Performance issues

1. Requiring `rails/all` in `application.rb` preloads all Rails engines into the memory. Not all of those were needed in the application. Replaced it with specific engine requires. 
2. Used 'bullet' to identify and fix  an `n + 1` query issue. It can also notify about unused eager loading instances.
2. It was necessary to add pagination to transactions#index. As the list of transactions grows it would instantly become an issue.
3. Moved picking a manager for extra large transactions right before saving the transaction to avoid extra DB calls when rendering the view.
4. `Manager.all.sample` was loading all managers into the memory just to pick one. Replaced with an optimal DB query.

#### Code issues
1. Using `Rubocop` to ensure better code quality and style across the team.
2. `uid` should have been unique. Made it unique and made sure it does not repeat an already existing record when generating. 
2. `new_large` and `new_extra_large` controller actions were redundant
3. Created `full_name` helper method to move presentation related functionality out of models and reduce code repetition.
4. Simplified transaction validations. Probably it's a good idea to move those into a separate class later.
5. Moved transaction creation and currency conversion into a service class. Extracted business logic out of the model to keep it thin and make easier to write specs later.
6. Currency rates were being fetch only during the initialization of the app. Implemented refresh logic with caching that expires once in an hour. Easy to adjust the timing later if needed.

#### Others

1. Need to add test coverage. I would suggest to switch to `RSpec` which has larger community support and a lot of additional helper libraries. Recommended to start the coverage with the core business logic (in this case currency conversion) and then expand if there are dev resources to do so. 
2. Ordered transactions in descending order. It is a common practice to have latest records appear on top of the list for easier access.
3. Removed unused `jbuilder` gem
