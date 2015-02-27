What we have here
=================

Want to control your sparkcore on a schedule from Heroku?

Simple bash script to turn on and off the D0 to D3 digital output
lines of a Sparkcore (https://spark.io), a wifi enabled arduino
with an optional relay shield.

This is as simple as it needs to be to run from Heroku.

For this to run on Heroku you'll need to use the null buildpack,
good instructions for setup here:

https://github.com/ryandotsmith/null-buildpack

For scheduling take a look at Heroku Scheduler here:

https://devcenter.heroku.com/articles/scheduler

Local setup
===========

The Spark core ID and your secret token need to be in the environment:

    export SPARK_CORE_ID=your_code_id
    export SPARK_ACCESS_TOKEN=your_token

You control relays 0 through 3 with 'on' or 'off':

    bin/relay.sh 0 on
    bin/relay.sh 0 off

Heroku setup
============

Push this repo to Heroku by your favorite means, then setup the
environment.

    heroku config:set SPARK_CORE_ID=your_code_id
    heroku config:set SPARK_ACCESS_TOKEN=your_token

You should not check in your access token to your code! Else some
scallywag will start turning things on and off around you.

Now you can run the task as named in the Procfile:

    heroku run relay 0 on

The command to run from the scheduler is of the form `bin/relay.sh N on|off`

Next
====

Now this super simple example works, this project will turn into a
small Sinatra web app to wrangle the sparkcore inputs and outputs.

As there seems to be no API for Heroku Scheduler, it's likley the
'whenever' gem will take that over, which probably means moving
to EC2 (no long lived crontab on Heroku).
