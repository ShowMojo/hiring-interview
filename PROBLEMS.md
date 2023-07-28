### Please describe found weak places below.

#### Security issues

1. Anyone can view/access all the transactions available in the system, inclusing sensitive and personal data. Solution: add some sort of authentication and/or authorization, even a self-made simple one would be more than nothing.
2. As a consequence of the first issue, anyone can access any particular transaction simply by its ID that is numeric can sequential. Solution: use authorization or at least make the transactions available by their UIDs and not by IDs.
3. The rendered template in the transactions#new action is taking directly a value from the user input that can potentially expose the content of templates that should not be visible. Solution: use hardcoded template names and, if necessary, use additional code to check for permitted variants and provide a valid template name based on code result.
4. The 'transaction' params uses `permit!` in order to accept all the incoming data from the user, even the 'to_amount' atribute could be provided by the user and get the desired amount. Solution: only the specific attributes should be explicitly permitted.
5. Inside the Transaction model there is a check for "to_amount" in #convert that could be harmful. Solution: the conversion should be done without depending on data existence.
6. Normally, the transaction 'type' should be managed at front-end level (change the UI in accordance with user selection or even by parsing the amount field) and it should not be provided as a dedicated parameter (the backend should deduct the type from the exchange amount). This way the attack surface would be a little bit more limited (less user params mean lower chances to do a mistake). Solution: the 'type' should not be passed from front-end.
7. The input form is totally vulnerable for bots/scripts/etc. Solution: authentication/authorization or maybe a captcha. 
8. The 'uid' field is too short (being 5) in case it's available for accessing a transaction and someone could guess or enumerate variants with a high chance of finding exisitng UIDs. Solution: use more digits, at least 16.
9. The 'manager_id' should not be passed to front-end and then passed back as a parameter that can be altered by the user and provide there unwanted values. Solution: assign the manager only in the back-end when saving the record.
10. The users can create "extra large" transactions with an assigned manager for amounts less than $1000, this way they can generate a kind on DOS attack (all the managers will be flooded with a large number of transactions they should not waste time on). Solution: enhance validation.
11. There could be vulnerable versions of gems or unspotted locations in the code. Solution: add some static analysis tools that would help with security issues - brakeman and bundler-audit gems are usually recommended for this.
12. The current app doesn't seem to be so sophisticated from a security point of view, but generally it would be a good idea to store personal and sensitive data encrypted. Also, being a financial app, it would help to register as log data in case of some frauds (for example IPs).
13. database.yml is not added to "gitignore", to it can be easily a source of credentials leak is someone is not careful enough.

#### Performance issues

1. The transactions#index action returns all the transactions. Solution: pagination.
2. The `Manager.all.sample` code could be potentially a source of resources waste, but considering the real constraints of the business where most probably the number of managers is pretty small, it's more theoretical than practical. Solution: it depends how real the issue is and what are the constraints - can we use raw SQL or not, are there many "extra large" transactions or not, etc. Caching the managers collection is also a solution.
3. Useless manager selection in "new" actions. Solution: select the random manager only once when everything is valid and ready to be saved.
4. The 'index' view uses the `manager` association for a collection of transactions, so it's a N+1 issue with the current code. Solution: add `includes` or `preload`.

#### Code issues

1. The ActiveRecord `find` method is used without any exception handling. 
2. Many values are hardcoded in-place. Better to define them as constants.
3. The Manager model lacks some validations at least for first and last name.
4. The "numericality" option is missing from the "to_amount_cents" money field (Transaction model).
5. The 'show' action is intended to present info about a successfully added transaction, but it's not suitable for a normal 'show' that presents the necessary info about a particular record.
6. The edge amounts for sizes are hardcoded both in logic and in text. Better to have this dynamically adaptable so we could easily change these limits with minimal effort.
7. It's better to keep public methods to the strictly necessary set and do not expose those methods that can be private.
8. Some repeating portions from views can be extracted to helpers.
9. Tests/specs, at least for the most important parts, are very desirable, especially when working with business logic that works with money amounts and transactions.

#### Others

1. "Transaction" is a very generic name applied in many places and cases. It would be more appropriate to have a more exact name like "CurrenciesTransaction" or maybe a short "Txn", if it's one of the main entities in the app and this short name is clear for everyone.
2. It depends on the selected code structuring pattern, but using "service objects" or something similar could help to extract some logic from models, especially all that goes to callbacks or uses them (callbacks are always a source of problems by being somehow semi-hidden logic).
3. With the current state of the app it's not an issue yet, but there are almost no indexes in the DB and this could be a problem very quickly.
4. Some DRYing could be applied to form fields, but it's still questionable in my opinion (DRY vs simplicity and cohesion).
5. The current code lacks it, but using Rubocop is very desirable in order to keep more or less the code clean and consistent.
6. Having a single "new" view could be an option (with additional branching logic to select different parts based on size type), but again it's DRY vs simplicity.
7. In a system with authentication/authorization we could have managers and clients as "users" and use this fact for better data organization, for example we wouldn't use "first_name" and "last_name" in a transaction, but we would link a client by ID from the DB.
8. Most probably it will be necessary to have the transactions sorted in a meaningful order (probably by creation time, with an index on it). Currently they are presented as the DB retrieve them.
