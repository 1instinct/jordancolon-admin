#!/bin/sh

set -e

# to blank the database ahead of time, run
#  sudo rm -rf tmp/db

docker-compose build
docker-compose up -d

# wait for postgres to come up
while ! nc -zv localhost 5433 ; do
    echo "Waiting for postgres to come up..."
    sleep 5
done

docker-compose exec web rails db:create db:schema:load db:migrate
docker-compose exec \
    -e ADMIN_EMAIL=spree@example.com \
    -e ADMIN_PASSWORD=spree123 \
    web bundle exec rails db:seed

docker-compose exec \
    -e SKIP_SAMPLE_IMAGES=false \
    web bundle exec rake spree_sample:load

docker-compose restart web

echo "App is now running at http://localhost:8080"

# to follow logs...
#   docker-compose logs -f

# to deploy to k8
#   kubectl apply -f dna-k8.yaml

# to forward port
#   kubectl port-forward --address 0.0.0.0 service/dna-entrypoint 3000
