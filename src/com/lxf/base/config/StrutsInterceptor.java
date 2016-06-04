package com.lxf.base.config;


import java.util.Map;
import java.util.Map.Entry;

import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;

/**
 * 根据访问地址，自动映射jsp StrutsInterceptor.java
 * 
 * @author lxf
 * @time 2015-7-30下午1:41:04
 */
@SuppressWarnings("serial")
public class StrutsInterceptor extends AbstractInterceptor {
	/**
	 * 拦截方法
	 */
	@Override
	public String intercept(ActionInvocation arg0) throws Exception {
		String actionName = arg0.getProxy().getActionName();
		String method = arg0.getProxy().getMethod();
		arg0.getStack().setParameter("jspFileName", actionName + "_" + method);
		return arg0.invoke();
	}

	/**
	 * 防止sql注入，配合使用commonmapper对象使用，否则会造成'影响sql执行
	 * 
	 * @param arg0
	 */
	private void safeReplace(ActionInvocation arg0) {
		Map<String, Object> result = arg0.getInvocationContext()
				.getParameters();
		for (Entry<String, Object> obj : result.entrySet()) {
			if (obj.getValue() != null) {
				String[] tmp = (String[]) obj.getValue();
				for (int i = 0; i < tmp.length; i++) {
					if (tmp[i].contains("'")) {
						tmp[i] = tmp[i].replace("'", "");
					}
				}
			}
		}
	}

}
