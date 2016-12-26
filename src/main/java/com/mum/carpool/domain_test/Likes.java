package com.mum.carpool.domain_test;
// Generated Sep 23, 2016 3:44:29 PM by Hibernate Tools 5.1.0.Beta1

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Likes generated by hbm2java
 */
@Entity
@Table(name = "likes", catalog = "carpoolingdb")
public class Likes implements java.io.Serializable {

	private Integer likeid;
	private int userid;
	private int postid;
	private Date datecreated;
	private Date dateupdated;

	public Likes() {
	}

	public Likes(int userid, int postid, Date datecreated, Date dateupdated) {
		this.userid = userid;
		this.postid = postid;
		this.datecreated = datecreated;
		this.dateupdated = dateupdated;
	}

	@Id
	@GeneratedValue(strategy = IDENTITY)

	@Column(name = "likeid", unique = true, nullable = false)
	public Integer getLikeid() {
		return this.likeid;
	}

	public void setLikeid(Integer likeid) {
		this.likeid = likeid;
	}

	@Column(name = "userid", nullable = false)
	public int getUserid() {
		return this.userid;
	}

	public void setUserid(int userid) {
		this.userid = userid;
	}

	@Column(name = "postid", nullable = false)
	public int getPostid() {
		return this.postid;
	}

	public void setPostid(int postid) {
		this.postid = postid;
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
