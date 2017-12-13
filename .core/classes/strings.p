@CLASS
S

@OPTIONS
static


@auto[][path]
$path[${MAIN:config.core}/languages/strings.en.p]
^if(-f $path){
	$self.default[^tables:read[$path]]	
}
^if($MAIN:config.language eq "en"){
	$self.lang[$self.default]
}{
	$path[${MAIN:config.core}/languages/strings.${MAIN:config.language}.p]
	^if(-f $path){
		$self.lang[^tables:read[$path]]	
	}{
		$self.lang[$self.default]
	}
}


@getr[key]
$result[^untaint{^get[$key]}]


@get[key][val]
$val[^_get[$self.lang;$key]]
^if(! def $val){$val[^_get[$self.default;$key]]}
^if(! def $val){$val[]}

$result[$val]



@_get[src;key]
$result[]
^if(^src.locate[key;$key]){$result[$src.value]}








@month[id][month]
	
	$month[
		$.1[января]
		$.2[февраля]
		$.3[марта]
		$.4[апреля]
		$.5[мая]
		$.6[июня]
		$.7[июля]
		$.8[августа]
		$.9[сентября]
		$.10[октября]
		$.11[ноября]
		$.12[декабря]
	]
	$result[$month.[$id]]






