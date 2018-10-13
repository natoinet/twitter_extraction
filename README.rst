Twitter list extraction Tucat plugin
==============================

--------------
Prerequisites:
Install the Tucat.
In order to to so, you must simply follow the steps at https://github.com/natoinet/tucat

Clone the Twitter list extraction plugin to the Tucat volume
-------------

  # sudo docker cp tucat/twitter_extraction `doc_tucat`:/opt/services/djangoapp/tucat/twitter_extraction/

  # cd tucat

Add the Twitter list extraction plugin app to the Tucat
--------------
With a text editor like vim, open the Tucat configuration file :
  # vim config/settings/docker.py

Then, in the LOCAL_APPS section, after tucat.application, you need to insert
the following line :

  'tucat.twitter_extraction',

Then you save and exit the file.

Copy the modified Tucat configuration file to the Tucat container :
-------------

  # sudo docker cp config/settings/docker.py `doc_tucat`:/opt/services/djangoapp/config/settings/docker.py


Setup the plugin
--------------

  # sudo docker-compose run --rm djangoapp ./tucat/twitter_extraction/fixtures/load.sh

Restart the Tucat
--------------

  # sudo docker-compose up

LICENSE: BSD
