package it.pkg.service.sys.implement;

import org.springframework.stereotype.Service;

import it.pkg.model.sys.SysRole;
import it.pkg.service.base.BaseServiceImpl;
import it.pkg.service.sys.SysRoleService;
import it.pkg.util.base.StringUtil;

@Service("sysRoleService")
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole> implements SysRoleService{
}
