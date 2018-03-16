# README

* Start everything

docker-compose up --build --scale app=5

* Reset the database

docker-compose exec --user "$(id -u):$(id -g)" app rails db:reset

* Migrate the database

docker-compose exec --user "$(id -u):$(id -g)" app rails db:migrate
