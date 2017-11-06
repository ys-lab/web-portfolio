<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
                        
 try{
 	for(int i=0; i<jsonMenuTabArray.size(); i++){
     	JSONObject menuTab = (JSONObject) jsonMenuTabArray.get(i);
     	int tabMenuType = Integer.parseInt(menuTab.get("tab_menu_type").toString());
     	String tabMenuTitle = menuTab.get("tab_menu_title").toString();
     	String tabMenuName = menuTab.get("tab_menu_name").toString();
     	String tabMenuLink = menuTab.get("tab_menu_link").toString();
     	
     	switch(tabMenuType){
     	case 1:
     		out.write("<li class='dropdown'>");
         	out.write("<a href=" + tabMenuLink + " title='" + tabMenuTitle + "' class='dropdown-toggle' data-toggle='dropdown' role='button' aria-haspopup='true' aria-expanded='false'>" + tabMenuName + "<span class='caret'></span></a>");
         	out.write("<ul class='dropdown-menu'>");
         	
         	for(int j=0; j<jsonTopicArray.size(); j++){
         		JSONObject topic = (JSONObject) jsonTopicArray.get(j);
         		String tabTopicTitle = topic.get("tab_topic_title").toString();
         		String tabTopicName = topic.get("tab_topic_name").toString();
         		String tabTopicLink = topic.get("tab_topic_link").toString();
         		String tabMasterName = topic.get("tab_menu_name").toString();
         		String compare = "";
         		if(tabTopicLink.length() > 16){
         			compare = tabTopicLink.substring(16);
         		}
         		
         		System.out.println(tabTopicLink + " " + target);
         		
         		if(tabMasterName.compareTo(tabMenuName) == 0){
         			out.write("	<li><a href='" + tabTopicLink + "' title='" + tabTopicTitle + "'>" + tabTopicName + "</a></li>");
         		}
         		if(target.compareTo(compare) == 0){
         			check = tabMasterName;
         		}
         	}
         	
         	out.write("</ul>");
     		break;
     	case 2:
     		out.write("<li><a href=" + tabMenuLink + " title=" + tabMenuTitle + ">" + tabMenuName +"</a></li>");
     		break;
     	}
     }
 }catch(Exception e){
 	e.printStackTrace();
 }
 %>