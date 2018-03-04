FROM python:3.6.4-alpine

# Copy in your requirements file
ADD Pipfile /Pipfile
ADD Pipfile.lock /Pipfile.lock

# Require the psql client
RUN apk --update --upgrade add --no-cache postgresql-client cairo pango gdk-pixbuf
RUN apk add py3-lxml py3-cffi py3-pillow --repository http://dl-cdn.alpinelinux.org/alpine/edge/main/gi --alow-untrusted

# Install build deps, then run `pip install`, then remove unneeded build deps all in a single step. Correct the path to your production requirements file, if needed.
RUN set -ex \
    && apk add --no-cache --virtual .build-deps \
            gcc \
            make \
            libc-dev \
            musl-dev \
            linux-headers \
            pcre-dev \
            postgresql-dev \
            libffi-dev \
            openssl-dev \
            libjpeg-turbo-dev \
            cairo-dev \
    && pip install -U pip pipenv \
    && LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "pipenv install --three --system --ignore-pipfile --deploy" \
    && runDeps="$( \
            scanelf --needed --nobanner --recursive /venv \
                    | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
                    | sort -u \
                    | xargs -r apk info --installed \
                    | sort -u \
    )" \
    && apk add --virtual .python-rundeps $runDeps \
    && apk del .build-deps

# Copy your application code to the container (make sure you create a .dockerignore file if any large files or directories should be excluded)
RUN mkdir /code/
WORKDIR /code/
ADD . /code/

# uWSGI will listen on this port
EXPOSE 8000

# Add any custom, static environment variables needed by Django or your settings file here:
ENV DJANGO_SETTINGS_MODULE=config.settings.production

# uWSGI configuration (customize as needed):
ENV UWSGI_WSGI_FILE=auctionbroker/config/wsgi.py UWSGI_HTTP=:8000 UWSGI_MASTER=1 UWSGI_WORKERS=2 UWSGI_THREADS=8 UWSGI_UID=1000 UWSGI_GID=2000 UWSGI_LAZY_APPS=1 UWSGI_WSGI_ENV_BEHAVIOR=holy

# Call collectstatic (customize the following line with the minimal environment variables needed for manage.py to run):
#RUN DATABASE_URL=none python manage.py collectstatic --noinput

# Check
ENTRYPOINT ["/code/docker-entrypoint.sh"]

# Start uWSGI
CMD ["uwsgi", "--http-auto-chunked", "--http-keepalive"]