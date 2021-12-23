# Pulls base image
FROM python:3

RUN mkdir -p /home/django && groupadd -r django && useradd --no-log-init -r -g django django && newgrp django && chown -R django:django /home/django

USER django

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1 \
	PYTHONUNBUFFERED 1

# Set work directory 
WORKDIR /code

# Install dependencies
COPY Pipfile Pipfile.lock /code/
RUN pip install --upgrade pip && pip install pipenv && PATH=/home/django/.local/bin:${PATH} pipenv install --system

# Copy project
COPY . /code/