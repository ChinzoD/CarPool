package com.mum.carpool.service;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mum.carpool.dao.UserDao;
import com.mum.carpool.domain.User;
import com.mum.carpool.helper.UserPasswordHelper;


@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private SecurityService securityService;
	@Autowired
	private UserDao userDao;

//	public Boolean changePassword(String currentPassword, String newPassword){
//		try{
//			if(securityService.isLoggedIn() == true && this.check(currentPassword) == true){
//				User user = userDao.find(securityService.getCurrentUserName());
//				user.setPassword(ConvertToMd5(newPassword));
//				userDao.saveOrUpdate(user);
//				return true;
//			}else{
//				return false;
//			}
//		}catch(NoSuchAlgorithmException e) {
//			return false;
//		}
//	}

	public Boolean changePassword(UserPasswordHelper userPasswordHelper){
		try{
			boolean isValidUser = this.isValidUser(userPasswordHelper.getUsername(), userPasswordHelper.getCurrentPassword());
			if(isValidUser){
				User user = userDao.find(userPasswordHelper.getUsername());
				user.setPassword(ConvertToMd5(userPasswordHelper.getNewPassword()));
				userDao.saveOrUpdate(user);
				return true;
			}else{
				return false;
			}
		}catch(NoSuchAlgorithmException e) {
			return false;
		}
	}
	
	public void createUser(User user) {
	}

	public Boolean check(String password) {
		try {
			if(securityService.getCurrentUserName() != null){
				User user = userDao.find(securityService.getCurrentUserName()); 			
				if(user.getPassword().equals(ConvertToMd5(password)))
					return true;
				else
					return false;			
			}else{
				return false;
			}
		} catch (NoSuchAlgorithmException e) {
			return false;
		}
	}

	private String ConvertToMd5(String s) throws NoSuchAlgorithmException{
        MessageDigest m=MessageDigest.getInstance("MD5");
        m.update(s.getBytes(),0,s.length());
        return new BigInteger(1, m.digest()).toString(16);
	}
	
	@Override
	public boolean isValidUser(String username, String password)
	{
		try {
			return userDao.isValidUser(username, ConvertToMd5(password));
		} catch (NoSuchAlgorithmException e) {
			return false;
		}
	}
}
