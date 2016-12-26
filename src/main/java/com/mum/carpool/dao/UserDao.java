package com.mum.carpool.dao;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.mum.carpool.domain.User;


@Repository
public class UserDao extends AbstractDao {
	
	@Autowired
	public UserDao(SessionFactory sessionFactory) {
		super.setSessionFactory(sessionFactory);
	}

	public void delete(List<String> ids) {
		for (String str : ids) {
			this.delete(this.find(str));
			logger.info(str + " Users deleted.");
		}
	}

	public void delete(User user) {
		super.delete(user);
	}

	public User find(Integer userid) {
		return (User)super.find(User.class, userid);
	}

	public User find(String username) {
    	
		StringBuffer buffer = new StringBuffer();
		buffer.append("from User c where c.username = :value");
//		Query query = getHibernateTemplate().getSessionFactory()
//				.getCurrentSession().createQuery(buffer.toString());
		Session session = super.getSession();
		Query query = session.createQuery(buffer.toString());
		query.setParameter("value", username);
		User result = (User) query.list().get(0);
//		 for(User user:this.findAll()) {
//	         if ( user.getUsername().equals(username)  == true ) {
//	            // return matching user
//	            return user;
//	         }
//	      }
		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<User> findAll() {
		return super.findAll(User.class);
	}

	public void saveOrUpdate(User user) {
		super.saveOrUpdate(user);
	}
	
	
	@SuppressWarnings("unchecked")
	public boolean isValidUser(String username, String password)
	{
		User user = this.find(username);
		if (user != null){
			if (user.getPassword().equals(password)) 
				return true;
			return false;
		}else{
			return false;
		}
	}

}
