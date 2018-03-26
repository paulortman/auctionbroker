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
	eval $(aws ecr get-login --no-include-email --region us-west-2) && \
	docker build -t auctionbroker . && \
	docker tag auctionbroker:latest 594645421903.dkr.ecr.us-west-2.amazonaws.com/auctionbroker:latest && \
	docker push 594645421903.dkr.ecr.us-west-2.amazonaws.com/auctionbroker:latest
