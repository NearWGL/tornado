@CLASS
pagination


@create[url;ptotal;current;varname;class;total;offset][href;interval;left;right]
^if(! def $varname){
	$varname[offset]
}
^if($ptotal < 1){
	$ptotal(1)
}
$interval[
	$.start(^math:ceiling(^if($current > 5){^self.max[^self.min[^eval($current - 5);^eval($ptotal - 10)];1]}{1}))
	$.end(^math:ceiling(^if($current > 5){^self.min[^eval($current + 5);$ptotal]}{^self.min[10;$ptotal]}))
]

$href[${url}^if(^url.pos[?] > 0){&}{?}${varname}=]

$result[^if($ptotal != 1){
	^if($current == 1){
		$left[<li class="disabled"><a><span aria-hidden="true">&larr^;</span></a></li>]
		$right[<li><a href="${href}^eval($current+1)"><span aria-hidden="true">&rarr^;</span></a></li>]
	}($current == $ptotal){
		$left[<li><a href="${href}^eval($current-1)"><span aria-hidden="true">&larr^;</span></a></li>]
		$right[<li class="disabled"><a><span aria-hidden="true">&rarr^;</span></a></li>]
	}{
		$left[<li><a href="${href}^eval($current-1)"><span aria-hidden="true">&larr^;</span></a></li>]
		$right[<li><a href="${href}^eval($current+1)"><span aria-hidden="true">&rarr^;</span></a></li>]
	}

# displayed pages 10, half 5
	<ul class="pagination $class">
		$left
		^if($interval.start > 1){
			<li><a href="${href}1">1</a></li>
			^if(^eval($interval.start - 1) != 1){<li class="disabled"><span class="ellipse">&hellip^;</span></li>}
		}
		^for[i]($interval.start;$interval.end){
			^if($i == $current){
				<li class="active"><a href="${href}${i}#">$i <span class="sr-only">(current)</span></a></li>
			}{
				<li><a href="${href}${i}">$i</a></li>
			}
		}
		^if($interval.end < $ptotal){
			^if(^eval($interval.end + 1) < $ptotal){<li class="disabled"><span class="ellipse">&hellip^;</span></li>}
			<li><a href="${href}$ptotal">$ptotal</a></li>
		}
		$right
		<li class=disabled><a>Записи ^eval($offset+1) - ^if($offset+$cookie:[limit] > $total){$total}{^eval($offset+$cookie:[limit])} из $total</a></li>
	</ul>
}]


@min[num1;num2]
$result(^if($num1 < $num2){$num1}{$num2})


@max[num1;num2]
$result(^if($num1 > $num2){$num1}{$num2})
