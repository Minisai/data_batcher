# README

* Start everything

docker-compose up --build

* Reset the database

docker-compose exec --user "$(id -u):$(id -g)" app rails db:reset

* Migrate the database

docker-compose exec --user "$(id -u):$(id -g)" app rails db:migrate
