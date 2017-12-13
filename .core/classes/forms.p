@CLASS
forms

@form[options;inner]
	$result[<form ^if(def $options && $options is hash){^options.foreach[key;value]{ $key="$value"}} enctype="multipart/form-data">$inner</form>]

^rem{
--------------------------------------------
# disabled, required, minlength, maxlength, 
# autofocus, checked, tabindex, placeholder,
# name, value, id, type
--------------------------------------------
}
@input[options;title]
	$result[^if(def $options && $options is hash){^options.foreach[key;value]{^if($key eq "name"){ id="$value" $key="$value"}($key eq "help"){}{ $key="$value"}}}]
	^switch[$options.type]{
		^case[email;text;password]{$result[<div class="form-group form-group-sm"><label for="$options.name">$title</label><input class="form-control"${result}>^if(def $options.help){<p class="help-block">$options.help</p>}</div>]}
		^case[checkbox;radio]{$result[<div class="form-group form-group-sm"><div class="$options.type"><label for="$options.name"><input${result}> $title</label></div></div>]}
		^case[submit]{$result[<div class="form-group form-group-sm"><input class="btn btn-primary btn-lg" ${result}></div>]}
		^case[hidden;DEFAULT]{$result[<input${result}>]}
	}
	

@textarea[options;_value;title]
	$result[<div class="form-group form-group-sm"><label for="$options.name">$title</label><textarea class="form-control"^if(def $options && $options is hash){^options.foreach[key;value]{^if($key eq "name"){ id="$value" $key="$value"}($key eq "help"){}{ $key="$value"}}}>$_value</textarea></div>]

@select[options][disabled]
	^if(! def $options || ! $options is hash || ! $options){
		^throw[bad.command]
	}
	^if(! def $options.values || ! $options.values is hash){$options.values[^hash::create[]]}
	$options.disabled(false)
	^if(! $options.values){$options.disabled(true)}
	<select class="form-control form-group-sm"^if(def $options.name){ name="$options.name" id="$options.name"}^if($options.disabled && ! def $options.first){ disabled="disabled"}^if(def $options.handle){ $options.handle}>
	^if(^options.contains[first]){
		^if($options.first is hash){<option value="^taint[html][$options.first.value]">$options.first.title</option>}{<option value="^taint[html][$options.first]"></option>}
	}
	^options.values.foreach[value;title]{
		<option value="^taint[html][$value]"^if(def $options.selected && $options.selected eq $value){ selected="selected"}>^taint[html][$title]</option>
	}
	</select>

@hash_tree[parent;level;tree;selected][key;value]
	$tree[^hash::create[$tree]]
	^tree.foreach[key;value]{
		^if($value.[parent] eq $parent){
			<option value="$value.id"^if($value.id eq $selected){ selected="selected"}>^for[](1;$level){&nbsp^;&nbsp^;&nbsp^;&nbsp^;}$value.title</option>
			^self.hash_tree[$value.id;^eval($level+1);$tree;$selected]
		}
	}

@table_tree[parent;level;tree;selected]
	^tree.menu{
		^if($tree.[parent] eq $parent){
			<option value="$tree.id"^if($tree.id eq $selected){ selected="selected">}{>^for[](1;$level){&nbsp^;&nbsp^;&nbsp^;&nbsp^;}}$tree.title</option>
			^self.table_tree[$tree.id;^eval($level+1);$tree;$selected]
		}
	}

@select_tree[input][disabled]
	^if(! def $input || (! $input is hash && ! $input is table) || $input == 0){^throw[bad.command]}
	^if(! def $input.values || ! ($input.values is hash) && ! ($input.values is table)){$input.values[^hash::create[]]}
	$input.disabled(false)
	^if($input.values ==  0){$input.disabled(true)}
	<select class="form-control form-group-sm"^if(def $input.name){ name="$input.name" id="$input.name"}^if($input.disabled && !def $input.first){ disabled="disabled"}^if(def $input.handle){ $input.handle}>
	^if(^input.contains[first]){
		^if($input.first is hash){<option value="^taint[html][$input.first.id]">$input.first.title</option>}{<option value="^taint[html][$input.first]"></option>}
	}
	^if($input.values is hash){^self.hash_tree[0;0;$input.values;$input.selected]}
	^if($input.values is table){^self.table_tree[0;0;$input.values;$input.selected]}
	</select>
