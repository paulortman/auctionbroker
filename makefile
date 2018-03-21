start:
	docker-compose start


fresh:
	docker-compose down && \
	docker-compose up -d --build && \
	sleep 5 && \
	docker-compose exec -T app python manage.py create_users && \
	docker-compose exec -T app python manage.py populate_testdb && \
	docker-compose exec -T app python manage.py purchase_random_items
