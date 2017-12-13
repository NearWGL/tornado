@auto[filespec]

^use[config.p]

$config.version[13.06]

^if(! in "${config.path}/error.html"){

#	include base classes
	^use[${config.classes}/base.p]
	^use[${config.classes}/tables.p]
	^use[${config.classes}/mysql.p]
	^use[${config.classes}/auth.p]
	^use[${config.classes}/strings.p]


	^use[${config.core}/template.p]
}



@formatDate[date]
$result[^fillZeros[$date.day;2]]
$result[${result}.^fillZeros[$date.month;2]]
$result[${result}.$date.year]
$result[${result} в ^fillZeros[$date.hour;2]]
$result[${result}:^fillZeros[$date.minute;2]]



@fillZeros[str;count]
$str[$str]
$result[]
^for[i](0;$count-^str.length[]-1){$result[${result}0]}
$result[${result}$str]

