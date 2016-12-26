package com.mum.carpool.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.mum.carpool.dao.CommentsDao;
import com.mum.carpool.dao.LikesDao;
import com.mum.carpool.dao.PostsDao;
import com.mum.carpool.dao.UserDao;
import com.mum.carpool.domain.User;
import com.mum.carpool.domain.Comments;
import com.mum.carpool.domain.Likes;
import com.mum.carpool.domain.Posts;

import java.util.List;
import java.util.stream.Collectors;
import java.util.*;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

@Controller
public class PostController {
	private static final Logger logger = LoggerFactory.getLogger(PostController.class);

	@Autowired
	private UserDao userDao;
	@Autowired
	private PostsDao postDao;
	@Autowired
	private CommentsDao commentsDao;
	@Autowired
	private LikesDao likesDao;
	
	@RequestMapping(value = {"/user/post"}, method = RequestMethod.GET)
	public String getPosts(HttpServletRequest request, @RequestParam(required=false) String postType,Model model) {
		HttpSession session = request.getSession();

		String username = session.getAttribute("username").toString();
		User user = userDao.find(username);
		
		int type=0;
		if (postType != null && !postType.isEmpty())
			type = Integer.parseInt(postType);
		
		List<Posts> posts = postDao.findTop25AskRidePost();
				
		List<Likes> likesList = likesDao.findAll();
		
		List<Posts> fposts = new ArrayList<Posts>();
		for (int i = 0; i < posts.size(); i++) {
			if (posts.get(i).getPosttype()==type) // if asking for a ride
			{
				Posts item = posts.get(i);
				if (item.getUserid() > 0)
					item.setUser(userDao.find(item.getUserid()));
				
				List<Comments> comments = commentsDao.findCommentsByPostId(item.getPostid());
				for(Comments itemComments : comments)
				{
					itemComments.setUser(userDao.find(itemComments.getUserid()));
				}
				
				item.setComments(comments);
				item.setLikes(likesDao.getTotalLikeByPostId(item.getPostid()));
				item.setIsthisuserliked(likesDao.isLiked(item.getPostid(), user.getUserid()));
				fposts.add(item);
			}
		}
		
		model.addAttribute("posts", fposts);
		model.addAttribute("user", user);
		model.addAttribute("lastDatePost", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(new Date()));
	
		return "post";
	}

	
	@RequestMapping(value = {"/user/post"}, method = RequestMethod.POST)
	public void register(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String command = request.getParameter("command");
		
		if (!command.isEmpty())
		{
			if (command.equals("del"))
			{
				String postID = request.getParameter("postID");
				if (!postID.isEmpty()){
					Posts delItem = postDao.find(Integer.parseInt(postID));
					if (delItem != null){
						postDao.delete(delItem);
						//return postID;
					}
				}
			}
			else if (command.equals("addPost"))
			{
				Posts newPost = new Posts();
				newPost.setUserid((Integer.parseInt(request.getParameter("userID"))));
				newPost.setPost(request.getParameter("post"));
				newPost.setPosttype((Integer.parseInt(request.getParameter("postType"))));
				Date date = new Date();
				newPost.setDatecreated(date);
				newPost.setDateupdated(date);
				postDao.saveOrUpdate(newPost);
				
				// format the postDao to json and return it to front end
				//return "json:newPost";
			}
			else if (command.equals("addComment"))
			{
				Comments newComment = new Comments();
				newComment.setPostid((Integer.parseInt(request.getParameter("postID"))));
				newComment.setUserid((Integer.parseInt(request.getParameter("userID"))));
				newComment.setComment(request.getParameter("comment"));
				Date date = new Date();
				newComment.setDatecreated(date);
				newComment.setDateupdated(date);
				commentsDao.saveOrUpdate(newComment);
				
				// format the postDao to json and return it to front end
				//return "json:newComment";
			}
			else if (command.equals("addLike"))
			{
				Likes newLike = new Likes();
				Integer postID = Integer.valueOf(request.getParameter("postID"));
				newLike.setPostid(postID);
				newLike.setUserid((Integer.parseInt(request.getParameter("userID"))));
				Date date = new Date();
				newLike.setDatecreated(date);
				newLike.setDateupdated(date);
				likesDao.saveOrUpdate(newLike);
				
				Integer total = likesDao.getTotalLikeByPostId(postID);
				total+=1;
				
				// format the postDao to json and return it to front end
				//return "json:newLike";
			}
			else if (command.equals("getNewPost"))
			{
				String lastDatePost = request.getParameter("lastDatePost");
				Integer postType = Integer.valueOf(request.getParameter("postType"));
				if (!lastDatePost.isEmpty())
				{
					int total;
		
					total = postDao.findNewPostTotal(lastDatePost,postType);

					JSONObject obj = new JSONObject();
					obj.put("totalNewPost", total);
					obj.put("lastDatePost", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(new Date()));
					
					//String jsonvalue = obj.toJSONString();
				    response.setContentType("application/json");
				    response.setCharacterEncoding("UTF-8");
				    PrintWriter out = response.getWriter(); 
			        out.print(obj);			        
				}
			}
			else if (command.equals("loadNewPost"))
			{
				String lastDatePost = request.getParameter("lastDatePost");
				Integer posttype = Integer.valueOf(request.getParameter("postType"));
				if (!lastDatePost.isEmpty())
				{
					List<Posts> posts;
					posts = postDao.getNewPost(lastDatePost,posttype);

					JSONArray jaPosts = new JSONArray();					
					
					String comment ;
					if (posts != null && posts.size()>0){
						for(Posts item: posts){
							JSONObject jo = new JSONObject();
							
							JSONArray jaComments = new JSONArray();
							List<Comments> comments = item.getComments();
							if (comments != null && comments.size() > 0){
								for(Comments itemComment: comments){
									JSONObject joComment = new JSONObject();
									joComment.put("comment", itemComment.getComment());
									
									User itemUser = userDao.find(itemComment.getUserid());
									JSONObject joUser = new JSONObject();
									joUser.put("username", itemUser.getUsername());
									
									joComment.put("user", joUser);
									
									jaComments.add(joComment);
								}
							}
							
							jo.put("comments", jaComments);
							jo.put("datecreated", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(item.getDatecreated()));
							jo.put("dateupdated", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(item.getDateupdated()));
							jo.put("likes", item.getLikes());
							jo.put("post", item.getPost());
							jo.put("postid", item.getPostid());
							jo.put("posttype", item.getPosttype());
							
							User itemUser = userDao.find(item.getUserid());
							JSONObject joUser = new JSONObject();
							joUser.put("userid", itemUser.getUserid());
							joUser.put("username", itemUser.getUsername());
							jo.put("user", joUser);
	
							jaPosts.add(jo);
						}
					}
					
					JSONObject obj = new JSONObject();
					obj.put("newPost", jaPosts);
					obj.put("lastDatePost", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(new Date()));
					
				    response.setContentType("application/json");
				    response.setCharacterEncoding("UTF-8");
				    PrintWriter out = response.getWriter(); 
			        out.print(obj);			        
				}
			}
			else if (command.equals("loadOldPost"))
			{
				String paging = request.getParameter("paging");
				Integer postType = Integer.valueOf(request.getParameter("postType"));
				if (!paging.isEmpty())
				{
					List<Posts> posts;
					Integer pagingNo = Integer.parseInt(paging);
					posts = postDao.findPaggingPost(pagingNo, postType);

					JSONArray jaPosts = new JSONArray();					
					
					String comment ;
					if (posts != null && posts.size()>0){
						for(Posts item: posts){
							JSONObject jo = new JSONObject();
							
							JSONArray jaComments = new JSONArray();
							List<Comments> comments = item.getComments();
							if (comments != null && comments.size() > 0){
								for(Comments itemComment: comments){
									JSONObject joComment = new JSONObject();
									joComment.put("comment", itemComment.getComment());
									
									User itemUser = userDao.find(itemComment.getUserid());
									JSONObject joUser = new JSONObject();
									joUser.put("username", itemUser.getUsername());
									
									joComment.put("user", joUser);
									
									jaComments.add(joComment);
								}
							}
							
							jo.put("comments", jaComments);
							jo.put("datecreated", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(item.getDatecreated()));
							jo.put("dateupdated", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(item.getDateupdated()));
							jo.put("likes", item.getLikes());
							jo.put("post", item.getPost());
							jo.put("postid", item.getPostid());
							jo.put("posttype", item.getPosttype());
							
							User itemUser = userDao.find(item.getUserid());
							JSONObject joUser = new JSONObject();
							joUser.put("userid", itemUser.getUserid());
							joUser.put("username", itemUser.getUsername());
							jo.put("user", joUser);
	
							jaPosts.add(jo);
						}
					}
					
					JSONObject obj = new JSONObject();
					obj.put("newPost", jaPosts);
					
					pagingNo++;
					obj.put("pagingno",pagingNo);
					
				    response.setContentType("application/json");
				    response.setCharacterEncoding("UTF-8");
				    PrintWriter out = response.getWriter(); 
			        out.print(obj);			        
				}
			}
			else if (command.equals("loadPost"))
			{
				Integer postType = Integer.valueOf(request.getParameter("postType"));

				List<Posts> posts;
				if (postType == 0)
					posts = postDao.findTop25AskRidePost();
				else 
					posts = postDao.findTop25AskPasengerPost();
				
				JSONArray jaPosts = new JSONArray();					
				
				String comment ;
				if (posts != null && posts.size()>0){
					for(Posts item: posts){
						JSONObject jo = new JSONObject();
						
						JSONArray jaComments = new JSONArray();
						List<Comments> comments = item.getComments();
						if (comments != null && comments.size() > 0){
							for(Comments itemComment: comments){
								JSONObject joComment = new JSONObject();
								joComment.put("comment", itemComment.getComment());
								
								User itemUser = userDao.find(itemComment.getUserid());
								JSONObject joUser = new JSONObject();
								joUser.put("username", itemUser.getUsername());
								
								joComment.put("user", joUser);
								
								jaComments.add(joComment);
							}
						}
						
						jo.put("comments", jaComments);
						jo.put("datecreated", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(item.getDatecreated()));
						jo.put("dateupdated", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(item.getDateupdated()));
						jo.put("likes", item.getLikes());
						jo.put("post", item.getPost());
						jo.put("postid", item.getPostid());
						jo.put("posttype", item.getPosttype());
						
						User itemUser = userDao.find(item.getUserid());
						JSONObject joUser = new JSONObject();
						joUser.put("userid", itemUser.getUserid());
						joUser.put("username", itemUser.getUsername());
						jo.put("user", joUser);

						jaPosts.add(jo);
					}
				}
				
				JSONObject obj = new JSONObject();
				if (jaPosts.isEmpty())
					obj.put("newPost", "");
				else
					obj.put("newPost", jaPosts);

				obj.put("lastDatePost", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").format(new Date()));
				
			    response.setContentType("application/json");
			    response.setCharacterEncoding("UTF-8");
			    PrintWriter out = response.getWriter(); 
		        out.print(obj);			        
			}
		}
	}
}