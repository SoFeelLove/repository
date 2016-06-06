<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page contentType="application/msexcel"%>

<%
    String title_name =  request.getParameter("title_name");
    response.reset();
	response.setHeader("Content-disposition", "attachment; filename="+URLEncoder.encode(title_name,"UTF-8")+".xls");
    response.setContentType("application/msexcel");
    response.setCharacterEncoding("gbk");
	//Word只需要把contentType="application/msexcel"改为contentType="application/msword"
%>
<html>
<head>
</head>
<style type="text/css"> 
 <%@include file="../css/style.css" %>
</style>
<body >
		<%=request.getParameter("content") %>
</body>
</html>
