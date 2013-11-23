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
var $stickies = [];

// 面接官ボタン
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
				opacity: 0.5,
				scroll: false,
			});
		$interviewers.push($tmp)
	});
});

var cnt = 0; // 自分カウンタ


// 自分ボタン
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
					grid: [25, 25],
					opacity: 0.5,
					scroll: false
				});
		}});
});

// メモボタン
$( function() {
	$( '#addtext' ).click( function(evt) {
		var txt = ""
		var $tmp = $('<div class = "sticky">メモを入力してください</div>')
			.dblclick( function() {
				$(this).wrapInner('<textarea  maxlength="25"></textarea>')
					.find('textarea')
					.focus()
					.select()
					.blur( function() {
						if ($(this).val() == ""){
							$(this).remove();
							console.log("removed");
						} else {
							$(this).parent().html($(this).val())
							console.log($(this).val())
						}
					})
			})
			.css("position", "absolute")
			.appendTo('div.ui-widget-content')
			.draggable( {
				containment: "#jquery-ui-draggable-wrap",
				grid: [25, 25],
				opacity: 0.5,
				scroll: false
			});
		$stickies.push($tmp)
	});
});



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
		// offsetで相対位置取得
		var parent = $("div.ui-widget-content").offset()

		// me がなければエラー？
		if ($me != null) {
			var child = $me.position();

			txt += "me,";
			txt += Math.floor((child.top - parent.top)/25).toString() + ",";
			txt += Math.floor((child.left - parent.left)/25).toString();
		}

		for (var i = 0; i < $interviewers.length; i++){
			var child = $interviewers[i].position();
			txt += ",interviewer,";
			txt += Math.floor((child.top - parent.top)/25).toString() + ",";
			txt += Math.floor((child.left - parent.left)/25).toString();
		}

		// console.log($stickies[0].position())

		console.log(txt);
		document.getElementById('draw_txt').value = txt
	});
});
