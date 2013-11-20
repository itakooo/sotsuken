//= require jquery
//= require jquery_ujs
//= require jquery.ui.core
//= require jquery.ui.widget
//= require jquery.ui.mouse
//= require jquery.ui.draggable

$interviewers = []

// function loadObj() {
// 	console.log("hoge")
// 	$me = $( '#obj_me' )
// 	var offset = $('#obj_me').offset
// 	console.log(offset.top)
	
// 	$me.dblclick( function() {
// 		$(this).remove();
// 		$interviewers.splice($interviewers.length - 1, 1);
// 	})
// 	.css("position", "absolute") // important
// 	.css("top", offset.top)
// 	.appendTo('div.ui-widget-content')
// 	.draggable( {
// 		containment: "#jquery-ui-draggable-wrap",
// 		grid: [25, 25],
// 		opacity: 0.5,
// 		scroll: false,
// 	})
// };

var $me;

// window.onload = loadObj

$( function() {
	$(document).on("ready", function(){
		$me = $( '#obj_me' );
		var offset = $('#obj_me').offset
		console.log(offset.top)
		$me.dblclick( function() {
			$(this).remove();
				$interviewers.splice($interviewers.length - 1, 1);
			})
			.css("position", "absolute") // important
		    .css("top", offset.top)
			.appendTo('div.ui-widget-content')
			.draggable( {
				containment: "#jquery-ui-draggable-wrap",
				grid: [25, 25],
				opacity: 0.5,
				scroll: false,
			});
		

		$( '#obj_interviewer' )
			.dblclick( function() {
				$(this).remove();
				$interviewers.splice($interviewers.length - 1, 1);
			})
			.css("position", "absolute") // important
			.appendTo('div.ui-widget-content')
			.draggable( {
				containment: "#jquery-ui-draggable-wrap",
				grid: [25, 25],
				opacity: 0.5,
				scroll: false,
			});
});

$( function() {
	$( '#interviewer' ).click( function(evt) {
		var $tmp = $('<div class = "object"><img src = "/assets/interviewer.png" ></div>')
			.dblclick( function() {
				$(this).remove();
				$interviewers.splice($interviewers.length - 1, 1);
			})
			.css("position", "absolute") // important
			.appendTo('div.ui-widget-content')
			.draggable( {
				containment: "#jquery-ui-draggable-wrap",
				grid: [25, 25],
				opacity: 0.3,
				scroll: false,
				stop: function(e, ui) {
				}
			});
		$interviewers.push($tmp)
	});
});
