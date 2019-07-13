
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
	python manage.py collectstatic --no-input && \
	python manage.py migrate && \
	python manage.py create_booths && \
	python manage.py loaddata --app auction.patron 2018_patron_dump.json && \
	python manage.py create_users && \
	python manage.py import_auction_items "Auction" 2019_auction_items.tsv --year 2019 --month 7 --day 13 && \
	python manage.py import_auction_items "Silent Auction" 2019_silent_auction_items.tsv --year 2019 --month 7 --day 13 && \
	python manage.py reset_all_buyer_numbers
#	python manage.py create_patrons && \
#	python manage.py populate_testdb && \
#	python manage.py purchase_random_items

