# Auction Broker

[https://actionbroker.herokuapp.com/](https://actionbroker.herokuapp.com/)

There is a `makefile` to help with deploying the software to Heroku.

The tests are weak, but they run using pytest.

Postgres is a dependency and uses environment variables to connect
to a development Docker instance or the production Heroku database.

The day of the sale, the production database is upgraded to a paid
for version.  Immediately after the sale the DB and web worker are
downgraded.

Data is cleared out between years, except for patrons.  See the
`makefile` for loading data from TSV files.


## Local Dev

`docker compose up` to get all the environments up and running -- Actually, using a local docker instance of PG and then
running the dev server from PyCharm is probably better.  These are already configured in the PyCharm IDE.

`heroku pg:backups:capture` and `heroku pg:backups:download <b00?>` 
to get the production data locally

`docker compose exec db pg_restore -d ab -h 127.0.0.1 -p 5432 -U ab -v --no-owner /data/dump-2023.dump`
to restore

`manage.py dumpdata auction.patron > patron_list.json`
and `manage.py loaddata patron_list.json` and `manage.py reset_all_buyer_numbers` to dump the list of patrons (
addresses, etc) and then reload it and remove all the buyer numbers -- see also `make local_new`


To push the local database to the remote heroku database: 
    `heroku pg:reset postgresql-triangular-11982`
    `heroku pg:push postgres://ab@127.0.0.1:5432/ab postgresql-triangular-11982`