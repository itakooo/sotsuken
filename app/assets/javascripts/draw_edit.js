//= require jquery
//= require jquery_ujs
//= require jquery.ui.core
//= require jquery.ui.widget
//= require jquery.ui.mouse
//= require jquery.ui.draggable

$interviewers = []
$texts = []
$me = null
var cnt = 0; // 自分カウンタ

// ページ読み込み後
$( function() {
	if ($('#obj_me').length != 0){
		cnt++;
		$me = $('#obj_me')
			.appendTo('div.ui-widget-content')
			.draggable( {
				containment: "#jquery-ui-draggable-wrap",
				grid: [25, 25],
				opacity: 0.5,
				scroll: false
			});
	}

	for (var i = 1; ; i++){
		var name = "#obj_interviewer" + i.toString();
		if ($(name).length == 0) break; // 面接官がある分だけ取得

		$tmp = $(name)
		.appendTo('div.ui-widget-content')
		.draggable( {
			containment: "#jquery-ui-draggable-wrap",
			grid: [25, 25],
			opacity: 0.5,
			scroll: false
		});

		$interviewers.push($tmp)
	}
});




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

// 面接官ボタン
$( function() {
	$( '#interviewer' ).click( function(evt) {
		var $tmp = $('<div class = "object"><img src = "/assets/interviewer.png" ></div>')
			.dblclick( function() {
				$(this).remove();
				$interviewers.splice($interviewers.length - 1, 1);
			})
			.css("position", "absolute") // important
			.prependTo('div.ui-widget-content')
			.draggable( {
				containment: "#jquery-ui-draggable-wrap",
				grid: [25, 25],
				opacity: 0.5,
				scroll: false,
			});
		$interviewers.push($tmp)
	});
});


/////////////////////////////////////////////////////////
// ホワイトボードボタン

// テキストボタン
$( function() {
	$( '#addtext' ).click( function(evt) {
		var $tmp = $('<div class = "form-group"><div class = "col-md-4"><input type="text" id = "textbox" class = "form-control"></div></div>')
		
	});
});

// クリアボタン
$( function() {
	$( '#clear-button' ).click( function(evt) {
		$("div.ui-widget-content").empty();
		cnt = 0;
		$interviewers = []
		$me = null
		txt = "";
	});
});

// 保存ボタン
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

		console.log(txt);
		document.getElementById('draw_txt').value = txt
	});
});
