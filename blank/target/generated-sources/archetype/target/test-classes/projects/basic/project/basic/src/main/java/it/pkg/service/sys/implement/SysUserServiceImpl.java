package it.pkg.service.sys.implement;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.commons.lang3.reflect.MethodUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import it.pkg.dao.base.IBaseDao;
import it.pkg.model.sys.SysRole;
import it.pkg.model.sys.SysUser;
import it.pkg.service.base.BaseServiceImpl;
import it.pkg.service.sys.SysUserService;

/**
 * 用户业务逻辑
 * 
 * 
 */
@Service("sysUserService")
public class SysUserServiceImpl extends BaseServiceImpl<SysUser> implements SysUserService {
}
