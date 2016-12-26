package com.mum.carpool.controller;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.mum.carpool.dao.CommentsDao;
import com.mum.carpool.dao.LikesDao;
import com.mum.carpool.dao.PostsDao;
import com.mum.carpool.dao.UserDao;
import com.mum.carpool.domain.Comments;
import com.mum.carpool.domain.Likes;
import com.mum.carpool.domain.Posts;
import com.mum.carpool.domain.User;
import com.mum.carpool.helper.UserPasswordHelper;
import com.mum.carpool.service.SecurityService;
import com.mum.carpool.service.UserService;
import com.mum.carpool.service.UserServiceImpl;


/**
 * @author ChinzorigD
 *
 */
/**
 * Handles requests for the application home page.
 */

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	@Autowired
	private	SecurityService securityService;
	@Autowired
	private UserDao userDao;
	@Autowired
	private UserService userService;
	@Autowired
	private PostsDao postsDao;
	@Autowired
	private CommentsDao commentsDao;
	@Autowired
	private LikesDao likesDao;

	/**
	 * Simply selects the home view to render by returning its name.
	 */
	
	@RequestMapping(value="/iadmin", method=RequestMethod.GET)
	public String getLogin(){
		if(securityService.isLoggedIn()){
			return "redirect:/panel/aboutgroup";
		}
		return "iadmin";
	}
	
	
	@RequestMapping(value = {"/"}, method = RequestMethod.GET)
	public String welcome(Model model) {
		return "redirect:/login";
	}
	
	@RequestMapping(value = {"/login"}, method = RequestMethod.GET)
	public ModelAndView GetLogin(HttpServletRequest request) {
		HttpSession session = request.getSession();
		ModelAndView model= null;
		if(session.getAttribute("username") != null){
			model = new ModelAndView("redirect:/user/post");
			return model;
		}
		model = new ModelAndView("login");
		User user = new User();
		model.addObject("loginUser", user);
		return model;
	}
	
	@RequestMapping(value = {"/login"}, method = RequestMethod.POST)
	public ModelAndView PostLogin(HttpServletRequest request, 
			HttpServletResponse response, @ModelAttribute("loginUser")User user) {
		
		ModelAndView model= null;
		if(request.getParameter("state").equals("1")){
			boolean isValidUser = userService.isValidUser(user.getUsername(), user.getPassword());
			request.getSession().setAttribute("userid", userDao.find(user.getUsername()).getUserid());
			if (isValidUser) {
				request.setAttribute("loggedInUser", user.getUsername());
				request.getSession().setAttribute("username", user.getUsername());
				model = new ModelAndView("redirect:/user/post");
			} else {
				model = new ModelAndView("login");
				model.addObject("loginUser", user);
				request.setAttribute("message", 0);
			}
		}else{
			try {
				user.setPassword(ConvertToMd5(user.getPassword()));
			} catch (NoSuchAlgorithmException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			Date date = new Date();
			user.setDatecreated(date);
			user.setDateupdated(date);
			userDao.saveOrUpdate(user);
			request.setAttribute("loggedInUser", user.getUsername());
			request.getSession().setAttribute("username", user.getUsername());
			request.getSession().setAttribute("userid", userDao.find(user.getUsername()).getUserid());
			model = new ModelAndView("redirect:/user/post");
		}
		return model;
	}
	
	private String ConvertToMd5(String s) throws NoSuchAlgorithmException{
        MessageDigest m=MessageDigest.getInstance("MD5");
        m.update(s.getBytes(),0,s.length());
        return new BigInteger(1, m.digest()).toString(16);
	}
	
	@RequestMapping(value = {"/user/profile"}, method = RequestMethod.GET)
	public ModelAndView GetProfile(HttpServletRequest request) {
		HttpSession session = request.getSession();
		User user = userDao.find(session.getAttribute("username").toString());
		ModelAndView model = new ModelAndView("profile");
		model.addObject("UserProfile", user);
		model.addObject("PasswordHelper", new UserPasswordHelper());

		return model;
	}
	
	@RequestMapping(value = {"/user/profile"}, method = RequestMethod.POST)
	public ModelAndView PostProfile(HttpServletRequest request, 
			HttpServletResponse response, @ModelAttribute("UserProfile")User user, 
			@ModelAttribute("PasswordHelper")UserPasswordHelper passwordHelper) {
		
		ModelAndView model = new ModelAndView("profile");;
		HttpSession session = request.getSession();
		
		
		if(request.getParameter("state").equals("1")){
			User oldUser = userDao.find(session.getAttribute("username").toString());
			user.setUserid(oldUser.getUserid());
			Date date = new Date();
			user.setUsername(oldUser.getUsername());
			user.setPassword(oldUser.getPassword());
			user.setDateupdated(date);
			userDao.saveOrUpdate(user);
			model.addObject("profileChangeResult", true);
		}else{
			passwordHelper.setUsername(session.getAttribute("username").toString());
			model.addObject("passChangeResult", userService.changePassword(passwordHelper));
			
		}
		User user1 = userDao.find(session.getAttribute("username").toString());
		model.addObject("UserProfile", user1);
		model.addObject("PasswordHelper", new UserPasswordHelper());
		return model;
	}
	
	@RequestMapping(value = {"/logout"}, method = RequestMethod.GET)
	public String logout(HttpServletRequest request, 
			HttpServletResponse response, @ModelAttribute("UserProfile")User user) {
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:/login";
	}
	
	@RequestMapping(value = {"/user/addComment"}, method = RequestMethod.POST)
	@ResponseBody
	public void PostComment(HttpServletRequest request, @RequestBody Comments jsonString) {
		
		Comments comments = jsonString;
		comments.setUserid(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
		//comments.setUser(userDao.find(comments.getUserid()));
		comments.setDatecreated(new Date());
		comments.setDateupdated(new Date());
		commentsDao.saveOrUpdate(comments);
	}

	@RequestMapping(value = { "/user/addPost" }, method = RequestMethod.POST)
	@ResponseBody
	public JSONObject WritePost(HttpServletRequest request, @RequestBody Posts jsonString) {

		Posts posts = jsonString;
		posts.setUserid(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
		// setUser(userDao.find(comments.getUserid()));
		posts.setPosttype(0);
		posts.setDatecreated(new Date());
		posts.setDateupdated(new Date());
		postsDao.saveOrUpdate(posts);

		JSONObject obj = new JSONObject();
		obj.put("postid", posts.getPostid());

		return obj;

	}

	@RequestMapping(value = { "/user/deletePost" }, method = RequestMethod.POST)
	public void DeletePost(HttpServletRequest request) {
		String id = request.getParameter("postid").toString();
		Posts posts = postsDao.find(Integer.parseInt(id));
		List<Comments> comments = commentsDao.findCommentsByPostId(posts.getPostid());
		for (Comments c : comments) {
			commentsDao.delete(c);
		}
		postsDao.delete(posts);

	}
	
	@RequestMapping(value = { "/user/likePost" }, method = RequestMethod.POST)
	public void LikePost(HttpServletRequest request) {
		String id = request.getParameter("postid");
		Likes likes = new Likes();
		likes.setPostid(Integer.parseInt(id));
		likes.setUserid(Integer.parseInt(request.getSession().getAttribute("userid").toString()));
		Date date = new Date();
		likes.setDatecreated(date);
		likes.setDateupdated(date);
		likesDao.saveOrUpdate(likes);
	}
}
