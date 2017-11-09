<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8" import="java.util.*,goo.thevote"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<style type="text/css">
.dropbtn {
    background-color: #4CAF50;
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
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
}

/* 下拉菜单的链接 */
.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

/* 鼠标移上去后修改下拉菜单链接颜色 */
.dropdown-content a:hover {background-color: #f1f1f1}

/* 在鼠标移上去后显示下拉菜单 */
.dropdown:hover .dropdown-content {
    display: block;
}

/* 当下拉内容显示后修改下拉按钮的背景颜色 */
.dropdown:hover .dropbtn {
    background-color: #3e8e41;
}
#nav {
	weihgt: 500px;
	height: 100px;
	font-family: 宋体;
	font-size: 24px;
	background-color: gray; color：blue;
	background-image: url('thephoto/photo2.jpg');
	z-index: -1;
}

#reg {
    background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;
    
	right: 100px;
	position: absolute;
	top: 30px;
}

#log {
        background-color: #4CAF50;
    color: white;
    padding: 16px;
    font-size: 16px;
    border: none;
    cursor: pointer;


	right: 50px;
	position: absolute;
	top: 30px;
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
	background-color: gray;
}
</style>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>投票</title>
</head>
<body>
	<!-- 导航栏 -->
	<div id="nav" class="one">
		<center>
			<h2 style="color: blue;">投 票 网 站</h2>
		</center>
		<%
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
    <a id="vote_后台管理.jsp?gn="+"wv">查看投票</a>
    <a id="vote_后台管理.jsp?gn="+"mv">发起投票</a>
    <a id="vote_后台管理.jsp?gn="+"sv">禁止投票</a>
    <a id="lv">退出</a>
  </div>
</div>
		

		<%
			} else {
		%>
		<p id="reg"
			onclick="javascript:location.href='vote1_reg.jsp'">注册</p>

		<p id="log"
			onclick="javascript:location.href='vote1_log.jsp'" >登录</p>
		<%
			}
		%>
	</div>
	<input type="text" id="txsea" value="搜索">
	<input type="button" id="btsea" value="搜索">

	<br>
	<br>
	<br>
	<br>
	<center>
		<table id="tbvote" width="1000" border="1">
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
				thevote tv = new thevote();
				//	System.out.println(tv.getvotenum().size());
				for (int i = 0; i < (tv.getvotenum().size() > 5 ? 5 : tv.getvotenum().size()); i++) {
			%>
			<tr>
				<td style="font-size: 30px"><%=tv.getvotetheme().get(i)%></td>
				<td style="font-size: 30px"><%=tv.getvotehost().get(i)%></td>
				<td style="font-size: 30px">截止到<%=tv.getvoteendstime().get(i)%></td>
				<td style="font-size: 30px">
					<button id="vin<%=i%>" style="font-size: 30px">进入投票</button>
				</td>
				<td style="font-size: 30px">
					<button id="vlook<%=i%>" style="font-size: 30px">查看结果</button>
				</td>
			</tr>
			<%
				}
			%>
		</table>
	</center>
	<script language="javascript">
		lv.onclick=function leave() {
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
	<%for (int i = 0; i < (tv.getvotenum().size() > 5 ? 5 : tv.getvotenum().size()); i++) {%>
		vin
	<%=i%>
		.onclick = function() {
			window.location.href = "vote1_vote.jsp?theid="
					+ escape(
	<%=tv.getvotenum().get(i)%>
		);
		}
		vlook
	<%=i%>
		.onclick = function() {
			window.location.href = "vote1_result.jsp?theid="
					+ escape(
	<%=tv.getvotenum().get(i)%>
		);
		}
	<%}%>
		
	</script>
</body>
</html>