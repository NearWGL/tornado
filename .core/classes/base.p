@CLASS
base


@location[url;status]
#$response:location[^if(def $url){$url}{http://${env:HTTP_HOST}${config.path}/error.html}]
$response:location[^if(def $url){$url}{${config.path}/error.html}]
^if($status is int && $status){$response:status[$status]}
^use[$caller.config.null]


@language[config][l]
	$result[^table::create{id	title
ar	العربيه
cn	中文
en	English
es	Español
fr	Français
pt	Português
ru	Русский
}]
#^switch[$env:HTTP_HOST]{
#	^case[en.$config.domain]{$config.language[en]}
#	^case[$domain;DEFAULT]{}
#}
^if(def $cookie:[language] && ^result.locate[id;$cookie:[language]]){
	$config.language[$result.id]
}(^result.locate[id;$config.language]){
	$cookie:[language][$result.id]
}
