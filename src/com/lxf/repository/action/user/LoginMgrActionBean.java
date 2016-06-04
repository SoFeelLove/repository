package com.lxf.repository.action.user;

import java.util.HashMap;
import java.util.List;

import com.lxf.base.action.BaseAction;

public class LoginMgrActionBean extends BaseAction{
	protected String username;
	protected String password;
	protected List<HashMap<String, Object>> result;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public List<HashMap<String, Object>> getResult() {
		return result;
	}
	public void setResult(List<HashMap<String, Object>> result) {
		this.result = result;
	}
	
	
	
}
