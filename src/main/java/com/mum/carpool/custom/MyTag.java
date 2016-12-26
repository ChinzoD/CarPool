package com.mum.carpool.custom;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;

public class MyTag extends SimpleTagSupport{
	String success;
	String error;
	String state;
	String display;
	
	public void doTag() throws JspException, IOException // render custom tag
	{
		JspWriter out = getJspContext().getOut();
		if(display != ""){
			if (state == "true")
				out.write(String.format("<div class='alert alert-success'><button class='close' data-close='alert'></button>%s</div>", success));
			else
				out.write(String.format("<div class='alert alert-danger'><button class='close' data-close='alert'></button>%s</div>", error));
		}
	}

	// Need a setter for each attribute of custom tag
	public void setSuccess(String success) {
		this.success = success;
	}

	public void setError(String error) {
		this.error = error;
	}
	
	public void setState(String state) {
		this.state = state;
	}
	public void setDisplay(String display) {
		this.display = display;
	}
}