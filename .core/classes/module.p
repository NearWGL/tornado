@CLASS
module


# tablename[mysql-table-name]
# path[${config.cache}/${strings.language}.${self.name}.p]
# images[$config.media/${self.tablename}/]
# item[`id`,`...`,`title`,`brief`,`content`,`seot`,`seok`,`seod`,`...`]
# items[`id`,`...`,`title`,`...`]
@create[filespec;infopath;type][filespec]
$filespec[^filespec.replace[$request:document-root;]]
$module:processing(1)
$module:url[^file:dirname[$filespec]/]
^self.add[^self.loadInfo[${self.url};$infopath]]


# accept(0/1)	rank(0/1)	name[mname]	title[Title]	type[base/system]	detail[about information]
@loadInfo[path;infopath][tmp]
^if(-f "${path}${infopath}"){
	$result[^tables:read[${path}${infopath}]]
	$result[$result.fields]
}{
	^throw[$self.CLASS_NAME;loadInfo;Path '${path}${infopath}' does not exists]
}


@add[values;pref]
^if(def $values && $values is hash){
	^values.foreach[key;value]{
		$module:[${pref}${key}][$value]
	}
}{
	^throw[$self.CLASS_NAME;add.values;Bad variable values]
}

