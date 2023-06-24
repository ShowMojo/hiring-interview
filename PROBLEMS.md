### Please describe found weak places below.

#### Security issues

1. `app/controllers/transactions_controller.rb:28`: using `permit!` to allow all params is easier 
but may lead to unwanted data manipulation. We should full params list instead.
2. As we already using `transaction#uid` in system, it would be safer to remove all real `id` presence from client access part.
#### Performance issues

1. `app/controllers/transactions_controller.rb:29` - subject to potential record quantity using `all` method 
in such operation will prolong request execution time. I suggest using `Model.order("RANDOM()").limit(1).first`.
https://stackoverflow.com/questions/2752231/random-record-in-activerecord#:~:text=If%20you%20have%20100k%20rows%20in%20your%20database%2C%20all%20of%20these%20would%20have%20to%20be%20loaded%20into%20memory
2. Transactions `#index` action requires pagination as it would be tremendously slow with big amount of data.
3. Redundant `.self` in `app/models/transaction.rb:41` We don't need `self.#` when we don't assign value in this method. 
I would also avoid singular `if` statement in favor of `return unless to_amount.blank?` etc.
#### Code issues

1. I would suggest not to use non-CRUD actions if they could be avoided.
`new_large` and `new_extra_large` in `TransactionsController` should leave :)
2. Same goes for transaction `new_...` view templates. They seem to share significant amount of logic thus I would move
all of them into one file with conditional rendering of `type` dependent parts that would rely on `params[:type]`.
3. I would add enum `type` to `Transaction` model, as we highly rely on it in many parts of our app. This not only would allow us
to get rid of validation errors, but strengthen our logic itself.
4. app/models/transaction.rb:2 There's `%w` solution for arrays of strings, would be better to use it in exchange of simple array declaration.
5. Thin model: `Transaction` model seems rather bloated, we can reduce it's size by moving validations to separate validator.
Methods could go to some kind of `TransactionConcern` module. 
6. Conventions suggest against callbacks in model actions, I would suggest to use Trailblazer`s operation like approach,
or even some service objects. This would allow us to improve readability and maintainability of our project.
https://github.com/trailblazer/trailblazer#operation:~:text=the%20main%20concepts.-,Operation,-The%20operation%20encapsulates
7. Although codebase is small, but it needs test coverage to remain stable behaviour. Intergation test and unit tests would be sufficient at that time.
#### Others

1. There are validation errors that allow us to create mismatching types of transactions. eg: `type: small, amount: 1234`. 
2. This will lead to many issues in code, such as validation error that will not be rendered in view
3. Fields naming: as long as we don't need separate model for `Transaction` creator(for large transactions), 
would be better to specify that this fields belong to creator. E.g.: `creator_first_name`, `creator_last_name`. 
In that way we won't be confused with creator and manager attributes along the way.
4. Not necessary: I would move `app/views/transactions/index.html.erb:13` to has_many
5. There's always room for improvement :)
