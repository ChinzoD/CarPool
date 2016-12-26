package com.mum.carpool.service;


import org.springframework.transaction.annotation.Transactional;

import com.mum.carpool.domain.User;
import com.mum.carpool.helper.UserPasswordHelper;


public interface UserService {

//	public Boolean changePassword(String currentPassword, String newPassword);
	public Boolean changePassword(UserPasswordHelper userPasswordHelpser);
	public void createUser(User user);
	public Boolean check(String password);
	public boolean isValidUser(String username, String password);
}
