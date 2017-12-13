@CLASS
translit

# It converts Russian Cyrillic letters to Latin characters
@ru2en[s]

$s[^s.lower[]]
$s[^s.trim[]]

# $s[^if(def $s){^s.replace[^table::create[nameless]{^taint[^#0A]^#09^#20}]}]
$s[^s.match[\s+|\f|\n|\r|\t+|\v][gi]{ }]

$s[^s.replace[^table::create[nameless]{Ґ	G
Ё	YO
Є	E
Ї	YI
І	I
і	i
ґ	g
№	N
є	e
ї	yi
а	a
б	b
в	v
г	g
д	d
е	e
ё	yo
ж	zh
з	z
и	i
й	y
к	k
л	l
м	m
н	n
о	o
п	p
р	r
с	s
т	t
у	u
ф	f
х	kh
ц	ts
ч	ch
ш	sh
щ	shch
ь	
ъ	
ы	yi
э	e
ю	yu
я	ya
 	-}
]]
$result[^s.match[^[^^a-z0-9_.-^]][g]{}]
