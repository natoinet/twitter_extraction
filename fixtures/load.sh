#!/bin/bash

python manage.py migrate

python manage.py loaddata application.json

python manage.py loaddata twitter_extraction.exportationformat.json
python manage.py loaddata twitter_extraction.exportationtype.json
python manage.py loaddata twitter_extraction.twitterlistextraction.json
