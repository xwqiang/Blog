package com.hskj.business.core;

import java.util.Map;

import com.company.business.authority.model.User;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.MethodFilterInterceptor;

/**
 * 类名：AuthorityInterceptor
 * 作者：王文朝 mmc
 * 日期：2012-11-5 上午11:26
 */
public class AuthorityInterceptor extends MethodFilterInterceptor
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 7202690463392954316L;


  
	@SuppressWarnings("unchecked")
	@Override
	protected String doIntercept(ActionInvocation invocation) throws Exception {
		ActionContext ctx = invocation.getInvocationContext();
		Map session = ctx.getSession();
	
		User user = (User)session.get("user");
		if (user != null)
		{
			return invocation.invoke();
		}
	  	return "outsys";
	}
}
