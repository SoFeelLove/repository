<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>温馨提示</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>

<script type="text/JavaScript">
function doJavaScript() {
	<s:if test="Gjs!=null && Gjs != ''">
		<s:property value="Gjs"/>
	</s:if>
	<s:else>
		history.back();
	</s:else>
  }
<%
String msg = (String)request.getAttribute("Gmessage");
%>
$(function() {
	$("#showSuc").dialog({
		title : '信息',
		autoOpen: true,
		height: 200,
		width: 200,
		draggable : false,
		modal: true
	});
	$('.ui-dialog-titlebar').removeClass("ui-widget-header");
	$('.ui-dialog').css({border:'1px #ABE2DA solid'});
});
</script>
<body>
<div id="showSuc">
<table style="width: 100%;height: 100%;">
<tr><td align="center"><%=msg%>!</td></tr>
<tr><td align="center"><input type="button" value="确定" class="yshi1" onclick="doJavaScript();"/></td></tr>
</table>
</div>
</body>
</html>