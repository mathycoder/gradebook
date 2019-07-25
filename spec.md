# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project

class LearningTarget < ApplicationRecord
  belongs_to :standard
  has_many :klass_learning_targets
  has_many :klasses, through: :klass_learning_targets
  has_many :assignments, :dependent => :delete_all
  has_many :grades, through: :assignments
  has_many :students, through: :klasses


- [x] Include at least one has_many relationship (x has_many y; e.g. User has_many Recipes)

LearningTarget has_many :klass_learning_targets

- [x] Include at least one belongs_to relationship (x belongs_to y; e.g. Post belongs_to User)

LearningTarget belongs_to :standard

- [x] Include at least two has_many through relationships (x has_many y through z; e.g. Recipe has_many Items through Ingredients)

LearningTarget has_many :klasses, through: :klass_learning_targets

- [x] Include at least one many-to-many relationship (x has_many y through z, y has_many x through z; e.g. Recipe has_many Items through Ingredients, Item has_many Recipes through Ingredients)

LearningTargets have many Klasses, and Klasses have many Learning Targets

- [x] The "through" part of the has_many through includes at least one user submittable attribute, that is to say, some attribute other than its foreign keys that can be submitted by the app's user (attribute_name e.g. ingredients.quantity)

LearningTargets act as a through for Klasses and Assignments.  A Klass has many Assignments, through LearningTargets.  Users can submit :name, :level1, :level2, :level3, and :level4 directly on a LearningTarget.  

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)

LearningTargets, Assignments, Klasses, Grades, Students, and Teachers all have validations.

class Assignment < ApplicationRecord
  has_many :grades, validate: true, :dependent => :delete_all
  validates :name, presence: true, length: { maximum: 40 }
  validates :date, presence: true

An Assignment validates for the presence and length of a name, and the presence of a date.  It also validates it's has_many association for grades, which have their own validations.  

- [ ] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)

- [x] Include signup (how e.g. Devise)

There's a signup for teachers in views/teachers/new

- [x] Include login (how e.g. Devise)

There's a login through views/sessions/new, which logs in through sessions#create

- [x] Include logout (how e.g. Devise)

Logout routes to the controller action sessions#destroy

- [x] Include third party signup/login (how e.g. Devise/OmniAuth)

Signup/login can be done through Facebook.  Authentication then happens only through Facebook, and a random password is generated for the database.  

- [ ] Include nested resource show or index (URL e.g. users/2/recipes)

Show page for learning targets in class
http://localhost:3000/classes/2/lts/15

show page for students in a class
http://localhost:3000/classes/2/students/8

many more!

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients/new)

Nested new form for assignments within a class
http://localhost:3000/classes/2/assignments/new

- [x] Include form display of validation errors (form URL e.g. /recipes/new)

Assignments, Grades, Klasses, LearningTargets, Students, and Teachers all display validation errors.

Confirm:
- [x] The application is pretty DRY

For example, the gradebook table is used with slight modifications on both klasses/show and learning_targets/show, with only different arguments passed into a partial to make that happen.  Also, many helper methods prevent repetitive code.  

- [ ] Limited logic in controllers
- [ ] Views use helper methods if appropriate
- [ ] Views use partials if appropriate
