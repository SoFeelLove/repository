<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8"%>
<%@page import="com.hnepri.commons.StringUtils"%>
<%
//获取唯一标识符
response.setContentType("text/plain; charset=UTF-8");
response.setHeader("Cache-Control", "no-cache,must-revalidate");
String guid = StringUtils.uuid();
%>