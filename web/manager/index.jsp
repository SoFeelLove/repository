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
<title>管理中心</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
</head>

<frameset rows="64,*,38" frameborder="NO" border="0" framespacing="0">
	<frame src="manager/header.jsp" noresize="noresize" frameborder="NO"
		name="topFrame" scrolling="no" marginwidth="0" marginheight="0"
		/>
	<frameset cols="200,*" id="frame">
		<frame src="manager/menu.jsp" name="leftFrame" noresize="noresize"
			marginwidth="0" marginheight="0" frameborder="0" scrolling="no"
			target="main" />
		<frame src="manager/content.jsp" name="main" marginwidth="0" marginheight="0"
			frameborder="0" scrolling="auto" target="_self" />
	</frameset>
	<frame src="manager/footer.jsp" noresize="noresize" frameborder="NO"
		name="footerFrame" scrolling="no" marginwidth="0" marginheight="0"/>
	<noframes>
		<body></body>
	</noframes>
</html>
