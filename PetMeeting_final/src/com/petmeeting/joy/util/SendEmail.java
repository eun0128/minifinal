package com.petmeeting.joy.util;


import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;


public class SendEmail {
	
	public static boolean sendMail(String subject, String text, String to) {

		  String host     = "smtp.gmail.com";
		  String post     = "587";
		  final String user   = "petmeetingjoy@gmail.com";
		  final String password  = "vptalxld1";
		 
		  boolean b = false;
		  Properties props = new Properties();
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.port", post);
		  props.put("mail.smtp.auth", "true");
		  props.put("mail.smtp.starttls.enable","true"); 
		  
		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			  protected PasswordAuthentication getPasswordAuthentication() {
			      return new PasswordAuthentication(user, password);
			  }
		  });

		  // Compose the message
		  try {
			   MimeMessage message = new MimeMessage(session);
			   message.setFrom(new InternetAddress(user));
			   message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	
			   // Subject
			   message.setSubject(subject);
			   
			   // Text
			   message.setText(text);
	
			   // send the message
			   Transport.send(message);
			   System.out.println("message send successfully...");
			  
			   b = true;
			  
		   
		  } catch (MessagingException e) {
		   e.printStackTrace();
		  }
		 return b;
	}
		
}
