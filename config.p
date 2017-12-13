@auto[][tmp]
$SQL.connect-string[mysql://root:@localhost/tornado?charset=utf8]

$config[
# project name
	$.project[WarUniverse]

#	path to project if not in root directory like "public_html"
	$.path[]

#	project domain name
	$.domain[localhost]

#	timeout for chache pages, sql querys and another data
	$.cachetimeout(0)

#	date now, very useful variable
	$.now[^date::now[]]

#	optional variable for  head: title, keywords, description
	$.sep[/]

	$.language[en]

]


$config.url[http://${env:HTTP_HOST}${config.path}]


^config.add[

#	core path
	$.core[${config.path}/.core]

#	assets path
	$.assets[${config.path}/assets]

]


^config.add[

#	session salt
	$.salt[^math:sha1[$config.domain]]

#	cache path
	$.cache[${config.core}/cache]

#	media path
	$.media[${config.path}/media]

#	backend path
	$.behind[${config.url}/behind]

#	css path
	$.css[${config.assets}/css]

#	js path
	$.js[${config.assets}/js]

#	images path
	$.img[${config.assets}/images]


]

^config.add[

#	nullefied out file path
	$.null[${config.core}/null.p]

#	classes path
	$.classes[${config.core}/classes]

	$.userimg[${config.media}/users]

]



$tmp[^request:uri.pos[?]]
^if($tmp == -1){
	$config.request[$request:uri]
	$config.query[]	
}{
	$config.request[^request:uri.left($tmp)]
	$config.query[^request:uri.right(^request:uri.length[] - $tmp)]
}
