package com.mum.carpool.domain;
// Generated Aug 31, 2016 12:45:48 PM by Hibernate Tools 5.1.0.Beta1

/**
 * UserRoles generated by hbm2java
 */
public class UserRoles implements java.io.Serializable {

	private Integer userRoleId;
	private String username;
	private String role;

	public UserRoles() {
	}

	public UserRoles(String username, String role) {
		this.username = username;
		this.role = role;
	}

	public Integer getUserRoleId() {
		return this.userRoleId;
	}

	public void setUserRoleId(Integer userRoleId) {
		this.userRoleId = userRoleId;
	}

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getRole() {
		return this.role;
	}

	public void setRole(String role) {
		this.role = role;
	}

}