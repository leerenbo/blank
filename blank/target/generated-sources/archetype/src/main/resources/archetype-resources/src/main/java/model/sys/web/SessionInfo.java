#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.model.sys.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import ${package}.model.comparator.SysFunctionSeqComparator;
import ${package}.model.sys.SysFunction;
import ${package}.model.sys.SysRole;
import ${package}.model.sys.SysUser;

public class SessionInfo implements java.io.Serializable {

	private static final long serialVersionUID = -5458866871688121825L;
	private SysUser sysUser;
	private List<SysFunction> allFunction;
	
	public SysUser getSysUser() {
		return sysUser;
	}

	public void setSysUser(SysUser sysUser) {
		this.sysUser = sysUser;
	}

	@Override
	public String toString() {
		return "SessionInfo [sysUser=" + sysUser + "]";
	}

	public List<SysFunction> getAllFunction(){
		if(allFunction==null){
			Set<SysRole> roles=sysUser.getSysRoles();
			List<SysFunction> re=new ArrayList<SysFunction>();
			Set<SysFunction> reSet=new HashSet<SysFunction>();
			for (SysRole sysRole : roles) {
				if("1".equals(sysRole.getStatus())){
					reSet.addAll(sysRole.getSysFunctions());
				}
			}
			re.addAll(reSet);
			Collections.sort(re,new SysFunctionSeqComparator());
			allFunction=re;
			return re;
		}else{
			return allFunction;
		}
	}
}
