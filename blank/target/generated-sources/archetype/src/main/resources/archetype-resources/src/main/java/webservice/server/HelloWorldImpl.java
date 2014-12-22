#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.webservice.server;

import javax.jws.WebService;

import ${package}.webservice.HelloWorld;

@WebService(endpointInterface = "${package}.webservice.HelloWorld")
@org.springframework.stereotype.Component
public class HelloWorldImpl implements HelloWorld {
	public String sayHi(String text,Integer i) {
		System.out.println("sayHi called"+text+i);
		return "Hello " + text;
	}
}