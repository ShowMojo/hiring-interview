### Please describe found weak places below.

#### Security issues

1. Currently there is no authentication for the `managers/super admin`. We can use `devise` gem to integrate authentication process.
2. Currently there is no authorization for the managers/super admin. We can use `cancancan` gem or `pundit` gem for the authorization process
3. We can use `SecureRandom UUID` instead of auto generic id.

#### Performance issues

1. For the index page there is no pagination. We can add the pagination with the popular `kaminari` gem.
2. Added the managers list in the view as I am assuming that global admin can assign the extra large amount to a dedicated manager.

#### Code issues

1. Created a subclasses for different transaction type. This way, we can apply `dry` principle in the code. We can add validation or rules in the subclasses. In future, for a specific change in the specific class we can just apply the changes in that specific class.
2. Added a cool method in the `SubclassFinder` to find the subclasses.
3. Reduced the initialization method declaration for different type and removed duplicacy code.
4. Permit specific params in the controller which needed to permit.
#### Others

1. ...
2. ...
3. ...
