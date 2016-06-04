<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="java.io.File"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.io.UnsupportedEncodingException"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.math.BigDecimal" %>

<%
/**
	String id = (String)request.getParameter("id");
	DaoManager daoManager = DaoConfig.getLocalDaoManager();
	TItemFileDAO dao = (TItemFileDAO)daoManager.getDao(TItemFileDAO.class);	
	TItemFile upfile = dao.selectByPrimaryKey(new BigDecimal(id));
	String oldName = "";
	try {
	oldName = new String(upfile.getSourcename().getBytes("gb2312"),"iso8859-1");
	//	oldName = URLEncoder.encode(upfile.getSourcename(),"utf-8");
	} catch (UnsupportedEncodingException e1) {
		e1.printStackTrace();
	}
	String path = request.getRealPath("/") +"upfile\\"+ upfile.getDirectpath() + "\\";
	System.out.println(path);
	System.out.println(oldName);
	File file = new File(path+upfile.getThisname());
	if(file.exists())
	{
		FileInputStream in = new FileInputStream(file);
		ServletOutputStream sos = response.getOutputStream();
		int len = 0;
		byte[] b = new byte[1024];
		//response.reset();
		response.setContentType("application/x-msdownload");
		response.setHeader("Content-disposition", "attachment; filename="+oldName);
		while((len = in.read(b)) > 0)
			sos.write(b,0,len);
		sos.close();
		in.close();
		sos=null;
		response.flushBuffer();
		out.clear();
		out=pageContext.pushBody();
	}else
	{
		return;
	}
	*/
	%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>温馨提示</title>
<link href="../css/style.css" rel="stylesheet" type="text/css" />
</head>
<script type="text/JavaScript">
<!--
function doJavaScript() {
	window.close();
}
//-->
</script>
<body onload="dialogWidth=33;dialogHeight=15;dialogTop=(screen.height-document.body.scrollHeight)/2-30;dialogLeft=(screen.width-document.body.scrollWidth)/2">
<br>
	<table width="300"  border="0" align="center" cellpadding="0" cellspacing="0">
		<tr>
			<td height="20"  class="BiaoBg" align="left"> 
			<img src="../images/1_r24_c7.jpg" width="8" height="10"> 操作失败.............................</td>
		</tr>
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="1" cellpadding="0" class="tableBorder">
					<tr>
						<td class="pading" align="left">
							<br><br>

							<div align="center">
								<span class="l2">
									该附件在服务器上不存在！
									<BR><BR>
										<A href="#" onclick="top.stackModelOper(false);"><div align="center" class="formtitle">关闭</div></A>
									
								</span>
							</div>
						</td>
					</tr>		                    
				</table>
			</td>
		</tr>
	</table>
</body>
</html>
	<%
//	}
%>
