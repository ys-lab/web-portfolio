/**
 * 
 */

var CONTENT_SAVE = 'content-save';

$(document).ready(function(){
	getMainTable();
	setChangeTab();
	setChangeOption();
	setChangeContent();
	setShowNHideTD();
	$("#page_context").cleditor();
	contentSave();
});

function setChangeContent(){
	$('select').change(function(){
		getContent();
	});
}

function getContent(){
	switch(MAIN_TABLE_NAME){
	case TOPIC_CONTENT:
		jsonGetContent(targetContent());
		break;
	case TOPIC_SUB_CONTENT:
		jsonGetContent();
		break;
	}
}

function targetContent(){
	var CONTENT = new Object();
	var TARGET = $('.' + MAIN_TABLE_NAME + ' .' + ORDER_BY_MENU_NAME);
	var TARGET_NAME = $(TARGET).find('option:selected').text();
	var MAIN_TOPIC = $('.' + MAIN_TABLE_NAME + ' .' + TARGET_NAME).find('option:selected');
	var TARGET_SUB_NAME = $(MAIN_TOPIC).attr('name');
	var SUB_TOPIC = $(TARGET).find('option:selected');
	
	console.log(TARGET, TARGET_NAME, MAIN_TOPIC, TARGET_SUB_NAME, SUB_TOPIC);
	
	switch(MAIN_TABLE_NAME){
	case TOPIC_CONTENT:
		var num = $(MAIN_TOPIC).val();
		var target = MAIN_TABLE_NAME;
		CONTENT.topic_num = num;
		CONTENT.table = target;
		break;
	case TOPIC_SUB_CONTENT:
		var num = $(SUB_TOPIC).val();
		var target = MAIN_TABLE_NAME;
		CONTENT.num = num;
		CONTENT.table = target;
		break;
	}
	return CONTENT;
}

function contentSave(){
	
	$('.' + CONTENT_SAVE).click(function(){
		var edited = targetContent();
		edited.content = $("#page_context").val();
		console.log(edited);
		jsonSetContent(edited);
	});
}

function showContent(content){
	$("#page_context").val(content).blur();
}

function jsonGetContent(TARGET){
	console.log(TARGET);
	$.ajax({
		type: 'get',
		url: 'PageManager',
		contentType: "application/json; charset=utf-8",
		data: TARGET,
		success: function(data){
			if(typeof data[0] == 'undefined'){
				showContent("");
			} else {
				showContent(data[0].content);
			}
		},
		error: function(){
			console.log("ajax connection failed :");
		}
	});
}

function jsonSetContent(TARGET){
	$.ajax({
		type: 'post',
		url: 'PageManager',
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify(
			TARGET),
		success: function(data){
			alert("Content Successfuly Modified");
		},
		error: function(){
			console.log("ajax connection failed :");
		}
	});
}