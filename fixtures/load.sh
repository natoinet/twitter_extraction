#!/bin/bash
APP_PATH=tucat/twitter_extraction/fixtures/

python manage.py makemigrations twitter_extraction
python manage.py migrate --fake-initial

function importfixtures {
  for fixture in "$@"
  do
    if [ -e $APP_PATH$fixture.json ]
    then
      echo "Importing $fixture"
      python manage.py loaddata $APP_PATH$fixture.json
    else
      echo "No $fixture to import"
    fi
  done
}

importfixtures application twitter_extraction.exportationformat twitter_extraction.exportationtype twitter_extraction.twitterlistextraction
