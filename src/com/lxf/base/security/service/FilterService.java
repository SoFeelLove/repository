package com.lxf.base.security.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.lxf.base.dao.CommonMapper;
import com.lxf.base.dao.CommonMapperImp;
import com.lxf.repository.service.user.LoginMgrService;

/**
 * 
 * FilterService.java
 * @author lxf; 2015-11-3 上午11:24:34
 */
@Service
public class FilterService {
	@Autowired
	protected CommonMapperImp commonMapper;
	@Autowired
	private LoginMgrService loginMgrService;
	
	/**
	 * 验证访问每个URL的权限
	 * @author lxf
	 * @param httpServletRequest
	 * @param httpServletResponse
	 * @param httpSession
	 * @return
	 * @throws IOException
	 */
	@SuppressWarnings("unchecked")
	public boolean checkSecurity(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, HttpSession httpSession) throws IOException {
		// 将Ajax.action 与 .action 合并到一起
		String path = httpServletRequest.getServletPath().replace("Ajax.action", ".action");
		Logger logger = Logger.getLogger(FilterService.class);
		logger.info("权限验证："+path);
		return true;
	}
}
