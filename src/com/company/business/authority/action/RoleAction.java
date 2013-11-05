package com.company.business.authority.action;

import java.util.List;

import javax.annotation.Resource;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.apache.struts2.convention.annotation.Result;
import org.apache.struts2.convention.annotation.Results;

import com.company.business.authority.model.Module;
import com.company.business.authority.model.Role;
import com.hskj.common.action.BaseAction;
import com.hskj.common.service.SimpleService;

@ParentPackage(value = "struts-default")
@Namespace(value = "/")
@Action(value="roleAction")
@Results( { @Result(name="show", location ="/plateForm/showManager/role/roleShow.jsp"),
			@Result(name="add", location="/plateForm/showManager/role/roleAdd.jsp"),
			@Result(name="modify", location="/plateForm/showManager/role/roleModify.jsp")
		})
public class RoleAction extends BaseAction{
	private static final long serialVersionUID = 1L;
	Role role ;
	Module module;
	@Resource(name="simpleService")
	private SimpleService simpleService;
	public String show(){
		List<Role> rolesList =getAllRoleList();
		super.setRequestAttribute("roleList", rolesList);
		return "show";
	}
	public String add(){
		return "add";
	}
	public String modify(){
		Role r = (Role)simpleService.findObject(role, "roleManager.getRoleById");
		super.setRequestAttribute("role", r);
		return "modify";
	}
	@SuppressWarnings("unchecked")
	private List<Role> getAllRoleList(){
		if(role==null){
			role = new Role();
		}
		List<Role> roleList = (List<Role>) simpleService.selectObjectByCondition(role, "roleManager.getRoleList");
		List<Module> moduleList = (List<Module>)simpleService.selectObjectByCondition(module, "roleManager.getModuleList");
		for(Role r:roleList){
			for(Module m: moduleList){
				if(m.getRid()==r.getRid()){
					r.getModulesList().add(m);
				}
			}
		}
		return roleList;
	}
	
	public SimpleService getSimpleService() {
		return simpleService;
	}
	public void setSimpleService(SimpleService simpleService) {
		this.simpleService = simpleService;
	}
	
}
