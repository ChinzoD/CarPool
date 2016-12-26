package com.mum.carpool.domain;
// Generated Aug 30, 2016 4:24:04 PM by Hibernate Tools 5.1.0.Beta1

import java.util.Date;

/**
 * Comments generated by hbm2java
 */
public class Comments implements java.io.Serializable {

	private Integer commentid;
	private int userid;
	private User user;
	private int postid;
	private String comment;
	private Date datecreated;
	private Date dateupdated;

	public Comments() {
	}

	public Comments(int userid, int postid, String comment, Date datecreated, Date dateupdated) {
		this.userid = userid;
		this.postid = postid;
		this.comment = comment;
		this.datecreated = datecreated;
		this.dateupdated = dateupdated;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public Integer getCommentid() {
		return this.commentid;
	}

	public void setCommentid(Integer commentid) {
		this.commentid = commentid;
	}

	public int getUserid() {
		return this.userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	public int getPostid() {
		return this.postid;
	}

	public void setPostid(int postid) {
		this.postid = postid;
	}

	public String getComment() {
		return this.comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getDatecreated() {
		return this.datecreated;
	}

	public void setDatecreated(Date datecreated) {
		this.datecreated = datecreated;
	}

	public Date getDateupdated() {
		return this.dateupdated;
	}

	public void setDateupdated(Date dateupdated) {
		this.dateupdated = dateupdated;
	}

}