#!/usr/bin/env bash

set -x

python manage.py collectstatic --no-input && \
python manage.py migrate
