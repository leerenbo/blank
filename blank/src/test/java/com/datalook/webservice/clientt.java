package com.datalook.webservice;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"classpath:/cxf-client.xml"}) 
public class clientt {
	@Resource(name="client")
	HelloWorld client;
	@Test
	@Rollback(false)
	public void test(){
		client.sayHi("hehe",4);
	}
}
