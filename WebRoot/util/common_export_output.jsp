<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.net.URLDecoder"%>
<%	
	response.setContentType("application/vns.ms-excel;charset=utf-8");
	response.setHeader("Content-disposition", "attachment; filename="+URLEncoder.encode("Excel","UTF-8")+".xls");
	//Word只需要把contentType="application/msexcel"改为contentType="application/msword"
%>
<html>
<head>
</head>
<style type="text/css"> 
<%@include file="../css/style.css" %>
</style>
<%
String html = (String)request.getAttribute("outputExcelContent");
//System.out.println(html);
%>
<body>
		<%=html%>
</body>
</html>
