# OmertaLogger
[![Dependency Status](https://gemnasium.com/Baelor/omerta_logger.svg)](https://gemnasium.com/Baelor/omerta_logger)
[![Code Climate](https://codeclimate.com/github/Baelor/omerta_logger/badges/gpa.svg)](https://codeclimate.com/github/Baelor/omerta_logger)

Provides a logger for the MMORPG [Omerta](http://barafranca.com) as a mountable Rails engine.


At the moment, the following entities are logged:
 * Users
  * Including Rank History and Family History
 * Families


## Usage

 * Mount this app as an engine in your rails app or use the dummy app in test/dummy.
 * Create a new version with `rake version:new['1.0']`. This will create a new version called 1.0 for the default domain (.com).

 To create a new version for a different domain with a specific start date, use `rake version:new['1.0','nl','2014-08-25 11:00:00']`.
 * Execute the import with `rake import`.
