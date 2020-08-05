#!/bin/bash

echo Delete sqlite3 DB ...
rm -f db.sqlite3 || true

if [ "$DEBUG" == 'false' ]; then
  echo Give DB time to boot...
  sleep 60
fi

echo Make migrations ...
find . -path "*/migrations/*.py" -not -name "__init__.py" -delete
find . -path "*/migrations/*.pyc"  -delete

python3 manage.py makemigrations
python3 manage.py migrate

echo Collect Static ...
mkdir "$PWD/static"
python3 manage.py collectstatic

echo Create first user
DJANGO_DB_NAME=default
DJANGO_SU_NAME=admin
DJANGO_SU_EMAIL=admin@smartpackagecode.com
DJANGO_SU_PASSWORD=testuser

python3 -c "import os;os.environ.setdefault(\"DJANGO_SETTINGS_MODULE\", \"datascience.settings\");import django; django.setup(); \
   from django.contrib.auth.management.commands.createsuperuser import get_user_model; \
   get_user_model()._default_manager.db_manager('$DJANGO_DB_NAME').create_superuser( \
   username='$DJANGO_SU_NAME', \
   email='$DJANGO_SU_EMAIL', \
   password='$DJANGO_SU_PASSWORD')"

echo -e "\x1B[1;31mFirst User Login is username: '$DJANGO_SU_NAME' password: '$DJANGO_SU_PASSWORD' \x1B[0m"
echo -e "\x1B[1;31mNavigate to 0.0.0.0:8060/admin to login \x1B[0m"

echo -e "\x1B[1;31mStarting Gunicorn ... \x1B[0m"

exec gunicorn datascience.wsgi:application \
    --bind 0.0.0.0:8060 \
    --workers 4 --timeout 1000 --reload