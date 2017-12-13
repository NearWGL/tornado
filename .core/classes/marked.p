@CLASS
marked


@create[data]
<div class="form-group">
	<label for="content">Описание</label>
	<div class="btn-toolbar marked-bar">
		<div class="btn-group">
			<button id="show-marked" type="button" tabindex="-1" class="btn btn-link" tag="show" rel="tooltip" title="Show/Edit marked text (⌘-X)"><i class="fa fa-fw fa-code"></i></button>
		</div>
		<div class="btn-group">
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="bold" rel="tooltip" title="Bold (⌘-B)"><i class="fa fa-fw fa-bold"></i></button>
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="italic" rel="tooltip" title="Italic (⌘-I)"><i class="fa fa-fw fa-italic"></i></button>
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="strikethrough" rel="tooltip" title="Strikethrough (ALT-SHIFT-5)"><i class="fa fa-fw fa-strikethrough"></i></button>
		</div>
		<div class="btn-group">
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="title-1" rel="tooltip" title="Heading 1 (⌘-ALT-1)">H1</button>
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="title-2" rel="tooltip" title="Heading 2 (⌘-ALT-2)">H2</button>
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="title-3" rel="tooltip" title="Heading 3 (⌘-ALT-3)">H3</button>
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="title-4" rel="tooltip" title="Heading 4 (⌘-ALT-4)">H4</button>
		</div>
		<div class="btn-group">
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="list-ul" rel="tooltip" title="Numbered List (⌘-ALT-7)"><i class="fa fa-fw fa-list-ul"></i></button>
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="list-ol" rel="tooltip" title="Bulleted List (⌘-ALT-8)"><i class="fa fa-fw fa-list-ol"></i></button>
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="table" rel="tooltip" title="Insert Table"><i class="fa fa-fw fa-table"></i></button>
		</div>
		<div class="btn-group">
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="link" rel="tooltip" title="Insert Link (⌘-K)"><i class="fa fa-fw fa-chain"></i></button>
#			<button type="button" tabindex="-1" class="btn btn-link marked" tag="code" rel="tooltip" title="Code (⌘-ALT-9)"><i class="fa fa-fw fa-code"></i></button>
		</div>
		<div class="btn-group">
			<button type="button" tabindex="-1" class="btn btn-link marked" tag="image" rel="tooltip" title="Insert Picture"><i class="fa fa-fw fa-picture-o"></i></button>
		</div>
	</div>
	<textarea id="markedin" name="marked" class="form-control" rows="15" placeholder="описание">$data</textarea>
#	<div class="panel-footer">Для просмотра результата нажмите команду CTRL + S (на Win) or CMD &#8984^; + S (на Mac)</div>
	<div id="markedout" class="well" style="display:none"></div>
</div>
