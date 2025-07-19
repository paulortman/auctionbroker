
# heroku deploy steps
deploy:
	python manage.py collectstatic --no-input && \
	python manage.py migrate
#	python manage.py create_users && \
#	python manage.py populate_testdb && \
#	python manage.py purchase_random_items
