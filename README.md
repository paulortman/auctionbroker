# Auction Broker

[https://actionbroker.herokuapp.com/](https://actionbroker.herokuapp.com/)

There is a `makefile` to help with deploying the softare to Heroku.

The tests are weak, but they run using pytest.

Postgres is a dependency and uses environment variables to connect
to a development Docker instance or the production Heroku database.

The day of the sale, the production database is upgraded to a paid
for version.  Immediately after the sale the DB and web worker are
downgraded.

Data is cleared out between years, except for patrons.  See the
`makefile` for loading data from TSV files.
