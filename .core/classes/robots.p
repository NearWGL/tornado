@CLASS
robots

$name[robots.txt]

@header[]
^# Please see http://www.robotstxt.org/wc/norobots.html for and more information on how to use this file
User-agent: *
Disallow: /administrator/
Disallow: /search/
Disallow: /system/
Disallow: /tmp/
Sitemap: http://$config.domain/sitemap.xml
