# Technologies
* Ruby version 3.4.5
* Rails version 8.0.2.1
* PostgreSQL DB

# How to run project
* git clone
* Install dependencies with 'bundle install'
* Create database with 'rails db:create'
* Run migrations with'rails db:migrate'
* Run rails server with 'rails s' (The server will run at http://localhost:3000)
* Run all tests with 'bundle exec rspec'
* Run cube's rotation tests with 'rspec spec/models/cube_spec.rb'

# Endpoints
  * /cubes - Gets all cubes (GET)
  * /cubes/:id - Gets cube by ID (GET)
  * /cubes/create - Creates new cube (POST)
  * /cubes/rotate - Rotates cube's one side
  * You can test the endpoints using Postman

# Create cube explanation
* Cube is created in initial state
  * Cube has one field named state(json, has 6 strings that represent 6 sides)
  * Front("front") side is in red("R")
  * Back("back") side is in orange("O")
  * Left("left") side is in green("G")
  * Right("right") side is in blue("B")
  * Top("top") side is in white("W")
  * Bottom("bottom") side is in yellow("Y")

# Cube's rotation functionality
* Each request rotates one cube's side or middle layer in provided direction
* Must provide json {"id": 1,"face": "back","direction": "left"}
* Cube has 6 sides - front, back, left, right, top and bottom
* Cube has 3 middle layers - middle-x(rotates middle layer around x-axis), middle-y(rotates middle layer around y-axis), middle-z(rotates middle layer around z-axis)
* Front, back, top, bottom, middle-y and middle-z can be rotated left and right
* Left, right and middle-x can be rotated up and down
