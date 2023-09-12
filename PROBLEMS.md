### Please describe found weak places below.

#### Security issues

1. In controller actions do not render partials by the user's input value. In this case seems to be good but if you `render params[:type]` user can send you "../../../../etc/passwords"
2. app/controllers/transactions_controller.rb:28 -- Do not permit all incoming parameters. Use white liste instead.
3. ...
#### Performance issues

1. Add pagination to index action. And eager load managers to avoid N+1
2. We don't need to read all managers to memory to select a sample. We can use PSQL's native method "RANDOM()".
3. ...
#### Code issues

1. app/models/transaction.rb -- Omit "magic" numbers. Set const variable LARGE_AMOUNT = 100.freeze. The same for 1000.
2. Conditional validations is a business logic. For this case I would use Form object paattern and remove validations from model. Also it must be covered by unit tests.
3. before_create, before_validation.For small application is ok to have hooks but if we are going to add new features I would add CreateTransactionService and keep this code in it. 
4. Handle case with ActiveModel::Type::Integer with limit 4 bytes. Add validations or another data type in DB.
#### Others

1. Move text for validation errors to localisation file. Text from views also in localisation file.
2. @transaction.errors.full_messages_for(:first_name)... this part of code can be moved to partial to keep DRY principle.
3. I would remove from controller actions 'new_large' and 'new_extra_large' and render form partial depending on incomming parameter type.
4. Handle case when user select form for small amount and enters extra large amount etc.
5. Add specs. At least for validations where we use if-else.
