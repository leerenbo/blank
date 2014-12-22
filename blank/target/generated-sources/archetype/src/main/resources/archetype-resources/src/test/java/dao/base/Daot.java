#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.dao.base;

import java.util.List;

import javax.annotation.Resource;
import javax.enterprise.inject.New;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import ${package}.model.sys.SysUser;
import ${package}.service.base.BaseService;
import com.google.common.hash.HashCode;

@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"classpath:/applicationContext.xml"}) 
public class Daot extends AbstractTransactionalJUnit4SpringContextTests {
	
	@Autowired
	IBaseDao<SysUser> userDao;
	
	@Autowired
	IBaseDao<SysUser> locationDao;
	
	@Resource(name="sysUserService")
	BaseService<SysUser> sysUserService;

	
	@Autowired
	IBaseDao<Object[]> objectDao;

	@Test
	@Rollback(false)
	public void testHql(){
		int l=userDao.executeHql("update SysUser su set su.username='admin'");
		System.out.println(l);
	}
	
	@Test
	@Rollback(false)
	public void testConditionHql(){
		List<Object[]> l=objectDao.find("select distinct(su) from SysUser su , SysRole sr ");
		System.out.println(l);
	}
	
	@Test
	@Rollback(false)
	public void testRollback(){
		SysUser su=new SysUser();
		su.setRealname("asdf");
		userDao.save(su);
	}

	@Test
	@Rollback(false)
	public void testCount(){
		System.out.println(locationDao.find("from Location h join fetch h.kqPoses k where h.id=1 and k.status=1"));
		Long l=locationDao.getLong("select count(*) from Location h join h.kqPoses k where h.id=1 and k.status=0");
		System.out.println(l);
	}
}
