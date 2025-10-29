#!/bin/bash
python manage.py makemigrations accounts
python manage.py migrate
