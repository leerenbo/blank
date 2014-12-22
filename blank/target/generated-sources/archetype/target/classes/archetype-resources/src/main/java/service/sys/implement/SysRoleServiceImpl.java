#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.service.sys.implement;

import org.springframework.stereotype.Service;

import ${package}.model.sys.SysRole;
import ${package}.service.base.BaseServiceImpl;
import ${package}.service.sys.SysRoleService;
import ${package}.util.base.StringUtil;

@Service("sysRoleService")
public class SysRoleServiceImpl extends BaseServiceImpl<SysRole> implements SysRoleService{
}
