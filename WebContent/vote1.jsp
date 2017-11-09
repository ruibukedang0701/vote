<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.util.*,goo.thevote"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style type="text/css">
.dropbtn {
	background-color: gray;
	color: white;
	padding: 16px;
	font-size: 16px;
	border: none;
	cursor: pointer;
}

/* 容器 <div> - 需要定位下拉内容 */
.dropdown {
	position: relative;
	display: inline-block;
}

/* 下拉内容 (默认隐藏) */
.dropdown-content {
	display: none;
	position: absolute;
	background-color: #f9f9f9;
	min-width: 160px;
	box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
}

/* 下拉菜单的链接 */
.dropdown-content a {
	color: black;
	padding: 12px 16px;
	text-decoration: none;
	display: block;
}

/* 鼠标移上去后修改下拉菜单链接颜色 */
.dropdown-content a:hover {
	background-color: #f1f1f1
}

/* 在鼠标移上去后显示下拉菜单 */
.dropdown:hover .dropdown-content {
	display: block;
}

/* 当下拉内容显示后修改下拉按钮的背景颜色 */
.dropdown:hover .dropbtn {
	background-color: #888888;
}

#nav {
	weihgt: 500px;
	height: 100px;
	font-family: 宋体;
	font-size: 24px;
	background-color: gray; color：blue;
	background-image: url('thephoto/p1.jpeg');
	z-index: -1;
}

#reg {

		background-color: gray;
	color: white;
	padding: 23px;
	font-size: 10px;
	border: none;
	cursor: pointer;
	right: 75px;
	position: absolute;
	top: 6px;
}
#reg:hover #reg {
	background-color: white;
}

#log {

	background-color: gray;
	color: white;
	padding: 25px;
	font-size: 10px;
	border: none;
	cursor: pointer;
	right: 8px;
	position: absolute;
	top: 8px;
}

#txsea {
	right: 150px;
	float: right;
	position: relative;
	top: 30px;
	font-size: 20px
}

#btsea {
	float: right;
	right: -150px;
	position: relative;
	top: 30px;
	font-size: 20px
}

#all {
	background-color: gray;
}

#tbvote {
	align: "center";
	border-style: solid;
	border-width: 1px;
	border-color: blue;

	background-image: url('thephoto/p2.jpeg');
	
}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>投票</title>
</head>
<body >
	<!-- 导航栏 -->
	<div id="nav" class="one">
		<center>
			<a style="color: white;font-size: 50px;" href="javascript:location.href='vote1.jsp'"onclick="goback();">投  票  网  站</a>
		</center>
		<%
			thevote tv = new thevote();
			boolean hadlog = false;
			String[] tem = new String[]{};
			Cookie[] cook = request.getCookies();
			if (cook != null) {
				for (int i = 0; i < cook.length; i++) {
					if (cook[i].getName().equals("logck")) {
						tem = cook[i].getValue().split("#");

					}
				}
			}
			if (tem.length > 0) {
				hadlog = true;
			}
			if (hadlog) {
		%>
		<div class="dropdown" id="log">
			<button class="dropbtn"><%=tem[1]%></button>
			<div class="dropdown-content">
				<a id="wv"onclick="wv();">查看投票</a> <a id="mv"onclick="mv();">发起投票</a> <a id="sv"onclick="sv();">禁止投票</a> <a
					id="lv"onclick="lv();">退出</a>
			</div>
		</div>


		<%
			} else {
		%>
		<p id="reg" style="font-size: 15px"onclick="javascript:location.href='vote1_reg.jsp'">注册</p>

		<p id="log" style="font-size: 15
		px"onclick="javascript:location.href='vote1_log.jsp'">登录</p>
		<%
			}
		%>
	</div>
<form action="search.jsp" method="post">
	<input type="text"name="txsea" id="txsea" value="搜索">
	<input type="submit" id="btsea" value="搜索">
</form>

	<br>
	<br>
	<br>
	<br>
	<center>
	
		<table id="tbvote" width="1000" border="1">
			<%
				if (session.getAttribute("gn") != null && !session.getAttribute("gn").equals("")) {
	if (session.getAttribute("gn").equals("wv")) {

						Vector usenum = (Vector) session.getAttribute("usenum");
			%>
			
						<tr>
				<td style="font-size: 30px">主题</td>
				<td style="font-size: 30px">开始时间</td>
				<td style="font-size: 30px">结束时间</td>
				<td style="font-size: 30px">选项类型</td>
				<td style="font-size: 30px">投票允许</td>
			</tr>
			<%
				for (int i = 0; i < usenum.size(); i++) {
			%>
			<tr>
				<td style="font-size: 30px"><%=((Vector) session.getAttribute("usetheme")).get(i)%></td>
				<td style="font-size: 30px"><%=((Vector) session.getAttribute("usestarttime")).get(i)%></td>
				<td style="font-size: 30px"><%=((Vector) session.getAttribute("useendtime")).get(i)%></td>
				<td style="font-size: 30px"><%=((Vector) session.getAttribute("usetype")).get(i)%></td>
				<td style="font-size: 30px"><%=((Vector) session.getAttribute("usecanvote")).get(i)%></td>
		<td><button style="font-size: 30px;background-color:transparent;"onclick="olook<%=i%>();">查看该投票</button></td>
			</tr>
			<%
				}

					} else if (session.getAttribute("gn").equals("mv")) {
			%><tr>
				<td style="font-size: 30px">主题：</td>
				<td><input name="athetheme"id="athetheme" type="text" style="font-size: 30px;background-color:transparent;">
				<td><button id="ok" style="font-size: 30px;background-color:transparent;"onclick="ok();">提交</td>


				</td>
			</tr>
			<tr>
				<td style="font-size: 30px">截止時間：</td>
				<td><input name="atheendtime" id="atheendtime"type="text" style="font-size: 30px;background-color:transparent;">
				<td><button id="addone" style="font-size: 30px;background-color:transparent;"onclick="aone();">增加选项</td>

				</td>
			</tr>
			<tr>
				<td style="font-size: 30px">投票類型</td>
				<td>
				<select name="athetype"id="athetype"style="font-size: 30px;background-color:transparent;">
				<option style="font-size: 30px"value="单选">单选</option>
				<option style="font-size: 30px"value="多选">多选</option>
				</select>
				</td>
				<td><button id="delone" style="font-size: 30px;background-color:transparent;"onclick="done();">删除选项</td>


			</tr>
			<tr>
				<td style="font-size: 30px">选项1：</td>
				<td><input name="theip12"id="theip12" type="test" style="font-size: 30px;background-color:transparent;">
				</td>
			</tr>


			<%
				} else if (session.getAttribute("gn").equals("sv")) {

					Vector usenum = (Vector) session.getAttribute("usenum");
		%>
		
					<tr>
			<td style="font-size: 30px">主题</td>
			<td style="font-size: 30px">开始时间</td>
			<td style="font-size: 30px">结束时间</td>
			<td style="font-size: 30px">选项类型</td>
			<td style="font-size: 30px">投票允许</td>
		</tr>
		<%
			for (int i = 0; i < usenum.size(); i++) {
		%>
		<tr>
			<td style="font-size: 30px"><%=((Vector) session.getAttribute("usetheme")).get(i)%></td>
			<td style="font-size: 30px"><%=((Vector) session.getAttribute("usestarttime")).get(i)%></td>
			<td style="font-size: 30px"><%=((Vector) session.getAttribute("useendtime")).get(i)%></td>
			<td style="font-size: 30px"><%=((Vector) session.getAttribute("usetype")).get(i)%></td>
			<td style="font-size: 30px"><%=((Vector) session.getAttribute("usecanvote")).get(i)%></td>
	<td><button name="ostop<%=i%>"id="ostop<%=i%>"style="font-size: 30px;background-color:transparent;"onclick="ostop<%=i%>();">禁止/允許投票</button></td>
	<td><button style="font-size: 30px;background-color:transparent;"onclick="olook<%=i%>();">查看投票</button></td>
		</tr>
		<%
			}	
					
				
				}
				} else {
			%>
			<tr>
				<td style="font-size: 30px; color: blue">最近5次投票：</td>
			</tr>
			<tr>
				<td style="font-size: 30px">投票主题</td>
				<td style="font-size: 30px">发起人</td>
				<td style="font-size: 30px">结束时间</td>
				<td style="font-size: 30px">进入投票</td>
				<td style="font-size: 30px">查看结果</td>
			</tr>
			<%
				//	System.out.println(tv.getvotenum().size());
					for (int i = 0; i < (tv.getvotenum().size() > 5 ? 5 : tv.getvotenum().size()); i++) {
			%>
			<tr>
				<td style="font-size: 30px"><%=tv.getvotetheme().get(i)%></td>
				<td style="font-size: 30px"><%=tv.getvotehost().get(i)%></td>
				<td style="font-size: 30px">截止到<%=tv.getvoteendstime().get(i)%></td>
			<td style="font-size: 30px">
				<% 
				if(tv.getvotecanvote().get(i).equals("允许")){ %>
					<button id="vin" style="font-size: 30px;background-color:transparent;"onclick="oin<%=i%>();">进入投票</button>
				<%}else {
					%>
					禁止投票
					<%
				} %></td>
				<td style="font-size: 30px">
					<button id="vlook<%=i%>" style="font-size: 30px;background-color:transparent;"onclick="vlook<%=i%>();">查看结果</button>
				</td>
			</tr>
			<%
				}
				}
			%>
		</table>
	</center>
	<script language="javascript">
	var projectnum=1;
	function aone() {
		projectnum++;
		var theip_2 = document.createElement("input");
		theip_2.style = "font-size:30px;background-color:transparent;";
		theip_2.type = "test";
		
		
		var thep_2 = document.createElement("td");
		thep_2.appendChild(theip_2);
		var theip_1 = document.createTextNode("项目"+projectnum+"：");

		var thep_1 = document.createElement("td");
		thep_1.style = "font-size:30px;background-color:transparent;";
		thep_1.appendChild(theip_1);
		var para = document.createElement("tr");
		para.appendChild(thep_1);
		para.appendChild(thep_2);
		var element = document.getElementById("tbvote");
		element.appendChild(para);
		
		theip_2.name="theip"+projectnum+"2";
		theip_1.name="theip"+projectnum+"1";
		thep_2.name="thep"+projectnum+"2";
		thep_1.name="thep"+projectnum+"1";
		para.name="tp"+projectnum+"1";
		
		theip_2.id="theip"+projectnum+"2";
		theip_1.id="theip"+projectnum+"1";
		thep_2.id="thep"+projectnum+"2";
		thep_1.id="thep"+projectnum+"1";
		para.id="tp"+projectnum+"1";
	}
	
 function done(){
		var el = document.getElementById("tp"+projectnum+"1");
		 el.parentNode.removeChild(el);
		//$("tp"+projectnum+"1").remove();
		projectnum--;
	}
function wv() {
		if (window.XMLHttpRequest) {
			// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp = new XMLHttpRequest();
		} else {
			// IE6, IE5 浏览器执行代码
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {

			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				window.location.href = "vote1.jsp";
			}

		}
		xmlhttp.open("GET", "/vote/hadlog?gn=" + escape("wv"), true);
		xmlhttp.send();
	}
	function mv() {
		if (window.XMLHttpRequest) {
			// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp = new XMLHttpRequest();
		} else {
			// IE6, IE5 浏览器执行代码
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {

			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				window.location.href = "vote1.jsp";
				
			}

		}
		xmlhttp.open("GET", "/vote/hadlog?gn=" + escape("mv"), true);
		xmlhttp.send();
	}
	 function sv() {
		if (window.XMLHttpRequest) {
			// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp = new XMLHttpRequest();
		} else {
			// IE6, IE5 浏览器执行代码
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {

			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				window.location.href = "vote1.jsp";
			}

		}
		xmlhttp.open("GET", "/vote/hadlog?gn=" + escape("sv"), true);
		xmlhttp.send();
	}
	function lv() {
		if (window.XMLHttpRequest) {
			// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp = new XMLHttpRequest();
		} else {
			// IE6, IE5 浏览器执行代码
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {

			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				window.location.href = "vote1.jsp";
			}

		}
		xmlhttp.open("GET", "/vote/forlog", true);
		xmlhttp.send();
	}
<%
for (int i = 0; i < tv.getvotenum().size() ; i++) {%>
	function oin<%=i%>() {window.location.href = "vote1_vote.jsp?theid=" + <%=tv.getvotenum().get(i)%>;}
	
 function vlook<%=i%> () {
		window.location.href = "vote1_result.jsp?theid="
				+ escape(<%=tv.getvotenum().get(i)%>);
	}
<%}%>
<% 
int olooknum=0;
if(session.getAttribute("usenum")!=null){
	olooknum=((Vector) session.getAttribute("usenum")).size() ;
}
for (int i = 0; i < olooknum; i++) {%> 
 function olook<%=i%> () {
		window.location.href = "vote1_result.jsp?theid="
			+ escape(<%=((Vector) session.getAttribute("usenum")).get(i)%>);
			}
 function ostop<%=i%> () {
	 var x=ostop<%=i%>.value;
	 var panduan;
	 if (window.XMLHttpRequest) {
			// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp = new XMLHttpRequest();
		} else {
			// IE6, IE5 浏览器执行代码
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {

			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				ostop<%=i%>.value="允许投票"
				window.location.href = "vote1.jsp?gn="+" ";
			}

		}
		alert("projectnum=<%=((Vector) session.getAttribute("usenum")).get(i)%>");
		xmlhttp.open("GET", "/vote/hadlog?gn=" + escape("sv")+"&projectnum="+<%=((Vector) session.getAttribute("usenum")).get(i)%>+"&panduan="+panduan, true);
		xmlhttp.send();
		
	}
 <%}%>
	function ok(){
		var athethemedata=athetheme.value;
		var atheendtimedata=atheendtime.value;
		var athetypedata=athetype.value;
		if (window.XMLHttpRequest) {
			// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp = new XMLHttpRequest();
		} else {
			// IE6, IE5 浏览器执行代码
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {

			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				window.location.href = "vote1.jsp";
			}

		}
		var votedataArray=new Array();
		var votedataString="/vote/hadlog?gn=" + escape("mv")+"&projectnum="+ escape(projectnum);
		votedataString+="&athetheme="+athethemedata+"&atheendtime="+escape(atheendtimedata)+"&athetype="+athetypedata;
		
		for(var i=1;i<=projectnum;i++){
			
			votedataString+="&theip"+i+"2="+document.getElementById("theip"+i+"2").value;
		
		}
		
		xmlhttp.open("GET", votedataString, true);
		xmlhttp.send();
	}
	function goback(){
		if (window.XMLHttpRequest) {
			// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp = new XMLHttpRequest();
		} else {
			// IE6, IE5 浏览器执行代码
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {

			if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
				window.location.href = "vote1.jsp";
			}

		}
		xmlhttp.open("GET", "/vote/hadlog?goback=goback", true);
		xmlhttp.send();
		
	}
</script>
</body>
</html>