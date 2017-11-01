/**
 * 
 */

var TABLE_LIST = 'table-list';
var MENU_TAB = ".main-navbar-nav li";
var MODIFY_OPTION = 'modify-option';
var CONTENT_SAVE = 'content-save';

var TITLE_TD = 'title_td';
var ORDER_BY_MENU_NAME = 'order_by_menu_name';

var HIDDEN = 'hidden';

/* 共通変数 */

var MAIN_TABLE_NAME;

function getMainTable(){
	var li_list = $("." + MODIFY_OPTION + " a");
	for(var i=0; i<li_list.length; i++){
		var TF = $(li_list[i]).hasClass("active");
		if(TF){
			MAIN_TABLE_NAME = $(li_list[i]).attr("name");
		}
	}
	setTableHidden();
	console.log("current table :", MAIN_TABLE_NAME);
}

function setChangeTab(){
	$(MENU_TAB).click(function(){
		var li_list = $(MENU_TAB);
		for(var i=0; i<li_list.length; i++){
			var TF = $(li_list[i]).hasClass("active");
			if(TF){
				$(li_list[i]).removeClass("active");
			}
		}
		$(this).addClass("active");
		MAIN_TABLE_NAME = $(this).attr("name");
		console.log("current table :", MAIN_TABLE_NAME);
	});
}

function setChangeOption(){
	$('.' + MODIFY_OPTION + ' li').click(function(){
		var li_list = $("." + MODIFY_OPTION + " a");
		for(var i=0; i<li_list.length; i++){
			var TF = $(li_list[i]).hasClass("active");
			if(TF){
				$(li_list[i]).removeClass("active");
				break;
			}
		}
		$(this).find('a').addClass("active");
		MAIN_TABLE_NAME = $(this).find('a').attr("name");
		setTableHidden();
	});
}

function setTableHidden(){
	var table_list = $('.' + TABLE_LIST);
	for(var i=0; i<table_list.length; i++){
		var TF = $(table_list[i]).hasClass(MAIN_TABLE_NAME);
		if(TF){
			$(table_list[i]).removeClass(HIDDEN);
		} else {
			$(table_list[i]).addClass(HIDDEN);
		}
	}
}

/* for manage_page.js */

function setShowNHideTD(){
	$('.' + TITLE_TD).hide();
	var classMainName = $("." + ORDER_BY_MENU_NAME).find('option:selected').text();
	$('.' + classMainName).show();
	
	$('.' + ORDER_BY_MENU_NAME).change(function(){
		classMainName = $(this).find('option:selected').text();
		var classSubName = $('.' + classMainName).find('option:selected');
		console.log(classMainName, classSubName);
		$('.' + TITLE_TD).hide();
		$('.' + classMainName).show();
		try {
			$('.' + classSubName).show();
		} catch(e){
			
		}
	});
}