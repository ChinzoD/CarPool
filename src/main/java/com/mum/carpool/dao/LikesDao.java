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

import com.mum.carpool.domain.Likes;
import com.mum.carpool.domain.User;

import static org.hibernate.criterion.Example.create;


/**
 * @author ChinzorigD
 *
 */

@Repository
public class LikesDao extends AbstractDao {
	@Autowired
	public LikesDao(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	public void delete(List<Integer> ids) {
		for (Integer i : ids) {
			this.delete(this.find(i));
			logger.info(i + " Likes deleted.");
		}
	}

	public void delete(Likes likes) {
		super.delete(likes);
	}

	public Likes find(Integer likeId) {
		return (Likes)super.find(Likes.class, likeId);
	}

	@SuppressWarnings("unchecked")
	public List findAll() {
		return super.findAll(Likes.class);
	}

	public void saveOrUpdate(Likes likes) {
		super.saveOrUpdate(likes);
	}
	
	public boolean isLiked(Integer postid, Integer userid ){
		Session session = super.getSession();
    	Query query = session.createQuery("from Likes where postid= :val1 AND userid= :val2");
    	query.setInteger("val1", postid);
    	query.setInteger("val2", userid);
        List<Likes> likesList = query.list();
        if(likesList.size() != 0)
        	return true;
        else 
        	return false;
	} 
	
	public Integer getTotalLikeByPostId(Integer postId){
		Session session = super.getSession();
    	Query query = session.createQuery("from Likes where postid=?");
    	query.setInteger(0, postId);
        List<Likes> cartList = query.list();
        return cartList.size();
    }
}