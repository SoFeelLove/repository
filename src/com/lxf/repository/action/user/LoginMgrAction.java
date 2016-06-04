package com.lxf.repository.action.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.lxf.repository.service.user.LoginMgrService;

@SuppressWarnings("serial")
@Controller("/user/loginMgrAction")
@Scope("prototype")
public class LoginMgrAction extends LoginMgrActionBean{
	@Autowired
	private LoginMgrService loginMgrService;
	
	public String checkLogin(){
		if (checkSession()) {
			return "success";
		}else {
			String result = loginMgrService.checkLogin(username,password);
			if (result.equals("success")) {
				getSession().put("username", username);
			}
			return result;
		}
	}
	
	private boolean checkSession(){
		Object seesionUsername = getSession().get("username");
		if (seesionUsername != null && seesionUsername.equals(username)) {
			return true;
		}
		return false;
	}
	
	public void modifyPassword(){
		AjaxPrint(loginMgrService.modifyPassword(username,password));		
	}
	
	public String loginOut(){
		getSession().clear();
		return "loginOut";
	}
	
}
