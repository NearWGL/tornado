@CLASS
currency

$name[Курсы валют]

# Курсы валют 
@initCurrency[path][cbr;usd;eur]
$result[^hashfile::open[$path]]
^if($result is hash && def $result.usd && def $result.eur){
	
}{
	^try{
		$cbr[^file::load[text;http://www.cbr.ru/scripts/xml_daily.asp; $.timeout(2) $.any-status(true) ]]
		^if($cbr.status eq "200"){
			$cbr[^xdoc::create{^untaint{$cbr.text}}]
			^cbr.selectString[string(/ValCurs/@Date)]
			$usd[^cbr.selectSingle[/ValCurs/Valute[CharCode='USD']]]
			$eur[^cbr.selectSingle[/ValCurs/Valute[CharCode='EUR']]]
			$result.usd[ $.value[^usd.selectString[string(Value)]] $.expires(1) ]
			$result.eur[ $.value[^eur.selectString[string(Value)]] $.expires(1) ]
			^result.release[]
			
			$cbr[^hashfile::open[${path}.backup]]
			$cbr.usd[ $.value[$result.usd] $.expires(0) ]
			$cbr.eur[ $.value[$result.eur] $.expires(0) ]
			^cbr.release[]
		}{
			$cbr[^hashfile::open[${path}.backup]]
			^if($cbr is hash && def $cbr.usd && def $cbr.eur){
				$result[^cbr.hash[]]
			}
		}
	}{
		$cbr[^hashfile::open[${path}.backup]]
		^if($cbr is hash && def $cbr.usd && def $cbr.eur){
			$result[^cbr.hash[]]
		}
		$exception.handled(1)
	}
}
