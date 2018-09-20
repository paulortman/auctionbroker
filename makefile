start:
	docker-compose start


# delete all data, build containers, start them
fresh:
	docker-compose down && \
	docker-compose up -d --build && \
	sleep 5 && \
	docker-compose exec -T app python manage.py create_users && \
	docker-compose exec -T app python manage.py populate_auction_items && \
#	docker-compose exec -T app python manage.py populate_testdb && \
#	docker-compose exec -T app python manage.py purchase_random_items && \

up:
	docker-compose up

down:
	docker-compose down

# push the app image to the FHD image repository
#push:
#	eval $$(aws ecr get-login --no-include-email --region us-east-1) && \
#	docker build -t auctionbroker . && \
#	docker tag auctionbroker:latest 594645421903.dkr.ecr.us-east-1.amazonaws.com/paulortman/auctionbroker:latest && \
#	docker push 594645421903.dkr.ecr.us-east-1.amazonaws.com/paulortman/auctionbroker:latest

# heroku deploy steps
deploy:
	python manage.py collectstatic --no-input && \
	python manage.py migrate
#	python manage.py create_users && \
#	python manage.py populate_testdb && \
#	python manage.py purchase_random_items

# Use git to deploy code to Heroku
heroku_deploy:
	git push heroku master


local_new:
	rm -f db.sqlite3 && \
	python manage.py collectstatic --no-input && \
	python manage.py migrate && \
	python manage.py create_users && \
	python manage.py create_booths && \
	python manage.py populate_auction_items && \

