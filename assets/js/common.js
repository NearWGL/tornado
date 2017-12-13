

$(document).ready(function() {

	initVideos();

	resizeVideos();

	$('#expand-team').click(function(e) {
		e.preventDefault();
		$(".team .teammate").addClass("expand");
		$(".team .teammate .country").show(400);
		$(this).hide();
	});
});


/* init videos */

$( window ).resize(function() {
	resizeVideos();
});

function resizeVideos() {
  var width = $(".fs-video-wrap").width()
  var height = width / 16 * 9;
  var vHeight = $(window).height();
  if (height > vHeight * 7 / 10) {
  	height = vHeight * 7 / 10;  
  	width = height / 9 * 16;	
  }
  $(".fs-video").css('width', width);
  $(".fs-video").css('height', height);	
}

function initVideos() {
	$('#fs-videos').slick({
		slidesToShow: 1,
		slidesToScroll: 1,
		arrows: false,
		fade: true,
		asNavFor: '#video-previews'
	}).on('beforeChange', function(event, slick, currentSlide, nextSlide){
		console.log(currentSlide);
	    $('*[data-slick-index='+currentSlide+"]").find('iframe').each(function() {
	    	var leg = $(this).attr("src");
	    	$(this).attr("src",leg);
	    });
	});;
	$('#video-previews').slick({
		slidesToShow: 3,
		slidesToScroll: 1,
		asNavFor: '#fs-videos',
		dots: true,
		centerMode: true,
		focusOnSelect: true
	})
}