<%@page import="com.hnepri.base.db.dao"%>
<%@ page language="java" import="com.hnepri.commons.Log"  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.hnepri.commons.SpringContextUtil"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.util.HashMap"%>
<%@ page import="java.util.List" %>
<%@ page import="com.hnepri.base.db.dao.*" %>
<% 
      String id=request.getParameter("id");
     CommonMapper commonMapper=(CommonMapper)SpringContextUtil.getBean("commonMapper");
     String sql="select FILEPATH,FILENAME from T_LV_FILE where id="+id;
    List<HashMap> list= commonMapper.RunSql(sql);
     HashMap map=list.get(0);
       String filepath=map.get("FILEPATH").toString();
       String name=map.get("FILENAME").toString();
       String path = Log.getRootPath()+"\\";
       //String path=  getServletContext().getRealPath("/upfiles");
       path = path.replace("\\upfiles","");
       String realpath=path+"\\"+filepath;
       String filename=new String(name.getBytes("gbk"),"ISO-8859-1");
        response.reset();
		response.setContentType("application;charset=UTF-8");     
    	response.setHeader("content-disposition","attachment;filename=" + filename);
    	FileInputStream in = new FileInputStream(realpath);
    	int len = 0;
    	byte buffer[] = new byte[1024];
    	OutputStream sout =  response.getOutputStream();
    	while((len=in.read(buffer))>0){
    		sout.write(buffer,0,len);
    	}
    	sout.flush();
    	sout.close();
    	in.close();
    %>