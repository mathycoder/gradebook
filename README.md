To install, first clone and fork this repository.  Then run 'bundle install' to set up all of the gems in your local environment.  Finally run 'rails s'.  Navigate to http://localhost:3000

# MyGradebook

Welcome to MyGradebook!  This is a standards-based gradebook that organizes assignments and grades under custom learning targets, which are connected to the Common Core State Standards.  

## Installation

Clone this repository using

  $ git clone git@github.com:mathycoder/gradebook.git

Then go into the directory

  $ cd gradebook

From there, execute bundle

  $ bundle install

You'll need to load up the database, so run:

  $ rake db:migrate

Optionally, add some students to the database using my seed data:

  $ rake db:seed

Finally, to launch the application, run the rails server

  $ rails s

## Usage

Start by creating an account through the site or by connecting with Facebook.  
* On the main page, add some new students to the school.  You'll use these in your gradebook.
* Create a new class.
* Inside the class, click "+LT" create your first learning target.  This will take a while to load, as it has to scrape all the Common Core State Standards the first time you use it.
* Click "+S" to add some students to your class.  
* Click "+A" to add your first assignment and grades!  

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mathycoder/gradebook. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The application is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
