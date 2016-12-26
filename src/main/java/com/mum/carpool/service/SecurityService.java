package com.mum.carpool.service;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

@Service
public class SecurityService {
	
	public String getCurrentUserName(){
		return SecurityContextHolder.getContext().getAuthentication().getName();
	}
	
	
	public Boolean isLoggedIn(){
		for(GrantedAuthority authority: SecurityContextHolder.getContext().getAuthentication().getAuthorities()){
			if(authority.getAuthority().equals("ROLE_USER")){
				return true;
			}
		}
		return false;
	}

}
