#!/bin/bash

python manage.py dumpdata twitter_extraction.exportationtype --indent 4 -o ~/twitter_extraction.exportationtype.json
python manage.py dumpdata twitter_extraction.exportationformat --indent 4 -o ~/twitter_extraction.exportationformat.json
python manage.py dumpdata twitter_extraction.twitterlistextraction --indent 4 -o ~/twitter_extraction.twitterlistextraction.json
