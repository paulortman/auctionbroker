start:
	docker-compose start


# delete all data, build containers, start them
fresh:
	docker-compose down && \
	docker-compose up -d --build && \
	sleep 5 && \
	docker-compose exec -T app python manage.py create_users && \
	docker-compose exec -T app python manage.py populate_testdb && \
	docker-compose exec -T app python manage.py purchase_random_items

# push the app image to the FHD image repository
push:
	eval $$(aws ecr get-login --no-include-email --region us-east-1) && \
	docker build -t auctionbroker . && \
	docker tag auctionbroker:latest 594645421903.dkr.ecr.us-east-1.amazonaws.com/paulortman/auctionbroker:latest && \
	docker push 594645421903.dkr.ecr.us-east-1.amazonaws.com/paulortman/auctionbroker:latest

# heroku deploy steps
deploy:
	python manage.py collectstatic --no-input && \
	python manage.py migrate
#	python manage.py populate_previous_attendies && \
#	python manage.py create_users && \
#	python manage.py populate_testdb && \
#	python manage.py purchase_random_items

# Use git to deploy code to Heroku
heroku_deploy:
	git push heroku master

