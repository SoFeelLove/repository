package com.lxf.base.security.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.lxf.commons.StringUtils;
import com.lxf.repository.service.user.LoginMgrService;

@SuppressWarnings("serial")
@Component
public class SecuritySystemFilter extends HttpServlet implements Filter{
	private LoginMgrService loginMgrService;
	
	private ApplicationContext applicationContext;	

	public ApplicationContext getApplicationContext() {
		return applicationContext;
	}
	public void setApplicationContext(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
	}

	/**
	 * 在配置filter时，可以使用<init-parm>为filter配置一些初始化参数，当web容器实例化Filter对象时，
	 * 调用init方法时，会把封装了filter初始化参数的filterConfig对象传递进来，因此在编写filter时，通过
	 * filterConfig对象的方法，就可以通过getFilterName()获取filter的名字等
	 */
	private FilterConfig config;
	
	/**
	 * 非过滤页面
	 */
	private String excludePackage;
	/**
	 * 未登录跳转页面
	 */
	private String redirectPath; 
	private String includePackage; 
	
	/**
	 * 过滤器是否有效
	 */
	
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain filterChain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		/**
		 * 在过滤列表中，但不在非过滤列表中
		 */
		boolean include = isContains(includePackage, req.getServletPath());
		boolean exclude = isContains(excludePackage, req.getServletPath());
		if (!exclude && include) {
			if (!isFilter(req)) {
				res.setContentType("text/html; charset=utf-8");
				res.sendRedirect(req.getContextPath()+redirectPath);
//				res.getWriter().println("<script language=\"javascript\">alert(\"你还没有登录，请先登录！\");</script>");
				res.getWriter().close();
			}
		}
		filterChain.doFilter(request, response);		
	}
	/**
	 * 是否非过滤 path是否属于非过滤页面
	 * @author lxf
	 * @param excludePath
	 * @param path
	 * @return
	 */
	public boolean isContains(String excludePath,String path){
		for(String str : excludePath.split(";")){
			if (path.endsWith(str)) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * 是否通过过滤
	 * @author lxf
	 * @param request
	 * @return
	 */
	private boolean isFilter(HttpServletRequest request){
		boolean rs = false;
		String user = (String)request.getSession().getAttribute("username");
		//存在此用户名
		if (!StringUtils.isNullOrEmpty(user)) {
			loginMgrService = (LoginMgrService) applicationContext.getBean("loginMgrService");
			rs = loginMgrService.checkUserByUsername(user);			
		}
		return rs;
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		config = filterConfig;
		excludePackage = config.getInitParameter("excludePackage"); 
		includePackage = config.getInitParameter("includePackage");
		redirectPath = config.getInitParameter("redirectPath");
		ServletContext context = config.getServletContext();
		applicationContext = WebApplicationContextUtils.getWebApplicationContext(context);
	}

}
