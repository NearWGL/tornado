@CLASS
filemanager


@makeFileName[ext]

	$result[^math:uid64[]^if(def $ext){.${ext}}]


@makeImageName[ext]

	$result[^math:uid64[].^switch[^ext.lower[]]{
		^case[jpg;jpeg;jpe]{jpg}
		^case[gif;giff]{gif}
		^case[png]{png}
		^case[DEFAULT]{p}
	}]


@safeDelete[fn]

	^if(def $fn && -f "${fn}"){
		$result[^file:delete[$fn]]
	}


@delete[path;src]

	^if(-d "${path}" && def $src){

		$src[^file:justname[^file:basename[$src]]]

		^self.safeDelete[${path}s/${src}.jpg]
		^self.safeDelete[${path}m/${src}.jpg]
		^self.safeDelete[${path}o/${src}.jpg]

		$result[Success]
	}{
		$result[Error: Path does not exists]
	}


@preview[path;src][list]

	^if(-d "${path}" && def $src){

		$src[^file:justname[^file:basename[$src]]]

		^if(-f "${path}o/${src}"){

			^if(^src.left(1) ne "-" ){

				$list[^file:list[${path}o/;^^-.*\.jpg^$]]

				^if($list){

					^list.menu{

						^file:move[${path}o/${list.name};${path}o/^list.name.mid(1)]
						^file:move[${path}m/${list.name};${path}m/^list.name.mid(1)]
						^file:move[${path}s/${list.name};${path}s/^list.name.mid(1)]
					}
				}

				^file:move[${path}o/${src}.jpg;${path}o/-${src}.jpg]
				^file:move[${path}m/${src}.jpg;${path}m/-${src}.jpg]
				^file:move[${path}s/${src}.jpg;${path}s/-${src}.jpg]
			}

			$result[Success]
		}{
			$result[Error: File does not exists]
		}
	}{
		$result[Error: Path does not exists]
	}


@upload[path]

	$result[^self.makeFileName[^file:justext[$form:qqfile]]]

	^if($form:qqfile is "file"){

		$tmp[$form:qqfile]

		^if(def $tmp){

			^tmp.save[binary;${path}${result}]
		}{
			$result[]	
		}

	}(def $form:[qqfile]){

		$tmp[$request:post-body]
		^tmp.save[binary;${path}${result}]
	}{
		$result[]
	}


@resizeImages[convpath;path;src;sizes][converter;options]

	^use[$convpath]
	
	$result[^file:justname[$src].jpg]

	$converter[^nconvert::create[
		$.sScriptPath[/cgi-bin]
		$.sScriptName[nconvert]
	]]
	
	$options[
		$.bKeepRatio(1)
		$.sResizeType[decr]
		$.bRemoveMeta(1)
		$.sFormat[jpg]
		$.iQuality(100)
	]

	^converter.resize[${path}${src};${path}o/${result};$sizes.oW;$sizes.oH;$options]

	^options.delete[bRemoveMeta]

	^if(def $sizes.mW && def $sizes.mH){

		^converter.resize[${path}o/${result};${path}m/${result};$sizes.mW;$sizes.mH;$options]
	}
	
	^if(def $sizes.sW && def $sizes.sH){
		
		^converter.resize[${path}o/${result};${path}s/${result};$sizes.sW;$sizes.sH;$options]
	}
	
	^filemanager:safeDelete[${path}${src}]
