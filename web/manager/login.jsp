<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<!-- 禁止浏览器从本地缓存中调阅页面。-->
<meta http-equiv="pragram" content="no-cache">
<!--网页不保存在缓存中，每次访问都刷新页面。-->
<meta http-equiv="cache-control" content="no-cache, must-revalidate">
<!--同上面意思差不多，必须重新加载页面-->
<!--网页在缓存中的过期时间为0，一旦网页过期，必须从服务器上重新订阅-->
<meta http-equiv="expires" content="0">

<title></title>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

html,body,#box {
	height: 100%;
	font: small/1.5 "宋体", serif;
	font-size: 12px;
}

body {
	text-align: center;
}

#box {
	text-align: left;
	background: #666;
	display: table;
	width: 80%;
	margin: 0 auto;
	position: relative;
}

#box>div {
	display: table-row;
}

#header{
/* 	background: #fcc; */
	height: 56px;
	vertical-align: bottom;
}
#footer {
/* 	background: #fcc; */
	height: 42px;
	vertical-align: bottom;
}

#main {
	background: #ccf;
}

#main,#wrap {
	display: table-cell;
	background: #ffc;
	vertical-align: middle;
}

#input_text {
	text-align: center;
}
</style>
<!--[if IE]>   
<style type="text/css">   
#header,   
#footer {   
width:100%;   
z-index:3;   
position:absolute;   
}   
#footer {   
bottom:0;   
}   
#main {   
height:100%;   
z-index:1;   
position:relative;   
}   
#main,#wrap {   
position:absolute;   
top:50%;   
width:100%;   
text-align:left;   
}   
#main,#text {   
position:relative;   
width:100%;   
top:-50%;   
background:#ccc;   
}   
</style>   
<![endif]-->
</head>
<body>
	<div id="box">
		<div id="header" style="background:url(manager/images/login-top-bg.gif)">
			<div style="height:56px;background: url(manager/images/logo_blue.gif) no-repeat">
			</div>
		</div>
		<div id="main">
			<div id="wrap" style="background:url(manager/images/login_bg.png)">
				<div id="text">
				<form action="user/loginMgr!loginMgr.action" method="post">
					<table id="input_text" style="margin: 0 auto;font-size: 12px;">
						<tr>
							<td>用户名：</td>
							<td><input type="text" id="username" name="username"></td>
						</tr>
						<tr>
							<td>密   码：</td>
							<td><input type="password" id="password" name="password"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td align="left">
								<input type="submit" value="登录">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								&nbsp;&nbsp;
								<input type="reset" value="重置">
							</td>
						</tr>
					</table>
					</form>
				</div>
			</div>
		</div>
		<div id="footer" style="background: url(manager/images/footer_bg.png)">
			<p style="text-align:center;line-height:42px;">Copyright © 2015-*** 625456668@qq.com<p>
		</div>
	</div>
</body>
</html>
