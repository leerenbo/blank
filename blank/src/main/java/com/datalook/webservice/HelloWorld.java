package com.datalook.webservice;

import javax.jws.WebParam;
import javax.jws.WebService;

@WebService
public interface HelloWorld {
	String sayHi(String text,Integer i);
}
