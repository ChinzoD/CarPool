package com.mum.carpool.dao;

import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import java.util.List;

/**
 * A layer supertype that handles the common operations for all Data Access Objects.
 */
public abstract class AbstractDao  extends HibernateDaoSupport{

    public AbstractDao() { }

    protected void saveOrUpdate(Object obj) {
        getHibernateTemplate().saveOrUpdate(obj);       
    }

    protected void delete(Object obj) {
        getHibernateTemplate().delete(obj);       
    }
    
	@SuppressWarnings("unchecked")
	public void delete(Class clazz, List<String> ids){
		for(String str: ids){
			int id = Integer.parseInt(str);
			this.delete(this.find(clazz, id));
			logger.info(clazz.getName()+ " with id " + id + " deleted.");
		}
	}


	@SuppressWarnings("unchecked")
	protected Object find(Class clazz, int id) {
		return getHibernateTemplate().get(clazz, id);
    }
	
	
	@SuppressWarnings("unchecked")
	protected Object find(Class clazz, String string) {
		return getHibernateTemplate().get(clazz, string);
    }

	@SuppressWarnings("unchecked")
	protected List findAll(Class clazz) {
		return getHibernateTemplate().find("from " + clazz.getName());
    }
	
}
