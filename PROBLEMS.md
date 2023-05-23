### Please describe found weak places below.

#### Security issues

1. Transaction parameters should be whitelisted during creation.
2. I'd remove the `manager_id` from the view and pick a manager during creation, like its done
currently. The view doesn't allow to select a manager. Exposing this parameter only increases
the possible attack surface.

#### Performance issues

1. The transactions index action requires pagination.
2. Index action has N+1 query problem.
2. A sample of a manager record should be picked inside the DB, not by Ruby.
3. It's good that managers first and last names are required in DB layer. Adding this requirement
in the model as well, will make creation and update of manager records faster since activerecord
won't access the DB in case of blank values. Plus, error messages will be under control.

#### Code issues

1. Based on the current state of the app, `new_large` and `new_extra_large` actions are redundant
in transactions controller.
2. Transaction type parameter requires validation.
3. Private methods of the `Transaction` model ask for refactoring

#### Others

1. It's not clear from requirements whether
   * small transactions can have client personal info
   * small/large transactions can have a manager assigned
