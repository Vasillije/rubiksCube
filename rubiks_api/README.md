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
* You can test the endpoints using Postman

# Endpoints
  * /cubes - Gets all cubes (GET)
  * /cubes/:id - Gets cube by ID (GET)
  * /cubes/create - Creates new cube (POST)
  * /cubes/rotate - Rotates cube's one side

# Create cube explanation
* Cube is created in initial state
  * Front side is in red
  * Back side is in orange
  * Left side is in green
  * Right side is in blue
  * Top side is in white
  * Bottom side is in yellow

# Cube's rotation functionality
* Each request rotates one cube's side or middle layer in provided direction
* Must provide json {"id": 1,"face": "back","direction": "left"}
* Cube has 6 sides - front, back, left, right, top and bottom
* Cube has 3 middle layers - middle-x(rotates middle layer around x-axis), middle-y(rotates middle layer around y-axis), middle-z(rotates middle layer around z-axis)
* Front, back, top, bottom, middle-y and middle-z can be rotated left and right
* Left, right and middle-x can be rotated up and down
