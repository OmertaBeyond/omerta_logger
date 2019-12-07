# OmertaLogger
[![Build Status](https://travis-ci.org/Baelor/omerta_logger.svg?branch=master)](https://travis-ci.org/Baelor/omerta_logger)
[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=Baelor/omerta_logger)](https://dependabot.com)
[![Code Climate](https://codeclimate.com/github/Baelor/omerta_logger/badges/gpa.svg)](https://codeclimate.com/github/Baelor/omerta_logger)

Provides a highly configurable logger for the MMORPG [Omerta](http://barafranca.com) as a mountable Rails engine.


At the moment, the following entities are logged:

 * Users, including
  * Family history
  * Rank History
  * Online Time History
  * Revives
  * Renames
 * Families, including
  * Renames
  * Bank history
  * Position history
  * User count history
  * Worth history
 * Business Objects, including
  * Casinos
   * Max. bet
  * Bullet factories
   * Bullet amount and price
 * Hitlistings
 * Game and Economy Statistics



## Usage

### Testing
This project includes a dummy application in `test/dummy` which can be used for testing and development.
Make sure you have installed all dependencies by running `bundle install` from the root path first.

Copy `test/dummy/config/initializers/omerta_logger.rb.example` to `test/dummy/config/initializers/omerta_logger.rb`.
This file allows you to change configuration options like which domains and entities should be imported.

Next, `cd` to `test/dummy` and run `rake db:migrate` to generate the database schema. By default, the dummy application
will use sqlite. Use `rake db:seed` to seed the database with all Omerta versions including their API URLs.

Finally, use `rake import` to import the current XML feed for all domains and entities specified in the configuration.

The `import` task can also be run as a permanent process (think: daemon mode, but in the foreground). To do this, pass `true` as the first task argument:

`rake import[true]`

### Production
For production usage, you should mount this app as an engine in your rails app. If you don't have an existing rails app, run `rails new foobar`, where `foobar` is your app name. Make sure you are using the rails version defined in `omerta_logger.gemspec`. Rails will create a new folder `foobar`. Next, add the following line to your Gemfile:

`gem 'omerta_logger', git: "https://github.com/Baelor/omerta_logger.git"`

Run `bundle install` to install the engine. Grab a copy of `test/dummy/config/initializers/omerta_logger.rb.example`
from this repository and put it in your apps `config/initializers/` folder as `omerta_logger.rb`.

Next, copy the migrations with `rake omerta_logger:install:migrations` and run them with `rake db:migrate`.

In order to seed the database with all Omerta versions, edit `db/seeds.rb` and append the following line:

`OmertaLogger::Engine.load_seed`

Now, run `rake db:seed` to seed the database.

Finally, you can start your first import with `rake import` to verify everything's set up correctly. Check `log/development.log` to see the results. In production, you will probably want to run the import in daemon mode with `rake import[true]`.

There are various ways to use this engine:
 * If you're working on a rails app, you can use or extend the models this project provides.
 * The engine also includes a read-only REST API. To enable it, edit `config/routes.rb` and replace it with the following lines:
```ruby
Rails.application.routes.draw do
  mount OmertaLogger::Engine => "/"
end
```
  This will mount the engine at the root path (`/`, of course you may use any path).
  OmertaBeyond provides a hosted version of this API at https://api.omertabeyond.net/
 * Alternatively, it's possible to access the database tables used by this project directly from within any other project. However, the database schema might change in the future, so make sure you check whether you're affected by any migrations before upgrading this engine.
