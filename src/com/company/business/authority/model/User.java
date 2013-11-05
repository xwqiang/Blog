package com.company.business.authority.model;

import org.springframework.stereotype.Component;

public class User {
	private int uid;
	private String uname;
	private String upwd;
	private String priority;
	private String portrait;
	private String insert_time;
	private String update_time;
	public int getUid() {
		return uid;
	}
	public void setUid(int uid) {
		this.uid = uid;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUpwd() {
		return upwd;
	}
	public void setUpwd(String upwd) {
		this.upwd = upwd;
	}
	public String getPriority() {
		return priority;
	}
	public void setPriority(String priority) {
		this.priority = priority;
	}
	public String getPortrait() {
		return portrait;
	}
	public void setPortrait(String portrait) {
		this.portrait = portrait;
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
	
}
