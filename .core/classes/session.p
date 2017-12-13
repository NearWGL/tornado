@CLASS
session

@OPTIONS
static

# input values - hash must include not empty keys: salt, cookey, domains
@auto[]

$self.id(0)
$self.table[`sessions`]
$self.key[SESS]
# Сессия хранится неделю, после становится неактивной
$self.timeout(60 * 60 * 24 * 7)


@get[][item]
$result(0)
^if(def ^cookie:[$self.key].trim[]){
	$result[^mysql:item[
		$.table[$self.table]
		$.columns[id, value, user]
		$.where[ 
			$.value[^cookie:[$self.key].trim[]]
			$.useragent[^self.getUserAgent[]]
			$.closed(0)
			$._raw_[ `updated` > ^eval(^MAIN:config.now.unix-timestamp[] - $self.timeout) ]
		]
	]]
	^if($result){
#		обновляем сессию
		^mysql:update[
			$.table[$self.table]
			$.setvalues[ $.updated[^MAIN:config.now.sql-string[]] ]
			$.where[ $.id($result.id) ]
		]
	}
}


@make[userid][sid]
$sid[^self.makesid[]]
^mysql:update[
	$.table[$self.table]
	$.setvalues[ 
		$.value[$sid]
		$.user($userid)
		$.useragent[^self.getUserAgent[]]
		$.closed(0)
	]
]
$cookie:[$self.key][
	$.value[$sid]
	^if(^env:HTTP_HOST.pos[localhost] == -1){
		$.domain[.${env:HTTP_HOST}]
	}
	$.path[/]
#			только для сервера, на клиенте это не нужно никому (особенно для всяких javascript)
	$.httponly(true)
]
$result[^self.get[]]


@close[sessionid]
^mysql:update[
	$.table[$self.table]
	$.setvalues[ $.closed(1) ]
	$.where[ $.id[$sessionid] ]
]


###
#
@makesid[userid][leftkey;rightkey;total]
$rightkey[^self.crypt[${values.salt} ${userid} ${env:REMOTE_ADDR} ${env:HTTP_X_FORWARDED_FOR} ^self.getUserAgent[]]]
$leftkey[^self.crypt[^math:uuid[]]]
$result[${leftkey}${rightkey}]


@getUserAgent[]
	$result[^if(^env:HTTP_USER_AGENT.length[] > 5){$env:HTTP_USER_AGENT}{^math:uid64[]}]


@crypt[value]
	$result[^math:digest[sha256;$value; $.format[hex] ]]


