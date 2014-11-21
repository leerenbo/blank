package com.datalook.webservice.server;

import javax.jws.WebService;

import com.datalook.webservice.HelloWorld;

@WebService(endpointInterface = "com.datalook.webservice.HelloWorld")
@org.springframework.stereotype.Component
public class HelloWorldImpl implements HelloWorld {
	public String sayHi(String text,Integer i) {
		System.out.println("sayHi called"+text+i);
		return "Hello " + text;
	}
}