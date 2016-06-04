package com.lxf.repository.service.user;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.lxf.base.service.BaseService;

@SuppressWarnings("rawtypes")
@Service
public class LoginMgrService extends BaseService{

	/**
	 * 登录管理
	 * @param username
	 * @param password
	 */
	public String checkLogin(String username, String password) {
		String sqlString =" select * from t_users where u_name = '" +username +"' and u_password = '" +password+"'"
				+" and state = 1";
		List<HashMap<String , Object>> list = commonMapper.runSql(sqlString);
		if (list.size() <= 0) {
			return "error";
		}
		return "success";
	}

	public String modifyPassword(String username, String password) {
		try {
			String sql = "update t_users set u_password = '"+password+"' where u_name='"+username+"'";
			commonMapper.executeSql(sql);
		} catch (Exception e) {
			e.printStackTrace();
			return "fasle";
		}
		return "true";
	}

}
