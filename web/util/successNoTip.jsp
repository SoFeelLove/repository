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
<s:if test="Gjs!=null && Gjs != ''">
	<s:property value="Gjs"/>
</s:if>
<s:else>
	history.back();
</s:else>
</script>
<body>
</body>
</html>
