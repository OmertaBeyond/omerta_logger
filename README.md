# OmertaLogger
[![Dependency Status](https://gemnasium.com/Baelor/omerta_logger.svg)](https://gemnasium.com/Baelor/omerta_logger)
[![Code Climate](https://codeclimate.com/github/Baelor/omerta_logger/badges/gpa.svg)](https://codeclimate.com/github/Baelor/omerta_logger)

Provides a logger for the MMORPG [Omerta](http://barafranca.com) as a mountable Rails engine.


At the moment, the following entities are logged:
 * Users
  * Including Rank History, Family History and Deaths
 * Families


## Usage

 * Mount this app as an engine in your rails app or use the dummy app in test/dummy.
 * Execute the import with `rake import`. Use `rake import[version_name]` to import versions other than com (e.g. `rake import[nl]`)
