package com.mum.carpool.domain_test;
// Generated Sep 23, 2016 3:44:29 PM by Hibernate Tools 5.1.0.Beta1

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Posts generated by hbm2java
 */
@Entity
@Table(name = "posts", catalog = "carpoolingdb")
public class Posts implements java.io.Serializable {

	private Integer postid;
	private User user;
	private String post;
	private int posttype;
	private Date datecreated;
	private Date dateupdated;

	public Posts() {
	}

	public Posts(User user, String post, int posttype, Date datecreated, Date dateupdated) {
		this.user = user;
		this.post = post;
		this.posttype = posttype;
		this.datecreated = datecreated;
		this.dateupdated = dateupdated;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "postid", unique = true, nullable = false)
	public Integer getPostid() {
		return this.postid;
	}

	public void setPostid(Integer postid) {
		this.postid = postid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "userid", nullable = false)
	public User getUser() {
		return this.user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Column(name = "post", nullable = false, length = 65535)
	public String getPost() {
		return this.post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	@Column(name = "posttype", nullable = false)
	public int getPosttype() {
		return this.posttype;
	}

	public void setPosttype(int posttype) {
		this.posttype = posttype;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "datecreated", nullable = false, length = 19)
	public Date getDatecreated() {
		return this.datecreated;
	}

	public void setDatecreated(Date datecreated) {
		this.datecreated = datecreated;
	}

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "dateupdated", nullable = false, length = 19)
	public Date getDateupdated() {
		return this.dateupdated;
	}

	public void setDateupdated(Date dateupdated) {
		this.dateupdated = dateupdated;
	}

}
