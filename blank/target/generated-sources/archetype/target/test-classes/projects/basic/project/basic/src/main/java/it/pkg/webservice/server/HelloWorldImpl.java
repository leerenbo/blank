package it.pkg.webservice.server;

import javax.jws.WebService;

import it.pkg.webservice.HelloWorld;

@WebService(endpointInterface = "it.pkg.webservice.HelloWorld")
@org.springframework.stereotype.Component
public class HelloWorldImpl implements HelloWorld {
	public String sayHi(String text,Integer i) {
		System.out.println("sayHi called"+text+i);
		return "Hello " + text;
	}
}