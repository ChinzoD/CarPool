package com.mum.carpool.dao;
// Generated Aug 29, 2016 2:37:50 PM by Hibernate Tools 5.1.0.Beta1

import java.util.List;
import javax.naming.InitialContext;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.LockMode;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mum.carpool.domain.Comments;
import com.mum.carpool.domain.Posts;
import com.mum.carpool.domain.User;

import static org.hibernate.criterion.Example.create;

/**
 * @author ChinzorigD
 *
 */

@Repository
public class CommentsDao extends AbstractDao {
	
	@Autowired
	public CommentsDao(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	public void delete(List<Integer> ids) {
		for (Integer i : ids) {
			this.delete(this.find(i));
			logger.info(i + " Comments deleted.");
		}
	}

	public void delete(Comments comments) {
		super.delete(comments);
	}

	public Comments find(Integer commentId) {
		return (Comments)super.find(Comments.class, commentId);
	}

	@SuppressWarnings("unchecked")
	public List findAll() {
		return super.findAll(Comments.class);
	}

	public void saveOrUpdate(Comments comments) {
		super.saveOrUpdate(comments);
	}
	
	public List findCommentsByPostId(Integer postId){
		Session session = super.getSession();
    	Query q = session.createQuery("FROM Comments Where postid=? ORDER BY commentid");
    	q.setInteger(0, postId);
    	return q.list();
	}
}