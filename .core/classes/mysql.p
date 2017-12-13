@CLASS
mysql


# transform conditions from hash to string
@conditions[do;delimiter;values]
$result[^if($values is hash){
	$do ^values.foreach[key;value]{
		^if($key eq "_raw_"){
			^taint[as-is][$value]
		}($key eq "_in_" && $value is hash){
			$value.name IN($value.value)
		}{
			$key='$value'
		}
	}[$delimiter]
}]


# get count of items
@count[values]
^if($values is hash){
	^connect[$MAIN:SQL.connect-string]{
		$result[^string:sql{SELECT COUNT($values.column) AS count FROM $values.table ^self.conditions[WHERE; AND ;$values.where]}[$.limit(1)]]
	}
}


# get one item
@item[values]
^if($values is hash){
	$values.limit(1)
	$values.offset(0)
	$result[^self.items[$values]]
}


# get some items
@items[values]
^if($values is hash){
	^connect[$MAIN:SQL.connect-string]{
		$result[
			^table::sql{
				SELECT ^if(def $values.columns){$values.columns}{*}
				FROM $values.table
				^self.conditions[WHERE; AND ;$values.where]
				^if(def $values.group){GROUP BY $values.group}
				^if(def $values.sort){ORDER BY ${values.sort}^if(def $values.order){ $values.order}}
			}[
				^if(def $values.limit){$.limit($values.limit)}
				^if(def $values.offset){$.offset($values.offset)}
			]
		]
	}
}


@update[values][columns]
^if($values is hash){
	^connect[$MAIN:SQL.connect-string]{
		^self.lock[$values.table]
		^void:sql{
			^if($values.setvalues is hash){
				^if(def $values.where && $values.where is hash && $values.where){
					UPDATE $values.table ^self.conditions[SET;,;$values.setvalues] ^self.conditions[WHERE; AND ;$values.where]
				}{
					INSERT INTO $values.table ^self.conditions[SET;,;$values.setvalues]
				}
			}($values.setvalues is table){
				$columns[^values.setvalues.columns[]]
				INSERT INTO $values.table (^columns.menu{$columns.column}[,]) VALUES ^values.setvalues.menu{(^columns.menu{'$values.setvalues.[$columns.column]'}[,])}[,]
			}
		}
		^self.lock[]
	}
}


@delete[values]
^if($values is hash){
	^connect[$MAIN:SQL.connect-string]{
		^self.lock[$values.table]
		^void:sql{DELETE FROM $values.table ^self.conditions[WHERE; AND ;$values.where]}
		^self.lock[]
	}
}


@lock[name]
^void:sql{^if(def $name){LOCK TABLE $name WRITE}{UNLOCK TABLES}}


@tableIsExists[table][tmp]
$tmp[^connect[$MAIN:SQL.connect-string]{
	^table::sql{SHOW TABLES LIKE '$table'}
}]
$result(^if(def $tmp){1}{0})


###Создание таблиц###
@createTable[table;values]
^if(def $table || def $values){
	^connect[$MAIN:SQL.connect-string]{
		^void:sql{
			CREATE TABLE $table (
			^values.foreach[key;value]{ $key $value}[,]
			)
		}
	}
}
^rem{ Пример вызова:
	$values[ 
		$.id[ INT(8) NOT NULL]
		$.name[ TEXT default 'ss' ]
	]
	^createTable[users;$values]
}
#################



