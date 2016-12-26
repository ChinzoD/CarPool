package com.mum.carpool.dao;

import java.text.SimpleDateFormat;

// Generated Aug 29, 2016 2:37:50 PM by Hibernate Tools 5.1.0.Beta1

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.mum.carpool.domain.Likes;
import com.mum.carpool.domain.Posts;
import com.mum.carpool.domain.User;

import static org.hibernate.criterion.Example.create;

/**
 * @author ChinzorigD
 *
 */

@Repository
public class PostsDao extends AbstractDao {

	@Autowired
	public PostsDao(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	public void delete(List<Integer> ids) {
		for (Integer i : ids) {
			this.delete(this.find(i));
			logger.info(i + " Posts deleted.");
		}
	}

	public void delete(Posts posts) {
		super.delete(posts);
	}

	public Posts find(Integer postId) {
		return (Posts) super.find(Posts.class, postId);
	}

	@SuppressWarnings("unchecked")
	public List findAll() {
		return super.findAll(Posts.class);
	}

	public void saveOrUpdate(Posts posts) {
		super.saveOrUpdate(posts);
	}

	public List findTop25AskRidePost(){
		Session session = super.getSession();
    	Query q = session.createQuery("FROM Posts ORDER BY datecreated DESC");
    	q.setFirstResult(0);
    	q.setMaxResults(25);
        List<Posts> posts = q.list();

        session.flush();
        return posts;
	}
	
	public List findTop25AskPasengerPost(){
		Session session = super.getSession();
    	Query q = session.createQuery("FROM Posts Where posttype = 1 ORDER BY datecreated DESC");
    	q.setFirstResult(0);
    	q.setMaxResults(25);
        List<Posts> posts = q.list();

        session.flush();
        return posts;
	}
	
	public List findPaggingPost(int pagingNo, int posttype){
		int firstResult=25;
		if (pagingNo>0)
		{
			firstResult+= pagingNo*5;
		}
		
		Session session = super.getSession();
    	Query q = session.createQuery("FROM Posts Where posttype = ? ORDER BY datecreated DESC");
    	q.setInteger(0, posttype);
    	q.setFirstResult(firstResult);
    	q.setMaxResults(5);
        List<Posts> posts = q.list();
        session.flush();
        return posts;
	}

	public int findNewPostTotal(String lastDate, Integer postType){
        return getNewPost(lastDate, postType).size();
	}
	
	public List getNewPost(String lastDate, Integer postType){
		Session session = super.getSession();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
		Date date= new Date();
		try {
			date = formatter.parse(lastDate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	
		Query q = session.createQuery("FROM Posts WHERE datecreated > ? and posttype = ? ORDER BY datecreated DESC");
		
		q.setDate(0, date);
		q.setInteger(1, postType);
	    List<Posts> posts = q.list();
		
	    return posts;
	}
}