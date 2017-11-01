<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>YS's IT Info Center</title>
    
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:400,600&amp;subset=latin-ext" rel="stylesheet">
    
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    
    <%@page import="org.json.simple.JSONArray"%>
	<%@page import="org.json.simple.JSONObject"%>
	<%@page import="org.json.simple.parser.JSONParser"%>
	<%@page import="org.json.simple.parser.ParseException"%>
    
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<% 

String menuTabList;
String topicList;
String topicSubList;
String target;
String content;

JSONParser jsonParser = new JSONParser();

JSONArray jsonMenuTabArray = new JSONArray();
JSONArray jsonTopicArray = new JSONArray();
JSONArray jsonTopicSubArray = new JSONArray();
JSONArray jsonContentArray = new JSONArray();
JSONObject jsonContent = new JSONObject();

menuTabList = request.getAttribute("tabMenuList").toString();
topicList = request.getAttribute("tabTopicList").toString();
topicSubList = request.getAttribute("tabSubTopicList").toString();
target = request.getAttribute("target").toString();

jsonMenuTabArray = (JSONArray) jsonParser.parse(menuTabList);
jsonTopicArray = (JSONArray) jsonParser.parse(topicList);
jsonTopicSubArray = (JSONArray) jsonParser.parse(topicSubList);


String check = "";

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
                            <li><a href="Manage?target=Menu"><i class="fa">EDIT</i></i></a>
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
				<a href="Index" class="navbar-brand">
					<img src="img/logo.png" alt="Post">
				</a>
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-navbar-collapse">
                    <ul class="nav navbar-nav main-navbar-nav">
                        <li class="active"><a href="index.html" title="">HOME</a></li>
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
                                		String compare = tabTopicLink.substring(12);
                                		
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
                        <li><a href="#" title="Post">Home</a></li>
                        <li class="active">Category Name</li>
                    </ol>                    
                </div>
            </div>
        </div>
    </div>
    <main class="site-main category-main">
        <div class="container">
            <div class="row">
                <section class="category-content col-sm-9">
                    <h2 class="category-title">CATEGORY NAME</h2>
                    <ul class="media-list">
                        <li class="media">
                            <div class="media-left">
                                <a href="#" title="Post">
                                    <img class="media-object" src="img/h1.jpeg" alt="Post">
                                </a>
                            </div>
                            <div class="media-body">
                                <h3 class="media-heading"><a href="#" title="Post Title">Post Title</a></h3>
                                <p>Aenean vitae dolor sed purus tempus ullamcorper. Integer urna orci, lacinia ut ornare sit amet, luctus quis est. Ut interdum lorem in mattis lobortis. Maecenas tincidunt justo a lobortis facilisis.</p>
                                <aside class="meta category-meta">
                                    <div class="pull-left">
                                        <div class="arc-comment"><a href="#" title="Comment"><i class="fa fa-comments"></i> 0 Comment</a></div>
                                        <div class="arc-date">10/15/2016</div>
                                    </div>
                                    <div class="pull-right">
                                        <ul class="arc-share">
                                            <li><a href="#" title="Post"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </aside>                                
                            </div>
                        </li>
                        <li class="media">
                            <div class="media-left">
                                <a href="#" title="Post">
                                    <img class="media-object" src="img/h2.jpg" alt="Post">
                                </a>
                            </div>
                            <div class="media-body">
                                <h3 class="media-heading"><a href="#" title="Post Title">Post Title</a></h3>
                                <p>Aenean vitae dolor sed purus tempus ullamcorper. Integer urna orci, lacinia ut ornare sit amet, luctus quis est. Ut interdum lorem in mattis lobortis. Maecenas tincidunt justo a lobortis facilisis.</p>
                                <aside class="meta category-meta">
                                    <div class="pull-left">
                                        <div class="arc-comment"><a href="#" title="Comment"><i class="fa fa-comments"></i> 1 Comment</a></div>
                                        <div class="arc-date">10/15/2016</div>
                                    </div>
                                    <div class="pull-right">
                                        <ul class="arc-share">
                                            <li><a href="#" title="Post"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </aside>                                
                            </div>
                        </li>
                        <li class="media">
                            <div class="media-left">
                                <a href="#" title="Post">
                                    <img class="media-object" src="img/h3.jpeg" alt="Post">
                                </a>
                            </div>
                            <div class="media-body">
                                <h3 class="media-heading"><a href="#" title="Post Title">Post Title</a></h3>
                                <p>Aenean vitae dolor sed purus tempus ullamcorper. Integer urna orci, lacinia ut ornare sit amet, luctus quis est. Ut interdum lorem in mattis lobortis. Maecenas tincidunt justo a lobortis facilisis.</p>
                                <aside class="meta category-meta">
                                    <div class="pull-left">
                                        <div class="arc-comment"><a href="#" title="Comment"><i class="fa fa-comments"></i> 2 Comments</a></div>
                                        <div class="arc-date">10/15/2016</div>
                                    </div>
                                    <div class="pull-right">
                                        <ul class="arc-share">
                                            <li><a href="#" title="Post"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </aside>                                
                            </div>
                        </li>
                        <li class="media">
                            <div class="media-left">
                                <a href="#" title="Post">
                                    <img class="media-object" src="img/h4.jpeg" alt="Post">
                                </a>
                            </div>
                            <div class="media-body">
                                <h3 class="media-heading"><a href="#" title="Post Title">Post Title</a></h3>
                                <p>Aenean vitae dolor sed purus tempus ullamcorper. Integer urna orci, lacinia ut ornare sit amet, luctus quis est. Ut interdum lorem in mattis lobortis. Maecenas tincidunt justo a lobortis facilisis.</p>
                                <aside class="meta category-meta">
                                    <div class="pull-left">
                                        <div class="arc-comment"><a href="#" title="Comment"><i class="fa fa-comments"></i> 2 Comments</a></div>
                                        <div class="arc-date">10/15/2016</div>
                                    </div>
                                    <div class="pull-right">
                                        <ul class="arc-share">
                                            <li><a href="#" title="Post"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </aside>                                
                            </div>
                        </li>
                        <li class="media">
                            <div class="media-left">
                                <a href="#" title="Post">
                                    <img class="media-object" src="img/h1.jpeg" alt="Post">
                                </a>
                            </div>
                            <div class="media-body">
                                <h3 class="media-heading"><a href="#" title="Post Title">Post Title</a></h3>
                                <p>Aenean vitae dolor sed purus tempus ullamcorper. Integer urna orci, lacinia ut ornare sit amet, luctus quis est. Ut interdum lorem in mattis lobortis. Maecenas tincidunt justo a lobortis facilisis.</p>
                                <aside class="meta category-meta">
                                    <div class="pull-left">
                                        <div class="arc-comment"><a href="#" title="Comment"><i class="fa fa-comments"></i> 12 Comments</a></div>
                                        <div class="arc-date">10/15/2016</div>
                                    </div>
                                    <div class="pull-right">
                                        <ul class="arc-share">
                                            <li><a href="#" title="Post"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </aside>                                
                            </div>
                        </li>
                        <li class="media">
                            <div class="media-left">
                                <a href="#" title="Post">
                                    <img class="media-object" src="img/h2.jpg" alt="Post">
                                </a>
                            </div>
                            <div class="media-body">
                                <h3 class="media-heading"><a href="#" title="Post Title">Post Title</a></h3>
                                <p>Aenean vitae dolor sed purus tempus ullamcorper. Integer urna orci, lacinia ut ornare sit amet, luctus quis est. Ut interdum lorem in mattis lobortis. Maecenas tincidunt justo a lobortis facilisis.</p>
                                <aside class="meta category-meta">
                                    <div class="pull-left">
                                        <div class="arc-comment"><a href="#" title="Comment"><i class="fa fa-comments"></i> 2 Comments</a></div>
                                        <div class="arc-date">10/15/2016</div>
                                    </div>
                                    <div class="pull-right">
                                        <ul class="arc-share">
                                            <li><a href="#" title="Post"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </aside>                                
                            </div>
                        </li>
                        <li class="media">
                            <div class="media-left">
                                <a href="#" title="Post">
                                    <img class="media-object" src="img/h3.jpeg" alt="Post">
                                </a>
                            </div>
                            <div class="media-body">
                                <h3 class="media-heading"><a href="#" title="Post Title">Post Title</a></h3>
                                <p>Aenean vitae dolor sed purus tempus ullamcorper. Integer urna orci, lacinia ut ornare sit amet, luctus quis est. Ut interdum lorem in mattis lobortis. Maecenas tincidunt justo a lobortis facilisis.</p>
                                <aside class="meta category-meta">
                                    <div class="pull-left">
                                        <div class="arc-comment"><a href="#" title="Comment"><i class="fa fa-comments"></i> 3 Comments</a></div>
                                        <div class="arc-date">10/15/2016</div>
                                    </div>
                                    <div class="pull-right">
                                        <ul class="arc-share">
                                            <li><a href="#" title="Post"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </aside>                                
                            </div>
                        </li>
                        <li class="media">
                            <div class="media-left">
                                <a href="#" title="Post">
                                    <img class="media-object" src="img/h4.jpeg" alt="Post">
                                </a>
                            </div>
                            <div class="media-body">
                                <h3 class="media-heading"><a href="#" title="Post Title">Post Title</a></h3>
                                <p>Aenean vitae dolor sed purus tempus ullamcorper. Integer urna orci, lacinia ut ornare sit amet, luctus quis est. Ut interdum lorem in mattis lobortis. Maecenas tincidunt justo a lobortis facilisis.</p>
                                <aside class="meta category-meta">
                                    <div class="pull-left">
                                        <div class="arc-comment"><a href="#" title="Comment"><i class="fa fa-comments"></i> 8 Comments</a></div>
                                        <div class="arc-date">10/15/2016</div>
                                    </div>
                                    <div class="pull-right">
                                        <ul class="arc-share">
                                            <li><a href="#" title="Post"><i class="fa fa-facebook"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-twitter"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-linkedin"></i></a></li>
                                            <li><a href="#" title="Post"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </aside>                                
                            </div>
                        </li>                        
                    </ul>                    
                </section>
                <aside class="sidebar col-sm-3">
                    <div class="widget">
                        <h4>CATEGORIES</h4>
                        <ul>
                            <%
                            System.out.println("here :" + jsonTopicArray.size());
                            
                            int count = 0;
                        	for(int i=0; i<jsonTopicArray.size(); i++){
                        		JSONObject topic = (JSONObject) jsonTopicArray.get(i);
                        		String tabTopicTitle = topic.get("tab_topic_title").toString();
                        		String tabTopicName = topic.get("tab_topic_name").toString();
                        		String tabTopicLink = topic.get("tab_topic_link").toString();
                        		String tabMasterName = topic.get("tab_menu_name").toString();
                        		
                        		System.out.println(check + target + tabMasterName + tabTopicName);
                        		
                        		if(check.compareTo(tabMasterName) == 0){
                        			String addClass = null;
                        			switch(count){
                        				case 0:
                        					addClass = " class='current'";
                        				default:
                        					addClass = "";
                        			}
                        			System.out.println("here :" + tabTopicName + tabTopicLink + tabMasterName);
                        			out.write("	<li" + addClass + "><a href='" + tabTopicLink + "' title='" + tabTopicTitle + "'>" + tabTopicName + "</a></li>");
                        			/*
                        			out.write(" <ul>");
                        			
                        			for(int j=0; j<jsonTopicSubArray.size(); j++){
                        				JSONObject topicSub = (JSONObject) jsonTopicArray.get(j);
                                		String tabTopicSubTitle = topicSub.get("tab_topic_sub_title").toString();
                                		String tabTopicSubName = topicSub.get("tab_topic_sub_name").toString();
                                		String tabTopicSubLink = topicSub.get("tab_topic_sub_link").toString();
                                		String tabSubName = topicSub.get("tab_topic_name").toString();
                                		
                        			}
                        			out.write(" </ul>");
                        			*/
                        			count++;
                        		}
                        	}
                        	
                            try{
	                        	
                            } catch(Exception e){
                            	e.printStackTrace();
                            }
                        	%>
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
                        <li><a href="#" title="Post"><i class="fa fa-facebook"></i></a></li>
                        <li><a href="#" title="Post"><i class="fa fa-twitter"></i></a></li>
                        <li><a href="#" title="Post"><i class="fa fa-linkedin"></i></a></li>                        
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
                            <li><a href="#" title="Post">HOME</a></li>
                            <li><a href="#" title="Post">MENU ITEM</a></li>
                            <li><a href="#" title="Post">MENU ITEM</a></li>
                            <li><a href="#" title="Post">MENU ITEM</a></li>
                            <li><a href="#" title="Post">MENU ITEM</a></li>
                            <li><a href="#" title="Post">MENU ITEM</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>        
    </footer>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
</body>
</html>