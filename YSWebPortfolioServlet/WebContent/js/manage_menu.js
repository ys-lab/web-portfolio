/**
 * 
 */

$(document).ready(function(){
	getMainTable();
	setChangeTab();
	setChangeOption();
	setMenuArray();
	add();
	//edit();
	remove();
	confirm();
	forSortable();
});

var TBODY = 'tbody';
var TR = 'ui-state-default';
var NUM = 'num';
var NAME = 'name';

var MENU_ROW = 'menu-row';
var MENU_ADD = 'menu-add';
var MENU_REMOVE = 'menu-remove';
var MENU_MODIFY = 'menu-modify';
var MENU_OPTION = 'menu-option';
var MENU_SAVE = 'menu-save';

var COLUMN_NAME = "column_name";
var LIST_SORTABLE = 'list-sortable';

var TAB_MENU_NUM = 'tab_menu_num';
var TAB_TOPIC_NUM = 'tab_topic_num';
var TAB_TOPIC_SUB_NUM = 'tab_topic_sub_num';

var menuArray = new Object();
var menuArrayDeleted = new Object();

function setMenuArray(){
	var rows = $(TBODY + '.' + TABLE_LIST + ' .' + TR);
	var num = $(rows).length;
	var count = 0;
	var prev_table_name = "";
	for(var i=0; i<num;i++){
		var table_name = $(rows[i]).attr('name');
		var isHead = $(rows[i]).hasClass(HIDDEN);
		if(!isHead){
			if(typeof menuArray[table_name] == 'undefined'){
				menuArray[table_name] = new Object();
			}
			if(prev_table_name != table_name){
				count = 0;
				prev_table_name = table_name;
			}
			if(typeof menuArray[table_name][count]){
				menuArray[table_name][count] = new Object();
			}
			menuArray[table_name][count] = getMenuValues(rows[i], count);
			count++;
		}
	}
	console.log('setMenuArray :', menuArray);
}

function getMenuValues(row, number){
	var menuObject = new Object();
	menuObject.num = $(row).attr(NUM);
	var columns = $(row).find('.' + COLUMN_NAME);
	for(var i=0;i<columns.length; i++){
		var column_name = $(columns[i]).attr(NAME);
		menuObject[column_name] = $(row).find('.' + column_name).val();
	}
	return menuObject;
}

function addMenuArray(row, num){
	if(typeof menuArray[MAIN_TABLE_NAME][num] == 'undefined'){
		menuArray[MAIN_TABLE_NAME][num] = new Object();
		menuArray[MAIN_TABLE_NAME][num].num = $(row).attr(NUM);
		var columns = $(row).find('.' + COLUMN_NAME);
		for(var i=0;i<columns.length; i++){
			var column_name = $(columns[i]).attr(NAME);
			if(typeof menuArray[MAIN_TABLE_NAME][num] == 'undefined'){
				menuArray[MAIN_TABLE_NAME][num] = new Object();
			}
			switch(column_name){
			case TAB_MENU_NUM:
			case TAB_TOPIC_NUM:
			case TAB_TOPIC_SUB_NUM:
				menuArray[MAIN_TABLE_NAME][num][column_name] = num;
				break;
			default:
				menuArray[MAIN_TABLE_NAME][num][column_name] = "";
				break;
			}
		}
		console.log(columns, menuArray[MAIN_TABLE_NAME][num]);
	}
}

var deletedMenu = 0;

function delMenuArray(num){
	menuArrayDeleted[deletedMenu] = new Object();
	menuArrayDeleted[deletedMenu++].num = num;
	//delete menuArray.num;
}

function add(){
	$('.' + MENU_ADD).click(function(){
		var rowCount = $(TBODY + '.' + MAIN_TABLE_NAME + ' .' + TR).length;
		var menu_row = $(TBODY + '.' + MAIN_TABLE_NAME + ' .' + MENU_ROW).clone();
		console.log(rowCount, menu_row);
		//$(menu_row).find('.tab_menu_num').attr(rowCount);
		$(menu_row).removeClass("hidden");
		$(menu_row).removeClass(MENU_ROW);
		$(menu_row).attr(NUM, "");
		$(TBODY + '.' + MAIN_TABLE_NAME).append(menu_row);
		//forSortable();
		setEdit(menu_row);
		setRemove(menu_row);
		addMenuArray(menu_row, rowCount);
	});
}

function edit(){
	$('.' + MENU_MODIFY).click(function(){
		
	});
}

function setEdit(row){
	$(row).click(function(){
		
	});
}

function remove(){
	$('.' + MENU_REMOVE).click(function(){
		var menu_row = $(this).parent().parent();
		var num = $(menu_row).attr(NUM);
		$(menu_row).detach();
		if(num != ""){
			delMenuArray(num);
		}
	});
}

function setRemove(menu_row){
	$(menu_row).find('.' + MENU_REMOVE).click(function(){
		var num = $(menu_row).attr(NUM);
		$(menu_row).detach();
		if(num != ""){
			delMenuArray(num);
		}
	});
}

function confirm(){
	$('.' + MENU_SAVE).click(function(){
		
		var menuArrayAdded = new Object();
		var menuArrayModified = new Object();
		
		var list = new Object();
		var rows = $(TBODY + '.' + MAIN_TABLE_NAME + ' .' + TR);
		var num = $(rows).length;
		var count = 0;
		var num_add = 0;
		var num_mdf = 0;
		
		console.log(num);
		for(var i=0; i<num;i++){
			var isHead = $(rows[i]).hasClass(HIDDEN);
			if(!isHead){
				var check = getMenuValues(rows[i], i);
				console.log(check);
				for(var key in check){
					switch(key){
					case TAB_MENU_NUM:
					case TAB_TOPIC_NUM:
					case TAB_TOPIC_SUB_NUM:
						for(var j=0; j<num; j++){
							if(typeof menuArray[MAIN_TABLE_NAME][j] != 'undefined'){
								if(check[key] == menuArray[MAIN_TABLE_NAME][j][key]){
									check[key] = i;
									var checked = checkMenuDiff(menuArray[MAIN_TABLE_NAME][j], check);
									console.log("::", check, check[key], checked, num_mdf, menuArrayModified[num_mdf], i, j, key);
									if(checked > 0){
										if(typeof menuArrayModified[num_mdf] == 'undefined' && check[key]!=""){
											menuArrayModified[num_mdf] = new Object();
											menuArrayModified[num_mdf++] = check;
										}
									}
									break;
								}
							}
						}
						if(check[key] == ""){
							menuArrayAdded[num_add] = new Object();
							check[key] = i;
							menuArrayAdded[num_add++] = check;
							console.log(check, key, menuArrayAdded);
						}
						break;
					}
				}
			}
		}
		postMenu(menuArrayAdded, menuArrayModified);
	});
}

function checkMenuDiff(row, check){
	var diff = 0;
	for(var key in row){
		if(row[key] != check[key]){
			diff++;
		}
	}
	return diff;
}

function forSortable(){
	$('.' + LIST_SORTABLE).sortable();
	$('.' + LIST_SORTABLE).disableSelection();
}

function setSortable(row){
	$(row).sortable("disable");
	$(row).disableSelection();
}

function postMenu(menuArrayAdded, menuArrayModified){
	console.log("at postMenu :", menuArrayAdded, menuArrayModified, menuArrayDeleted);
	$.ajax({
		type: 'post',
		url: 'TabManager',
		contentType: "application/json; charset=utf-8",
		data: JSON.stringify({
			table		: MAIN_TABLE_NAME,
			added		: menuArrayAdded,
			modified	: menuArrayModified,
			deleted		: menuArrayDeleted
		}),
		success: function(data){
			
		},
		error: function(){
			console.log("ajax connection failed :");
		}
	});
}