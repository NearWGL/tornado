@CLASS
geo

$name[Геолокация]

# Геолокация
@initGeo[table;value;default][geo]
$result(^value.int(0))
^if($table is table && $table){
	^if(! $result || ! ^table.locate[id;$result]){
		^try{
			$geo[^file::load[text;http://ipgeobase.ru:7020/geo?ip=$env:REMOTE_ADDR; $.timeout(5) $.charset[windows-1251] ]]
			$geo[$geo.text]
			^if(def $geo && ^geo.pos[Incorrect request] < 0 && ^geo.pos[Not found] < 0){
				$geo[^geo.mid(^eval(^geo.pos[<region>] + 8))]
				$region[^geo.mid(0;^geo.pos[</region>])]
				^if(def $region && ^table.locate[geoip;$region]){
					$result($table.id)
				}{
					$result($default)
				}
			}{
				$result($default)
			}
		}{
			$exception.handled(1)
			$result($default)
		}
	}
}{
	$result($default)
}
