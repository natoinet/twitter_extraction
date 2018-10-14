#!/bin/bash

python manage.py makemigrations twitter_extraction
python manage.py migrate --fake-initial

python manage.py loaddata application.json

python manage.py loaddata twitter_extraction.exportationformat.json
python manage.py loaddata twitter_extraction.exportationtype.json
python manage.py loaddata twitter_extraction.twitterlistextraction.json
