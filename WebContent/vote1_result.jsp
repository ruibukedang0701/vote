<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.util.*,goo.thevote,goo.content"%>
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
	<input type="text"name="txsea" id="txsea" value="搜索">
	<input type="submit" id="btsea" value="搜索">
</form>
	<br>
	<br>
	<br>
	<br>
<center>
	<table id="tbvote" width="500" border="1">
		<%
			String tid = "";
			int tidi = -1;
			if (request.getParameter("theid") != null) {
				tid = request.getParameter("theid");
			}
			content ct = new content(tid);
			for (int i = 0; i < tv.getvotenum().size(); i++) {
				if (tid.equals(tv.getvotenum().get(i))) {
					tidi = i;
					break;
				}
			}
			if (tidi >= 0) {
		%>
			<tr>
				<td style="font-size: 30px; color: blue">投票主题：</td>
				<td style="font-size: 30px; color: blue"><%=tv.getvotetheme().get(tidi)%>
				</td>
			</tr>
			<td style="font-size: 30px; color: blue">投票发起人：</td>
			<td style="font-size: 30px; color: blue">
				<%=tv.getvotehost().get(tidi)%>
			</td>
			</tr>
			<td style="font-size: 30px; color: blue" >投票截止时间：</td>
			<td style="font-size: 30px; color: blue">截止到
				<%=tv.getvoteendstime().get(tidi)%>
			</td>
			</tr>
			</td>
			</tr>
			<td style="font-size: 30px; color: blue" >选项</td>
			<td style="font-size: 30px; color: blue">票数
			</td>
			</tr>
			<%
				for (int i = 0; i < ct.getvotenum().size(); i++) {
			%>

			<tr>
				<td>
					<div style="font-size: 30px; color: blue"><%=ct.getvoteproject().get(i)%></div>
				</td>
				<td>
					<div style="font-size: 30px; color: blue"><%=ct.getvoteamount().get(i)%></div>
				</td>
			</tr>
			<%
				}
				}
				//	System.out.println(tv.getvotenum().size());
			%>
		</table>
	</center>
	<script language="javascript">
		function leave() {
			if (window.XMLHttpRequest) {
				// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
				xmlhttp = new XMLHttpRequest();
			} else {
				// IE6, IE5 浏览器执行代码
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange = function() {

				if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
					abString = xmlhttp.responseText;
					var getString = new Array();
					getString = abString.split("#");
					window.location.href = "vote1.jsp";
				}

			}
			xmlhttp.open("GET", "/vote/forlog", true);
			xmlhttp.send();
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
	</script>
</body>
</html>