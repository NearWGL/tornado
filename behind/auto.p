@auto[]


^if(! ^auth:isAuthorized[]){
	^base:location[/signin.html]
}{
	$behind[
		$.url[$config.urls.behind]
		$.path[/behind]
	]

	^behind.add[
		$.assets[$behind.path/assets]
		$.core[$behind.path/.core]
	]
}


@content[]

<div class="container admin-panel">
	<div class="row">
		<div class="col-sm-3">

			<div class="panel panel-default">
				<div class="panel-heading">Навигация</div>
				<div class="panel-body">
					<ul class="nav nav-pills nav-stacked">
						<li ^if($config.request eq "/behind/"){class="active"}><a href="${config.behind}">Главная</a></li>
						^if($auth:user.admin){
							<hr>
							<li ^if(in "/behind/news.html"){class="active"}><a href="${config.behind}/news.html">Новости</a></li>
							<li ^if(in "/behind/videos.html"){class="active"}><a href="${config.behind}/videos.html">Видео</a></li>
							<li ^if(in "/behind/gallery.html"){class="active"}><a href="${config.behind}/gallery.html">Галерея</a></li>
							<hr>
							<li ^if(in "/behind/users.html"){class="active"}><a href="${config.behind}/users.html">Пользователи</a></li>
							<li ^if(in "/behind/settings.html"){class="active"}><a href="${config.behind}/settings.html">Настройки</a></li>
						}
						<hr>
						<li><a href="$config.url/signout.html">Выход</a></li>
					</ul>
				</div>
			</div>

			<h5 class="text-center muted">Вы вошли как <code>$auth:user.name</code></h5>
		</div>
		<div class="col-sm-9">

			^if($moduleContent is junction){^moduleContent[]}

		</div>
	</div>
</div>


@checkValues[values]
$result(1)
^if($values is hash && $values){
	^values.foreach[k;v]{
		^if( ($v is int && ! $v) || ($v is string && ! def $v) ){
			$result(0)
			^break[]
		}
	}
}



