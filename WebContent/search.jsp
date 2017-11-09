<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.util.*,goo.thevote,goo.search"%>
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
	padding: 25px;
	font-size: 10px;
	border: none;
	cursor: pointer;
	right: 80px;
	position: absolute;
	top: 8px;
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
			<a style="color: white;font-size: 50px;" href="javascript:location.href='vote1.jsp'">投  票  网  站</a>
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
		<p id="reg" onclick="javascript:location.href='vote1_reg.jsp'">注册</p>

		<p id="log" onclick="javascript:location.href='vote1_log.jsp'">登录</p>
		<%
			}
		%>
	</div>
<form action="search.jsp" method="post">
	<input type="text" name="txsea"id="txsea" value="搜索">
	<input type="submit" id="btsea" value="搜索">
</form>
	<br>
	<br>
	<br>
	<br>
	<table id="tbvote" width="1000" border="1">
	<tr>
	
			<%
			String sea="***********";
			if(request.getParameter("txsea")!=null){
				sea=new String(request.getParameter("txsea").getBytes("ISO8859_1"),"utf-8");
			}
			System.out.println(sea);
			search sc=new search(sea);
			%></tr>
			<tr>
				<td style="font-size: 30px">投票主题</td>
				<td style="font-size: 30px">发起人</td>
				<td style="font-size: 30px">结束时间</td>
				<td style="font-size: 30px">进入投票</td>
				<td style="font-size: 30px">查看结果</td>
			</tr>
			<%
				//	System.out.println(tv.getvotenum().size());
					for (int i = 0; i < sc.getvotenum().size() ; i++) {
			%>
			<tr>
				<td style="font-size: 30px"><%=sc.getvotetheme().get(i)%></td>
				<td style="font-size: 30px"><%=sc.getvotehost().get(i)%></td>
				<td style="font-size: 30px">截止到<%=sc.getvoteendstime().get(i)%></td>
			<td style="font-size: 30px">
				<% 
				if(sc.getvotecanvote().get(i).equals("允许")){ %>
					<button id="vin" style="font-size: 30px"onclick="oin<%=i%>();">进入投票</button>
				<%}else {
					%>
					<p style="font-size: 30px">禁止投票</p>
					<%
				} %></td>
				<td style="font-size: 30px">
					<button id="vlook<%=i%>" style="font-size: 30px"onclick="vlook<%=i%>();">查看结果</button>
				</td>
			</tr>
			<%
				}
				
			%>
		</table>
<script language="javascript">
	var projectnum=1;
		function aone() {
			projectnum++;
			var theip_2 = document.createElement("input");
			theip_2.style = "font-size:30px";
			theip_2.type = "test";
			
			
			var thep_2 = document.createElement("td");
			thep_2.appendChild(theip_2);
			var theip_1 = document.createTextNode("项目"+projectnum+"：");

			var thep_1 = document.createElement("td");
			thep_1.style = "font-size:30px";
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
	for (int i = 0; i < sc.getvotenum().size() ; i++) {%>
		function oin<%=i%>() {
			window.location.href = "vote1_vote.jsp?theid="
					+ escape(
	<%=sc.getvotenum().get(i)%>
		);
		}
		function ostop<%=i%> () {
			 var x=ostop<%=i%>.value;
			 alert(x);
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
				alert("projectnum=<%=tv.getvotenum().get(i)%>");
				xmlhttp.open("GET", "/vote/hadlog?gn=" + escape("sv")+"&projectnum="+escape(<%=sc.getvotenum().get(i)%>)+"&panduan="+panduan, true);
				xmlhttp.send();
				
			}
	 function vlook<%=i%> () {
			window.location.href = "vote1_result.jsp?theid="
					+ escape(<%=sc.getvotenum().get(i)%>);
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
			alert(athethemedata);
			for(var i=1;i<=projectnum;i++){
				
				votedataString+="&theip"+i+"2="+document.getElementById("theip"+i+"2").value;
			
			}
			alert(votedataString);
			xmlhttp.open("GET", votedataString, true);
			xmlhttp.send();
		}
	</script>
</body>
</html>