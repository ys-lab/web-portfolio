<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>YS's IT Info Center</title>
    
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600&amp;subset=latin-ext" rel="stylesheet">
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/manage.css" rel="stylesheet">
    <link rel="stylesheet" href="css/jquery-ui.min.css">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/css/jquery.cleditor.css">
    
    <script src="js/jquery-3.2.1.min.js"></script>
    <script src="js/jquery-ui.min.js"></script>
    <script src="js/jquery.cleditor.min.js"></script>
    
    <script src="js/global-variables.js"></script>
    <script src="js/switcher.js"></script>
    <script src="js/manage_page.js"></script>
    
    <%@page import="org.json.simple.JSONArray"%>
	<%@page import="org.json.simple.JSONObject"%>
	<%@page import="org.json.simple.parser.JSONParser"%>
	<%@page import="org.json.simple.parser.ParseException"%>
	
	<%@page import="java.util.HashMap"%>
	<%@page import="java.util.ArrayList"%>
    
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<% 

String menuList = request.getAttribute("tabMenuList").toString();
String topicList = request.getAttribute("tabTopicList").toString();
String subTopicList = request.getAttribute("tabSubTopicList").toString();

JSONParser jsonParser = new JSONParser();

JSONArray jsonMenuArray = new JSONArray();
JSONArray jsonTopicArray = new JSONArray();
JSONArray jsonSubTopicArray = new JSONArray();

jsonMenuArray = (JSONArray) jsonParser.parse(menuList);
jsonTopicArray = (JSONArray) jsonParser.parse(topicList);
jsonSubTopicArray = (JSONArray) jsonParser.parse(subTopicList);

%>

<%

String[] menuNames = new String[jsonMenuArray.size()];
HashMap<String, ArrayList<String>> topicHashMap = new HashMap<String, ArrayList<String>>();
HashMap<String, ArrayList<String>> subTopicHashMap = new HashMap<String, ArrayList<String>>();

for(int i=0; i<jsonMenuArray.size(); i++){
	JSONObject menuTab = (JSONObject) jsonMenuArray.get(i);
	String tab_menu_name = menuTab.get("tab_menu_name").toString();
	menuNames[i] = tab_menu_name;
	ArrayList<String> topicNames = new ArrayList<String>();
	try{
		
	} catch(Exception topicError){
		for(int j=0; j<jsonTopicArray.size(); j++){
			JSONObject topicTab = (JSONObject) jsonTopicArray.get(i);
			String topicParentName = topicTab.get("tab_menu_name").toString();
			String topicName = topicTab.get("tab_topic_name").toString();
			if(topicParentName.equals(tab_menu_name)){
				topicNames.add(topicName);
			}
			ArrayList<String> subTopicNames = new ArrayList<String>();
			try{
				for(int k=0; k<jsonSubTopicArray.size(); k++){
					JSONObject subTopicTab = (JSONObject) jsonSubTopicArray.get(i);
					String subTopicParentName = subTopicTab.get("tab_topic_name").toString();
					String subTopicName = subTopicTab.get("tab_sub_topic_name").toString();
					if(subTopicParentName.equals(topicName)){
						subTopicNames.add(subTopicName);
					}
				}
				subTopicHashMap.put(topicName, subTopicNames);
			} catch(Exception subTopicError){
				
			}
		}
		topicHashMap.put(tab_menu_name, topicNames);
	}
}

%>
<body>
    <header class="site-header">
        <div class="top">
            <div class="container">
                <div class="row">
                    <div class="col-sm-6">
                        <p>YS's IT Info Center</p>
                    </div>
                    <div class="col-sm-6">
                        <ul class="list-inline pull-right">
                            <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                            <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a></li>
                            <li><a href="#"><i class="fa fa-envelope-o"></i></a></li>
                            <li><a href="tel:+902222222222"><i class="fa fa-phone"></i> +82 010 2208 8616</a></li>
                            <li><a href="Manage"><i class="fa">EDIT</i></i></a>
                        </ul>                        
                    </div>
                </div>
            </div>
        </div>
        <nav class="navbar navbar-default">
			<div class="container">
				<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-navbar-collapse">
					<span class="sr-only">Toggle Navigation</span>
					<i class="fa fa-bars"></i>
				</button>
				<a href="index.html" class="navbar-brand">
					<img src="img/logo.png" alt="Post">
				</a>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-navbar-collapse">
                    <ul class="nav navbar-nav main-navbar-nav">
                        <li class=""><a href="Index" title="���쇈��">HOME</a></li>
                        <li class=""><a href="Manage?target=Menu" name="menu-list-modify" title="メニュー管理">MENU MANAGE</a></li>
                        <li class="active"><a href="Manage?target=Page" name="page-modify" title="ページ管理">PAGE MANAGE</a></li>
                        <li class=""><a href="#" name="" title="コンテンツ管理">CONTENT MANAGE</a></li>
                    </ul>                           
                </div><!-- /.navbar-collapse -->                
				<!-- END MAIN NAVIGATION -->
			</div>
		</nav>        
    </header>
    <div class="bread_area">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">
                    <ol class="breadcrumb">
                        <li><a href="#">Home</a></li>
                        <li class="active"></li>
                    </ol>                    
                </div>
            </div>
        </div>
    </div>
	<main class="site-main page-main">
		<div class="container">
			<div class="row">
				<section class="page col-sm-9">
                    <h2 class="page-title"></h2>
                    <div class="entry">
                    	<table class="menu-list-modify">
							<thead class="table-list tab_topic_contents">
								<th>MENU NAME</th>
								<th>TOPIC MENU NAME</th>
							</thead>
							<thead class="table-list tab_topic_sub_contents">
								<th>MENU NAME</th>
								<th>TOPIC MENU NAME</th>
								<th>TOPIC SUB MENU NAME</th>
							</thead>
							<tbody class="table-list tab_topic_contents list-sortable">
								<tr>
									<td>
										<%
										out.write("<select class='order_by_menu_name column_name num' name='num'>");
		                				for(int i=0; i<jsonMenuArray.size(); i++){
						                	JSONObject menuTab = (JSONObject) jsonMenuArray.get(i);
						                	int tab_menu_type = Integer.parseInt(menuTab.get("tab_menu_type").toString());
						                	String num = menuTab.get("num").toString();
						                	String tab_menu_num = menuTab.get("tab_menu_num").toString();
						                	String tab_menu_title = menuTab.get("tab_menu_title").toString();
						                	String tab_menu_name = menuTab.get("tab_menu_name").toString();
						                	String tab_menu_link = menuTab.get("tab_menu_link").toString();
						            		
						                	out.write("<option title='" + tab_menu_title +"' value='" + num + "'>" + tab_menu_name + "</option>");
						                }
		                				out.write("</select>");
										%>
										
									</td>
									<%
									for(int i=0; i<jsonMenuArray.size(); i++){
					                	JSONObject menuTab = (JSONObject) jsonMenuArray.get(i);
					                	int tab_menu_type = Integer.parseInt(menuTab.get("tab_menu_type").toString());
					                	String num = menuTab.get("num").toString();
					                	String tab_menu_num = menuTab.get("tab_menu_num").toString();
					                	String tab_menu_title = menuTab.get("tab_menu_title").toString();
					                	String tab_menu_name = menuTab.get("tab_menu_name").toString();
					                	String tab_menu_link = menuTab.get("tab_menu_link").toString();
					                	
					                	out.write("<td class='title_td " + tab_menu_name + "'>");
					                	out.write("<select class='column_name topic_num' name='topic_num'>");
					                	for(int j=0; j<jsonTopicArray.size(); j++){
					                		JSONObject topicTab = (JSONObject) jsonTopicArray.get(j);
						                	int tab_topic_type = Integer.parseInt(topicTab.get("tab_topic_type").toString());
						                	String topic_num = topicTab.get("num").toString();
						                	String tab_menu_name_this_topic = topicTab.get("tab_menu_name").toString();
						                	String tab_topic_num = topicTab.get("tab_topic_num").toString();
						                	String tab_topic_title = topicTab.get("tab_topic_title").toString();
						                	String tab_topic_name = topicTab.get("tab_topic_name").toString();
						                	String tab_topic_link = topicTab.get("tab_topic_link").toString();
						                	
						                	if(tab_menu_name.equals(tab_menu_name_this_topic)){
						                		out.write("<option title='" + tab_topic_title +"' value='" + topic_num + "'>" + tab_topic_name + "</option>");
						                	}
					                	}
					                	out.write("</select>");
					                	out.write("</td>");
					                	
					                }
									%>
								</tr>
							</tbody>
							<tbody class="table-list tab_topic_sub_contents list-sortable">
								<tr>
									<td>
										<%
										out.write("<select id='order_by_menu_name' class='column_name num' name='num'>");
		                				for(int i=0; i<jsonMenuArray.size(); i++){
						                	JSONObject menuTab = (JSONObject) jsonMenuArray.get(i);
						                	int tab_menu_type = Integer.parseInt(menuTab.get("tab_menu_type").toString());
						                	String num = menuTab.get("num").toString();
						                	String tab_menu_num = menuTab.get("tab_menu_num").toString();
						                	String tab_menu_title = menuTab.get("tab_menu_title").toString();
						                	String tab_menu_name = menuTab.get("tab_menu_name").toString();
						                	String tab_menu_link = menuTab.get("tab_menu_link").toString();
						            		
						                	out.write("<option title='" + tab_menu_title +"' value='" + num + "'>" + tab_menu_name + "</option>");
						                }
		                				out.write("</select>");
										%>
										
									</td>
									<%
									for(int i=0; i<jsonMenuArray.size(); i++){
					                	JSONObject menuTab = (JSONObject) jsonMenuArray.get(i);
					                	int tab_menu_type = Integer.parseInt(menuTab.get("tab_menu_type").toString());
					                	String num = menuTab.get("num").toString();
					                	String tab_menu_num = menuTab.get("tab_menu_num").toString();
					                	String tab_menu_title = menuTab.get("tab_menu_title").toString();
					                	String tab_menu_name = menuTab.get("tab_menu_name").toString();
					                	String tab_menu_link = menuTab.get("tab_menu_link").toString();
					                	
					                	out.write("<td class='title_td " + tab_menu_name + "'>");
					                	out.write("<select class='column_name topic_num' name='topic_num'>");
					                	
					                	for(int j=0; j<jsonTopicArray.size(); j++){
					                		JSONObject topicTab = (JSONObject) jsonTopicArray.get(j);
						                	int tab_topic_type = Integer.parseInt(topicTab.get("tab_topic_type").toString());
						                	String topic_num = topicTab.get("num").toString();
						                	String tab_menu_name_this_topic = topicTab.get("tab_menu_name").toString();
						                	String tab_topic_num = topicTab.get("tab_topic_num").toString();
						                	String tab_topic_title = topicTab.get("tab_topic_title").toString();
						                	String tab_topic_name = topicTab.get("tab_topic_name").toString();
						                	String tab_topic_link = topicTab.get("tab_topic_link").toString();
						                	
						                	if(tab_menu_name.equals(tab_menu_name_this_topic)){
						                		out.write("<option title='" + tab_topic_title +"' value='" + topic_num + "'>" + tab_topic_name + "</option>");
						                	}
					                	}
					                	out.write("</select>");
					                	out.write("</td>");
					                	
					                }
									
									for(int i=0; i<jsonTopicArray.size(); i++){
				                		JSONObject topicTab = (JSONObject) jsonTopicArray.get(i);
					                	int tab_topic_type = Integer.parseInt(topicTab.get("tab_topic_type").toString());
					                	String topic_num = topicTab.get("num").toString();
					                	String tab_menu_name_this_topic = topicTab.get("tab_menu_name").toString();
					                	String tab_topic_num = topicTab.get("tab_topic_num").toString();
					                	String tab_topic_title = topicTab.get("tab_topic_title").toString();
					                	String tab_topic_name = topicTab.get("tab_topic_name").toString();
					                	String tab_topic_link = topicTab.get("tab_topic_link").toString();
					                	
					                	out.write("<td class='title_td" + tab_menu_name_this_topic + "' num='" + topic_num + "' tab_topic_link='" + tab_topic_link + " topic_num='" + tab_topic_num + "'>");
					                	
					                	
					                	for(int j=0; j<jsonSubTopicArray.size(); j++){
					                		try{
					                			JSONObject subTopicTab = (JSONObject) jsonTopicArray.get(j);
							                	int tab_topic_sub_type = Integer.parseInt(topicTab.get("tab_topic_sub_type").toString());
							                	String topic_sub_num = topicTab.get("num").toString();
							                	String tab_topic_name_this_topic = topicTab.get("tab_topic_sub_name").toString();
							                	String tab_topic_sub_num = topicTab.get("tab_topic_sub_num").toString();
							                	String tab_topic_sub_title = topicTab.get("tab_topic_sub_title").toString();
							                	String tab_topic_sub_name = topicTab.get("tab_topic_sub_name").toString();
							                	String tab_topic_sub_link = topicTab.get("tab_topic_sub_link").toString();
						                	
						                		switch(j){
						                		case 0:
						                			out.write("<select class='column_name num'" + tab_topic_name_this_topic + " name='num'>");
					                			default:
								                	out.write("<option title='" + tab_topic_title +"' value='" + topic_sub_num + "' selected>" + tab_topic_name + "</option>");
						                			break;
						                		}
					                		} catch(Exception e){
					                			
					                		}
					                	}
					                	out.write("</select>");
					                	out.write("</td");
				                	}
									%>
								</tr>
							</tbody>
							<tbody class="table-list tab_topic_lists list-sortable hidden">
								<%
								out.write("<tr class='ui-state-default menu-row hidden' num='' name='tab_topic_lists'><td class='hidden'><input class='column_name tab_topic_num' name='tab_topic_num' type='text' value=''></td><td><input class='column_name tab_menu_name' name='tab_menu_name' type='text' value=''></td><td><input class='column_name tab_topic_title' name='tab_topic_title' type='text' value=''></td><td><input class='column_name tab_topic_link' name='tab_topic_link' type='text' value=''></td><td><select class='column_name tab_topic_type' name='tab_topic_type'><option value='1'>1</option><option value='2'>2</option></select></td><td><a class='menu-modify'><i class='fa fa-pencil-square-o'></i></a><a class='menu-remove'><i class='fa fa-times'></i></a></td></tr>");
				                for(int i=0; i<jsonMenuArray.size(); i++){
				                	JSONObject topicTab = (JSONObject) jsonTopicArray.get(i);
				                	int tab_topic_type = Integer.parseInt(topicTab.get("tab_topic_type").toString());
				                	String num = topicTab.get("num").toString();
				                	String tab_menu_name = topicTab.get("tab_menu_name").toString();
				                	String tab_topic_num = topicTab.get("tab_topic_num").toString();
				                	String tab_topic_title = topicTab.get("tab_topic_title").toString();
				                	String tab_topic_name = topicTab.get("tab_topic_name").toString();
				                	String tab_topic_link = topicTab.get("tab_topic_link").toString();
				            		
				                	out.write("<tr class='ui-state-default' num='" + num + "' name='tab_topic_lists'>");
				                	out.write("<td class='hidden'><input class='column_name tab_topic_num' name='tab_topic_num' type='text' value='" + tab_topic_num + "'></td>");
				                	out.write("<td>");
				            		out.write("<input class='column_name tab_menu_name' name='tab_menu_name' type='text' value='" + tab_menu_name + "'");
				            		out.write("</td>");
				            		out.write("<td>");
				            		out.write("<input class='column_name tab_topic_title' name='tab_topic_title' type='text' value='" + tab_topic_title + "'");
				            		out.write("</td>");
				            		out.write("<td>");
				            		out.write("<input class='column_name tab_topic_link' name='tab_topic_link' type='text' value='" + tab_topic_link + "'");
				            		out.write("</td>");
				            		out.write("<td>");
				            		out.write("<select class='column_name tab_topic_type' name='tab_topic_type'>");
				            		for(int j=1; j<3; j++){
				            			if(j == tab_topic_type){
				            				out.write("<option value='" + j + "' selected>" + j + "</option>");
				            			} else {
				            				out.write("<option value='" + j + "'>" + j + "</option>");
				            			}
				            		}
				            		out.write("</select>");
				            		out.write("</td>");
				            		out.write("<td>");
				            		out.write("<a class='menu-modify'><i class='fa fa-pencil-square-o'></i></a>");
				            		out.write("<a class='menu-remove'><i class='fa fa-times'></i></a>");
				            		out.write("</td>");
				            		out.write("</tr>");
				                }
								%>
							</tbody>
							<tbody class="page-context">
								<tr>
									<td colspan="5">
										<textarea id="page_context" name="page_context"></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<select id="image_list" size="5"></select>
									</td>
									<td colspan="2">
										<input type="button" id="remove_image" value="REMOVE"/>
									</td>
								</tr>
								<tr>
									<td colspan="3">
										<input type="file" id="page_image"/>
									</td>
									<td colspan="2">
										<input type="button" id="submit_image" value="SUBMIT"/>
									</td>
								</tr>
							</tbody>
							<tbody class="menu-option">
								<tr>
									<td colspan="2">
									</td>
									<td colspan="2">
										<a class="content-save"><i class='fa fa-floppy-o'></i>SAVE CHANGES</a>
									</td>
								</tr>
							</tbody>
						</table>
                    </div>
                </section>
                <aside class="sidebar col-sm-3">
	                <div class="widget">
	                    <h4>OPTIONS</h4>
	                    <ul class="modify-option">
	                    	<li><a class="active" name="tab_topic_contents">MODIFY TOPIC CONTENT</a></li>
	                    	<li><a class="" name="tab_topic_sub_contents">MODIFY TOPIC SUB CONTENT</a></li>
	                    </ul>
	                </div>
	            </aside>
			</div>
		</div>
	</main>
	<footer class="site-footer">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-sm-6 fbox">
                    <h4>COMPANY NAME</h4>
                    <p class="text">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam congue lectus diam, sit amet cursus massa efficitur sed. </p>
                    <ul class="list-inline">
                        <li><a href="#"><i class="fa fa-facebook"></i></a></li>
                        <li><a href="#"><i class="fa fa-twitter"></i></a></li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a></li>                        
                    </ul>
                </div>
                <div class="col-md-3 col-sm-6 fbox">
                    <h4>SERVICES</h4>
                    <ul class="big">
                        <li><a href="#" title="">Title One</a></li>
                        <li><a href="#" title="">Title Two</a></li>
                        <li><a href="#" title="">Title Three</a></li>
                        <li><a href="#" title="">Title Four</a></li>
                        <li><a href="#" title="">Title Five</a></li>
                        <li><a href="#" title="">Title Six</a></li>
                        <li><a href="#" title="">Title Seven</a></li>
                        <li><a href="#" title="">Title Eight</a></li>
                    </ul>
                </div>
                <div class="col-md-3 col-sm-6 fbox">
                    <h4>CONTENT</h4>
                    <ul class="big">
                        <li><a href="#" title="">Title One</a></li>
                        <li><a href="#" title="">Title Two</a></li>
                        <li><a href="#" title="">Title Three</a></li>
                        <li><a href="#" title="">Title Four</a></li>
                        <li><a href="#" title="">Title Five</a></li>
                        <li><a href="#" title="">Title Six</a></li>
                        <li><a href="#" title="">Title Seven</a></li>
                        <li><a href="#" title="">Title Eight</a></li>
                    </ul>
                </div>
                <div class="col-md-3 col-sm-6 fbox">
                    <h4>CONTENT</h4>
                    <p class="text">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                    <p><a href="tel:+902222222222"><span class="glyphicon glyphicon-earphone" aria-hidden="true"></span> +90 222 222 22 22</a></p>
                    <p><a href="mailto:iletisim@agrisosgb.com"><span class="glyphicon glyphicon-envelope" aria-hidden="true"></span> mail@awebsitename.com</a></p>
                </div>
            </div>
        </div>
        <div id="copyright">
            <div class="container">
                <div class="row">
                    <div class="col-md-4">
                        <p class="pull-left">&copy; 2016 COMPANY NAME</p>
                    </div>
                    <div class="col-md-8">
                        <ul class="list-inline navbar-right">
                            <li><a href="#">HOME</a></li>
                            <li><a href="#">MENU ITEM</a></li>
                            <li><a href="#">MENU ITEM</a></li>
                            <li><a href="#">MENU ITEM</a></li>
                            <li><a href="#">MENU ITEM</a></li>
                            <li><a href="#">MENU ITEM</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>        
    </footer>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>