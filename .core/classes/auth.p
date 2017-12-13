@CLASS
auth

@OPTIONS
static


###
#
@auto[]
$self.table[`users`]
$self.user(0)

# Получаем id пользователя из cookie сессии
^use[${MAIN:config.classes}/session.p]
$self.session[^session:get[]]

^if($self.session){
#	Если сессия существует то подгружаем пользователя из бд	
	$self.user[^getUser[$self.session.user]]
#	Если пользователь не отключен загружаем его данные
	^if($self.user){$self.user[$self.user.fields]}
#	В случаях если пользователя не удалось получить isAuthorized всё равно будет выдавать 0
}


###
#
@isAuthorized[]
$result(^if($self.user){1}{0})


###
#
@isAllowed[modulename]
# by default return zero
$result(0)
^if(^self.isAuthorized[]){
#	grant access for root user
	^if($self.ROOTUSER == $self.user.id){
		$result($self.ACCESSWRITE)
#	return real access from user access rules hash
	}($self.user.rules && ^self.user.rules.contains[$modulenamknivesrussiae]){

		$result($self.user.rules.[$modulename])
	}
}


@signin[args][values;targetUser]
$result(0)
# иногда чистим хэш, перебираются все пары и удаляются устаревшие
^if(^self.signinAllowed[]){
	^if(def $args){$values[$args]}{
		$values[
			$.email[^form:email.trim[]]
			$.password[^auth:makePassword[$form:password]]
		]
	}
	$targetUser[^mysql:item[ 
			$.table[$self.table] $.columns[id] 
			$.where[ $values ] 
	]]
	^if($targetUser){
		$cookie:[email][$values.[email]]
		$self.user[^getUser[$targetUser.id]]
		$self.session[^session:make[$targetUser.id]]
		$result(1)
	}
}


###
# 
@signup[args][values;us]
$result[
	$.success(0)
]
^if(def $args){$values[$args]}{
	$values[
		$.email[^form:email.trim[]]
		$.name[$form:name]
		$.password1[^form:password1.trim[]]
		$.password2[^form:password2.trim[]]
	]
}
$us[^mysql:item[$.table[$self.table] $.where[$.email[$values.email]] ]]
^if(! $us && def $values.email && ^values.email.pos[@] && ^values.email.pos[.]
	&& ^auth:emailAvailable[$values.email]
	&& ^values.name.length[] >= 5
	&& ^values.password1.length[] >= 6 && ^values.password1.length[] <= 20
	&& $values.password1 eq $values.password2
	){

	^values.add[
		$.password[^auth:makePassword[$form:password1]]
		$.created[^MAIN:config.now.sql-string[]]
	]
	^values.delete[password1]
	^values.delete[password2]

	$result.confirmation[$values.confirmation]
	$result.name[$values.name]
	$result.email[$values.email]
	
	^mysql:update[
		$.table[$self.table]
		$.setvalues[$values]
	]
	$result.success(1)
}


###
#
@signout[]
^if(^self.isAuthorized[]){
	^session:close[$self.session.id]
}



##
#
@confirm[][values;user]
$result(0)
$values[
	$.confirmation[^form:confirmation.trim[]]
	$.confirmed(0)
]
$user[^mysql:item[$.table[users] $.where[$values] ]]
^if($user){
	^mysql:update[ $.table[$self.table] $.setvalues[ $.confirmed(1) ] $.where[$.id($user.id)]]
	$result(1)
}




###
#
@saveAttempt[][count]
$count(^self.attempts.[^math:md5[$env:REMOTE_ADDR]].int(0))
^count.inc[]
$self.attempts.[^math:md5[$env:REMOTE_ADDR]][
	$.value($count)
	$.expires(1/24/6)
]

###
#
@signinAllowed[]
$result(^if(! ^isAuthorized[]){1}{0})


###
#
@getUser[id]
$result[^mysql:item[
	$.table[$self.table]
	$.where[ $.id($id) $.rm(0) ]
]]


###
# Возвращает пароль преобразованный в хеш
# Длина 256 символов
@makePassword[pass]
$result[^math:digest[sha256;${pass}${config.salt}]]


###
# Код подтверждения при регистрации
@makeConfirmCode[]
$result[^math:uuid[]^math:uuid[]]


###
# 1 - если не занят и 0 наоборот
@emailAvailable[email]
$result(^if(^mysql:item[ 
		$.table[$self.table] 
		$.where[ $.email[$email] ]
]){0}{1})