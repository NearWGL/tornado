@CLASS
tables


@read[path]
$result[^table::load[$path;$.encloser["]]]


@write[tbl;path]
$result[^tbl.save[$path;$.encloser["]]]


@item[items;field;id]
$result[^items.select($items.[$field] eq $id)]


@items[path;structure]
^if(-f "$path"){
	$result[^self.read[$path]]
}(def $structure){
	$result[^table::create{$structure}]
	^self.write[$result;$path]
}


@update[path;items;values;id]
^if(def $values && $values is hash){
	^if(def $id && $id){
		$items[^items.select($items.id ne $id)]
	}{
		^items.sort($items.id)[desc]
		$id($items.id + 1)
	}
	^items.append{${id}^values.foreach[;value]{^#09$value}}
	^items.sort($items.id)
	$result[^self.write[$items;$path]]
}{
	^throw[$self.CLASS_NAME;update;Bad command]
}


@delete[path;items;field;id]
$result[^self.write[^items.select($items.[$field] ne $id);$path]]

