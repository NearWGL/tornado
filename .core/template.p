@main[]
<!DOCTYPE html>
<html lang="ru">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->

    <title>^if($title is junction){^title[] ${config.sep} }Tornado Team</title>
  	<meta name="keywords" content="Tornado energy team" />
  	<meta name="description" content="Сайт о спортивной команде Tornado Energy" />

  	<link rel="shortcut icon" href="/assets/favicon.png" />

  	<base href="//$env:HTTP_HOST/" />


    <!-- Bootstrap --><!-- Latest compiled and minified CSS -->
	 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <link rel="stylesheet" type="text/css" href="${config.css}/font-awesome.min.css" />
  	<link rel="stylesheet" type="text/css" href="${config.css}/slick.css"/>
  	<link rel="stylesheet" type="text/css" href="${config.css}/slick-theme.css"/>


  	<link rel="stylesheet" type="text/css" href="${config.css}/styles.css" />		
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
  </head>

	<body>
		^navbar[]
		^if($header is junction){
			<div class="header" style="background: url('^header[]')"></div>
		}
		^if($content is junction){^content[]}
    ^if(! in "/behind"){^footer[]}

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

	  <script type="text/javascript" src="${config.js}/static/slick.js"></script>

    <script src="/assets/js/common.js"></script>

    ^if($endscripts is junction){^endscripts[]}

	</body>
</html>


@navbar[]   
        <nav class="navbar navbar-custom ^if($env:PATH_INFO eq "/index.html"){navbar-over} navbar-static-top">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                МЕНЮ
              </button>
              <a class="navbar-brand visible-xs" href="$config.url/"><img src="${config.img}/tornado.png"></a>
            </div>
            <div id="navbar" class="navbar-collapse collapse">
              <ul class="nav navbar-nav pull-left">
                <li class="brand hidden-xs"><a href="${config.url}/"><img src="${config.img}/tornado.png"></a></li>
                ^if(in $config.behind){

                }{
	                <li ^if(in "/news.html"){class="active"}><a href="${config.url}/news.html">Новости</a></li>
	                <li ^if(in "/videos.html"){class="active"}><a href="${config.url}/videos.html">Видео</a></li>
	                <li ^if(in "/gallery.html"){class="active"}><a href="${config.url}/gallery.html">Галерея</a></li>
	            }
              </ul>
              <ul class="nav navbar-nav pull-right">
                <li><a href="${config.behind}">Кабинет &nbsp^;   <i class="fa fa-lock"></i></a></li>
              </ul>
            </div>
          </div>
        </nav>





@footer[]

    <div class="footer">
    	<img class="tank-bg hidden-xs hidden-sm" src="/assets/images/bottom-tank.png">
    	<div class="container"><div class="row"><div class="col-lg-4 col-lg-offset-1 col-md-6">
    		<div class="socials text-center">
    			<div class="row">
            <div class="col-xs-6"><a href="https://vk.com/team_tornado_energy"><i class="fa fa-vk fa-3x fa-fh fa-fw"></i>онтакте</a></div>
    				<div class="col-xs-6"><a href="https://www.instagram.com/tornado_energy_team/"><i class="fa fa-instagram fa-3x fa-fw"></i> instagram</a></div>
    			</div>
    			<br>
    			<div class="row">
    				<div class="col-xs-6"><a href="https://www.twitch.tv/near_you/"><i class="fa fa-twitch fa-3x fa-fw"></i> twitch</a></div>
    				<div class="col-xs-6"><a href="https://www.youtube.com/user/alexeykuchkin"><i class="fa fa-youtube fa-3x fa-fw"></i> youtube</a></div>
    			</div>
    			<br>
    			<h4 class="title text-center">Присоединяйся к нам</h4>
    		</div>
	    </div></div></div>
    </div>

