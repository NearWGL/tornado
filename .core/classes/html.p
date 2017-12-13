@CLASS
html


@tableHead[data]
$result[<thead><tr>^data.menu{<th width="${data.width}%"><abbr title="${data.abbr}">${data.title}</abbr></th>}</tr></thead>]


@tableNoItems[columns]
$result[<tr><td colspan="${columns}">пусто</td></tr>]


@table[content]
$result[<div class="table-responsive"><table class="table table-bordered table-condensed table-striped table-hover">$content</table></div><hr/>]


@newItem[url;icon;total;back]
$result[<div class="form-group clearfix">
^if(def $url){<a href="${url}do.html?do=create^if(def $back){&$back}" title="Создать новую запись" class="btn btn-success"><i class="fa $icon fa-lg"></i>&nbsp^;&nbsp^;Новая запись</a>}
<span class="pull-right">^self.countItems[$total]</span>
</div>]


@countItems[total]
$result[<kbd>$total</kbd> записей]


@backUrl[url]
$result[<p><a href="${url}"><i class="fa fa-level-down fa-fw fa-rotate-180"></i>Наверх</a></p>]


@accessAbbr[var]
$result[<sup><small><code><abbr title="Доступ: R-чтение, W-запись">^if($var == 2){RW}{R}</abbr></code></small></sup>]


@ends[i]
$result[^if($i == 1){ь}($i > 1 && $i < 5){и}{ей}]


@fileUploader[max;upath;images;id][list]
$result[<div class="panel panel-default">
	<div class="panel-heading">
		<h3 class="panel-title">Файлы</h3>
	</div>
	<div class="panel-body">
		<p>Вы можете загрузить не более $max файлов в формате <code>JPG</code>. Файл не может быть размером более 3Мб.</p>
		<p><div id="file-uploader"><noscript><p>Please install the Flash Plugin and Please enable JavaScript to use file uploader.</p></noscript></div></p>
		<div id="item-files">
			$list[^file:list[${images}${id}/m/;\.jpg^$]]
			^if($list){<script>^list.menu{addPhoto(^{"path":"${images}${id}/","src":"${list.name}"^}, ${id}, true)^;}</script>}
		</div>
		<script>
			var uploaderpath = '${upath}'^;
			window.onload = function (event) ^{createPhotoUploader(${id}, uploaderpath + '?do=upload&max=${max}&id=', 'file-uploader', true)^}
		</script>
	</div>
</div>]


@selectLimmits[]
<label for="limit">Выводить по</label>
^forms:select[
	$.name[limit]
	$.values[
		$.32[32 записей]
		$.64[64 записей]
		$.128[128 записей]
		$.256[256 записей]
	]
	$.selected[$cookie:[limit]]
	$.handle[id="limit" onchange="this.form.submit()"]
]

