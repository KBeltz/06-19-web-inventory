# 06-19-web-inventory

###Assignment instructions:
Your task is to build a browser-based UX for your Warehouse Manager using Sinatra. At bare minimum, your application should fulfill all of the functionality that it currently has via its command-line "driver". Make this a brand new project folder, but copy over your models and database modules – really everything but the driver.

You'll re-use all of your models, but your driver will be replaced by a Sinatra "controller".

All input should be done using web-forms, and all output should be rendered with ERB.

Your application does not need to be visually attractive, but it should be readable and functional. Use of CSS is prohibited; because we will be using these web applications for our introduction to CSS next week, and any CSS you write will conflict with how we guide students into proper CSS writing.

If you are using your ORM correctly, you should be able to create objects without having to first save them to the database. This means you should be able to write methods in your classes that are strictly business logic.

All methods that are strictly business logic should have tests written using Minitest. No other methods require tests. Nothing in your database modules requires testing.

###Clarification:
This is an assignment for Omaha Code School to refactor a previous inventory database project using Ruby and SQL to have a web interface rather than command-line; however, we are not to use ActiveRecord or CSS.
