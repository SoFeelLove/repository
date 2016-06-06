<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String value = request.getParameter("flagType");
%>
<SCRIPT language=JavaScript>

//本窗口用于模态窗口的跳转
		if(window.opener!=undefined)
		{
			window.opener.location.reload();
			window.close();
		}		
		else{
			window.returnValue = <%=request.getParameter("Gmessage")==null?true:request.getParameter("Gmessage") %>;
			window.close();
		}
</SCRIPT>