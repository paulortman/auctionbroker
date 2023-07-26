FROM python:3.11-slim AS base

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

#FROM base AS python-deps

# Install pipenv and compilation dependencies
RUN pip install pipenv
RUN apt-get update &&  \
    apt-get install -y --no-install-recommends \
        build-essential \
        libcairo2 \
        libpango-1.0-0 \
        libpangocairo-1.0-0 \
        libgdk-pixbuf2.0-0 \
        libffi-dev \
        shared-mime-info \
        postgresql-client \
        libpq-dev \
        git-core

# Install python dependencies in /.venv
COPY Pipfile .
COPY Pipfile.lock .
ENV PATH="/usr/local/bin/:$PATH"
RUN PIPENV_VENV_IN_PROJECT=1 \
    pipenv --python /usr/local/bin/python update && \
    pipenv --python /usr/local/bin/python install --dev --deploy


#FROM base as runtime

#COPY --from=python-deps /.venv /.venv
ENV PATH="/.venv/bin:$PATH"

#RUN which python && python --version && pipenv --python /usr/local/bin/python install && pipenv lock  && pipenv update && \
#    pipenv install --system --deploy
#RUN pipenv --python /usr/local/bin/python install && pipenv update && pipenv install --system

# Copy your application code to the container (make sure you create a .dockerignore file if any large files or directories should be excluded)
#RUN mkdir /code/
#WORKDIR /code/
#ADD . /code/

# Create and switch to a new user
RUN useradd --create-home appuser
WORKDIR /home/appuser
RUN chown appuser:appuser -R /.venv

# Install application into container
COPY . .
RUN chown appuser:appuser -R ./
USER appuser

# uWSGI will listen on this port
EXPOSE 8000

# Add any custom, static environment variables needed by Django or your settings file here:
ENV DJANGO_SETTINGS_MODULE=config.settings.production

# uWSGI configuration (customize as needed):
#ENV UWSGI_WSGI_FILE=config/wsgi.py UWSGI_HTTP=:8000 UWSGI_MASTER=1 UWSGI_WORKERS=2 UWSGI_THREADS=8 UWSGI_UID=1000 UWSGI_GID=2000 UWSGI_LAZY_APPS=1 UWSGI_WSGI_ENV_BEHAVIOR=holy

# Call collectstatic (customize the following line with the minimal environment variables needed for manage.py to run):
#RUN DATABASE_URL=none python manage.py collectstatic --noinput

# Check
ENTRYPOINT ["./docker-entrypoint.sh"]
#ENTRYPOINT ["/bin/bash"]


# Start uWSGI
#CMD ["uwsgi", "--http-auto-chunked", "--http-keepalive"]
#CMD ["gunicorn", "config.wsgi:application", "--bind=0.0.0.0:8000"]
#CMD ["/bin/bash"]
