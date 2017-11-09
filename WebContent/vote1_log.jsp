<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
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
	right: 75px;
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

	<p id="reg"
			onclick="javascript:location.href='vote1_reg.jsp'">注册</p>

		<p id="log"
			onclick="javascript:location.href='vote1_log.jsp'" >登录</p>
		
	</div>

	<center>
		<table id="table1">
			<br>
			<br>
			<br>
			<tr>
				<td style="font-size: 30px">帐号：
					<div style="display: inline; font-size: 20px">(3-20位字母或数字)</div>
				</td>
			</tr>
			<tr>
				<td><input id="id2" type="text" style="font-size: 30px"></input></td>

			</tr>
			<tr>
				<td style="font-size: 30px">密码：
					<div style="display: inline; font-size: 20px">(6位字母或数字)</div>
				</td>
			</tr>
			<tr>
				<td><input id="pwd2" type="password" style="font-size: 30px"></input></td>
			</tr>


			<tr>
				<td><input type="button"
					style="float: right; position: relative; font-size: 30px;background-color:transparent;"
					onclick="log();" value="登录"></input></td>
			</tr>
		</table>
	</center>

	<script language="javascript">
	function log() {
		var theid = id2.value;
		var thename;
		var thepwd = pwd2.value;
		var xmlhttp;
		if (window.XMLHttpRequest) {
			// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
			xmlhttp = new XMLHttpRequest();
		} else {
			// IE6, IE5 浏览器执行代码
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		if (theid.match('[0-9a-zA-Z]{3,20}')) {

			if (thepwd.match('[0-9a-zA-Z]{6}')) {
				xmlhttp.onreadystatechange = function() {

					if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
						abString = xmlhttp.responseText;
						var getString = new Array();
						getString = abString.split("#");
						if (getString[0] == "0") {
							alert(getString[1] + "登录成功");
							thename = getString[2];
							window.location.href = "vote1.jsp"
									;
						} else if (getString[0] == "1") {
							alert("对不起，该帐号不存在");
						} else if (getString[0] == "2") {
							alert("密码有误");
						}

					}

				}
				xmlhttp.open("GET", "/vote/forlog?theid=" + escape(theid)
						+ "&thepwd=" + escape(thepwd), true);
				xmlhttp.setRequestHeader("logck", document.cookie);
				xmlhttp.send();
			} else {
				alert("密码只能为8位字母或数字");
			}

		} else {
			alert("帐号只能为3位到20位字母或数字");
		}
	}
	</script>
</body>

</html>