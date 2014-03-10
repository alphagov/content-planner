Content Planner
========================

A tool to help with the HMRC Content transition and URL analysis.

This application requires:

* Ruby version 2.0.0-p353
* Rails version 4.0.2

And depends on or uses the following parts of the GOV.UK stack:

* https://github.com/alphagov/govuk_need_api (needs)
* https://github.com/alphagov/whitehall (organisations)

Loosely related:

* https://github.com/alphagov/maslow
* https://github.com/alphagov/transition


Development
-----------

* Template Engine: Slim
* Testing Framework: RSpec and Factory Girl
* Front-end Framework: Twitter Bootstrap (Sass)
* Form Builder: SimpleForm

Running the application
---------------------

Ensure you have replicated the databases from preview (maslow, whitehall and content-planner).

  ```
  bowl content-planner
  ```

Alternatively run whitehall and govuk_need_api then run `./startup.sh`

Emails in development
---------------------

It delivers emails to [mailcatcher](http://mailcatcher.me/) when in development.

1. Install mailcatcher: `gem install mailcatcher`

2. Inside VM: `mailcatcher --http-ip 10.1.1.254`

3. From your host machine go to http://10.1.1.254:1080

Style and syntax checking
-------------------------

    bundle exec rubocop