OmertaLogger::Domain.create(
  name: 'com',
  api_url: 'https://barafranca.com/BeO/webroot/index.php?module=API&action=statistics',
  archive_url: 'ftp://archive.omerta.land/com/'
)
OmertaLogger::Domain.create(
  name: 'nl',
  api_url: 'https://barafranca.nl/BeO/webroot/index.php?module=API&action=statistics',
  archive_url: 'ftp://archive.omerta.land/nl/'
)
OmertaLogger::Domain.create(
  name: 'dm',
  api_url: 'https://omerta.dm/BeO/webroot/index.php?module=API&action=statistics',
  archive_url: 'ftp://archive.omerta.land/dm/'
)
OmertaLogger::Domain.create(
  name: 'pt',
  api_url: 'https://omerta.pt/BeO/webroot/index.php?module=API&action=statistics',
  archive_url: 'ftp://archive.omerta.land/pt/'
)
OmertaLogger::Domain.create(
  name: 'tr',
  api_url: 'https://omerta.com.tr/BeO/webroot/index.php?module=API&action=statistics',
  archive_url: 'ftp://archive.omerta.land/gen.tr/'
)
