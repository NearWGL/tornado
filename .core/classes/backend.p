@CLASS
backend


@modulesList[auth;path;fname;recursive;allowed][list]
^if(-d "${path}"){
	$result[^table::create{rank	accept	type	name	title	detail	icon}]
	$list[^file:list[${path}]]
	^list.menu{
		^if($list.dir && -f "${path}/${list.name}/${fname}" && (def $allowed || ^auth.isAllowed[$list.name])){
			^result.join[^tables:read[${path}/${list.name}/${fname}]]
			^if(def $recursive){
				^result.join[^self.modulesList[$auth;$path/${list.name}/;$fname;$fullist;$recursive]]
			}
		}
	}
	^result.sort($result.rank)
}{
	^throw[$self.CLASS_NAME;modulesList;Bad path]
}


@modulesPanel[auth;path;fname][list]
$list[^self.modulesList[$auth;$path;$fname;;]]
$result[
<div class="panel panel-default">
	<div class="panel-heading"><h3 class="panel-title"><i class="fa fa-cubes fa-fw"></i> Список модулей</div>
		<div class="panel-body">
			<dl class="dl-horizontal">
				^self.modulesPanelItems[$path;^list.select($list.type eq "base")]
				^self.modulesPanelItems[$path;^list.select($list.type eq "system")]
			</dl>
	</div>
</div>
]


@modulesPanelItems[path;list]
$result[^taint[as-is][^if(def $list){
	^list.menu{
		<dt><a href="${path}/${list.name}/">$list.title</a></dt>
		<dd>$list.detail</dd>
	}
}]]


@checkFormLimit[key][min;max]
^if(! def $key){$key[limit]}
$min(32)
$max(256)
$cookie:[$key](^if(def $form:[$key]){^form:[$key].int($min)}{^cookie:[$key].int($min)})
^if($min > $cookie:[$key]){
	$cookie:[$key]($min)
}($cookie:[$key] > $max){
	$cookie:[$key]($max)
}


@json2hash[value]
^if(def $value){
	$result[^json:parse[^taint[as-is][$value]; $.depth(2) $.double(false) $.distinct[first] ]]
}


@hash2json[values]
^if($values is hash){
	$result[^taint[^json:string[$values; $.skip-unknown(true) ]]]
}{
	^throw[$self.CLASS_NAME;hash2json.values;Bad values]
}


@loadReadme[path]
^if(-f "${path}"){
	$result[^file::load[text;$path]]
	$result[$result.text]
}

