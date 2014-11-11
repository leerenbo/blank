package com.datalook.model.sys.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import com.datalook.model.comparator.SysFunctionSeqComparator;
import com.datalook.model.sys.SysFunction;
import com.datalook.model.sys.SysRole;
import com.datalook.model.sys.SysUser;

public class SessionInfo implements java.io.Serializable {

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
