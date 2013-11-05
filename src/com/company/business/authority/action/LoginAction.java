package com.company.business.authority.action;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.company.business.authority.model.User;
import com.hskj.common.action.BaseAction;
import com.hskj.common.service.SimpleService;

@Namespace("/")
@Action(value="loginAction")
@Results({
	@Result(name="login",location="/plateForm/login/index.jsp"),
	@Result(name="regist",location="/plateForm/login/index.jsp")
})
public class LoginAction extends BaseAction{
	User user;
	@Resource(name="simpleService")
	private SimpleService simpleService;
	public String login(){
		User u = null;
		u =(User) simpleService.findObject(user, "login.login");
		if(u==null){
			return "fail";
		}else{
			super.setSessionAttribute("user", user);
			return "login";
		}
	}
	public String regist(){
		if(user==null){
			return "error";
		}else{
			simpleService.saveObject(user, "login.regist");
			return "regist";
		}
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
}
