package com.datalook.service.sys.implement;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;

import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.reflect.FieldUtils;
import org.apache.commons.lang3.reflect.MethodUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.datalook.dao.base.IBaseDao;
import com.datalook.model.sys.SysRole;
import com.datalook.model.sys.SysUser;
import com.datalook.service.base.BaseServiceImpl;
import com.datalook.service.sys.SysUserService;

/**
 * 用户业务逻辑
 * 
 * 
 */
@Service("sysUserService")
public class SysUserServiceImpl extends BaseServiceImpl<SysUser> implements SysUserService {
}
