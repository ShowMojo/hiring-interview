### Please describe found weak places below.

#### Security issues

1. In TransactionController in new action used `type` param to render view and it raises an error if the param change something else. ex: http://localhost:3000/transactions/new/hello
2. In TransactionController in create action used permit! on params that makes users to send non-exists columns
3. It needs captcha or authenticator for creating transaction otherwise users can use bot to send unlimited request
#### Performance issues

1. In index of transaction action has N+1 queries so i added eagarload 
2. In index of transaction action doesnt have pagination, so i added pagy gem
3. Manager.all.sample is slow so we can use query for getting random manager
#### Code issues

1. I used variants for rendering multiple views in new action
2. I moved all forms into one partial view and it's easy to handle and avoid to dry code
3. Avoid Controller fat and model fat and i used concerns for model callbacks and validations
#### Others

1. I would like to add import or export feature for transactions for users
2. I would add authentications for users and manager and create panel for users and dashboard to monitor transaction for admin
3. I would like to add some features likes integration with google sheet or third-party to bring all data into one app
4. I would some javascript code to render first name, last name if user type more than 100
