package com.datalook.dao.base;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.datalook.model.sys.SysFunction;
import com.datalook.model.sys.SysRole;
import com.datalook.model.sys.SysUser;
import com.datalook.service.base.BaseService;
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"classpath:/applicationContext.xml"}) 
public class BaseDaot extends AbstractTransactionalJUnit4SpringContextTests{
	@Autowired
	IBaseDao<SysFunction> funDao;
	@Autowired
	IBaseDao<SysRole> roleDao;
	@Autowired
	IBaseDao<SysUser> userDao;
	@Resource(name="sysUserService")
	BaseService<SysUser> userService;
	
	SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
	
	
	@Test
	@Rollback(false)
	public void testarole(){
		int l=roleDao.executeSql("delete SYS_ROLE_FUNCTION_RELATION where roleid=2");
		System.out.println(l);
	}
	
	
	@Test
	public void testPid(){
		List<SysFunction> l=funDao.find("from SysFunction");
		System.out.println(l);
//		for (SysFunction sysFunction : l) {
//			Hibernate.initialize(sysFunction.getSysFunctions());
//			System.out.println(sysFunction.getSysFunctions());
//		}
	}
	
	@Test
	public void testaService(){
		SysUser u=new SysUser();
		u.setUsername("admin");
		u=userService.getByProperties(u);
		System.out.println("------------------------");
		System.out.println(u.getSysRoles());
	}
}
