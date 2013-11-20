//= require jquery
//= require jquery_ujs
//= require jquery.ui.core
//= require jquery.ui.widget
//= require jquery.ui.mouse
//= require jquery.ui.draggable

var x_list = [];
var $interviewers = [];
var $me = null;
var $whiteboards;
var txt = "";

// interviewer
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
				grid: [10, 10],
				opacity: 0.5,
				scroll: false,
				stop: function(e, ui) {
					// alert(' top: ' + ui.position.top + ' left : ' + ui.position.left);
					// x_list.push(ui.position.top)
					
					// for (var i = 0; i < x_list.length; i++){
					// 	console.log(x_list[i]);
					// }
				}
			});
		$interviewers.push($tmp)
	});
});

var cnt = 0; // click count ('me' button)


// me
$( function() {
	$( '#me' ).click( function(evt) {
		cnt++;
		if (cnt == 1){
			$me = $('<div class = "object"><img src = "/assets/me.png"></div>')
				.dblclick( function() {
					$(this).remove();
					$me = null
					cnt = 0;
				})
				.css("position", "absolute") // important
				.appendTo('div.ui-widget-content')
				.draggable( {
					containment: "#jquery-ui-draggable-wrap",
					grid: [10, 10],
					opacity: 0.5,
					scroll: false
				});
		}});
});

// whiteboard

// clear button
$( function() {
	$( '#clear-button' ).click( function(evt) {
		$("div.ui-widget-content").empty();
		cnt = 0;
		$interviewers = []
		$me = null
		txt = "";
	});
});

// save button
$( function() {
	$( '#save-button' ).click( function(evt) {
		txt = "";
		var parent_left = $("div.ui-widget-content").position().left;
		var parent_top  = $("div.ui-widget-content").position().top;

		// me がなければエラー？
		if ($me != null) {
			txt += "me,"
			txt += ($me.position().top - parent_top).toFixed(1) + ",";
			txt += ($me.position().left - parent_left).toFixed(1);
		}

		for (var i = 0; i < $interviewers.length; i++){
			txt += ",interviewer,";
			txt += ($interviewers[i].position().top - parent_top).toFixed(1) + ",";
			txt += ($interviewers[i].position().left - parent_left).toFixed(1);
		}

		console.log(txt);
		document.getElementById('draw_txt').value = txt
	});
});

// $( function() {
// 	$("div.obj_me")
// 		.dblclick( function() {
// 			$(this).remove();
// 			$me = null
// 			cnt = 0;
// 		})
// 		.css("position", "absolute") // important
// 		.appendTo('div.ui-widget-content')
// 		.draggable( {
// 			containment: "#jquery-ui-draggable-wrap",
// 			grid: [10, 10],
// 			opacity: 0.5,
// 			scroll: false
// 		});
// });