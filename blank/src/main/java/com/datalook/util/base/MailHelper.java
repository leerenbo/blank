package com.datalook.util.base;

import java.util.Properties;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;


public class MailHelper {
	
    private static JavaMailSenderImpl mailSender=new JavaMailSenderImpl();

    static {
    	mailSender.setHost(ConfigUtil.get("email.host"));
    	mailSender.setProtocol(ConfigUtil.get("email.protocol"));
    	mailSender.setPort(Integer.valueOf(ConfigUtil.get("email.port")));
    	mailSender.setUsername(ConfigUtil.get("email.userName"));
    	mailSender.setPassword(ConfigUtil.get("email.password"));
    	Properties javaMailProperties=new Properties();
    	javaMailProperties.put("mail."+ConfigUtil.get("email.protocol")+".auth", ConfigUtil.get("email.auth"));
    	mailSender.setJavaMailProperties(javaMailProperties);
    }
	/**
	 * 
	 * 功能描述：Spring发送邮件
	 * 时间：2014-9-25
	 * @author ：zhaoshizhuo
	 * @param args
	 * @throws javax.mail.MessagingException 
	 */
    public static void sendHtmlMessage(String to,String subject,String htmlText) throws javax.mail.MessagingException{
    	MimeMessage mailMessage = mailSender.createMimeMessage();
    	
    	//设置utf-8或GBK编码，否则邮件会有乱码  
    	MimeMessageHelper messageHelper =new MimeMessageHelper(mailMessage,true,"utf-8");   
    	messageHelper.setFrom(mailSender.getUsername()); 
    	messageHelper.setTo(to);
    	messageHelper.setSubject(subject);
       //邮件内容，参数true，表示启用html格式  
    	messageHelper.setText(htmlText,true);  
    	
    	mailSender.send(mailMessage);  
    }
    
//    public static void main(String[] args) {
//		try {
//			sendHtmlMessage("447430787@qq.com", "test",	"ahahaha");
//		} catch (MessagingException e) {
//			e.printStackTrace();
//		}
//	}
}