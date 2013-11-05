package com.company.business.authority.model;

import java.util.List;

public class Role {
	private int rid;
	private String rname;
	private String desc;
	private String insert_time;
	private String update_time;
	private List<Module> modulesList;
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public String getRname() {
		return rname;
	}
	public void setRname(String rname) {
		this.rname = rname;
	}
	public String getDesc() {
		return desc;
	}
	public void setDesc(String desc) {
		this.desc = desc;
	}
	public String getInsert_time() {
		return insert_time;
	}
	public void setInsert_time(String insertTime) {
		insert_time = insertTime;
	}
	public String getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(String updateTime) {
		update_time = updateTime;
	}
	public List<Module> getModulesList() {
		return modulesList;
	}
	public void setModulesList(List<Module> modulesList) {
		this.modulesList = modulesList;
	}
	
}
