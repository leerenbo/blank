package com.datalook.aop.base;

import javax.annotation.Resource;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.common.TemplateParserContext;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.stereotype.Component;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import com.datalook.action.base.BaseAction;
import com.datalook.exception.base.ToWebException;
import com.datalook.model.sys.SysDict;
import com.datalook.model.sys.easyui.Message;
import com.datalook.service.sys.SysDictService;
import com.datalook.util.base.LogUtil;

@Aspect
@Component
public class ExceptionAspect {

	@Resource(name="sysDictService")
	private SysDictService sysDictService;

	@Order(2000)
	@AfterThrowing(value = "com.datalook.aop.base.SystemArchitecture.inActionLayer()", throwing = "t")
	public void errorExceptionInActionLayer(JoinPoint jp, Throwable t) {
		Message re = new Message();
		if (t instanceof ToWebException) {
			ToWebException toWebException=(ToWebException)t;
			if (toWebException.isWriteLog()) {
				LogUtil.info("[人工异常]" + toWebException.getMessage());
			}
			re.setMsg(toWebException.getMessage());
		}else{
			t.printStackTrace();
			LogUtil.error(t);
			re.setMsg("系统异常，请联系管理员。");
		}
		((BaseAction) jp.getTarget()).writeJson(re);
	}

	@Order(500)
	@AfterThrowing(value = "com.datalook.aop.base.SystemArchitecture.inServiceLayer()", throwing = "toWebException")
	public void traceProfile(JoinPoint jp, ToWebException toWebException)
			throws Throwable {
		String express = null;
		String message = null;
		SysDict sysDict = null;
		if (toWebException.isUseMessage()) {
			express = toWebException.getMessage();
			message = new String(express);
		}
		if (toWebException.isUseCode()) {
			sysDict = sysDictService.getValue(jp.getTarget().getClass().getName()+"."+jp.getSignature().getName()+"()",toWebException.getCode());
			express = (sysDict!=null?sysDict.getValue():"");
			message = (sysDict!=null?sysDict.getValue():"");
		}
		
		if (express.contains("#{")) {
			ExpressionParser parser = new SpelExpressionParser();
			message = (String) parser.parseExpression(express,new TemplateParserContext()).getValue(jp.getArgs());
		}
		toWebException.setMessage(message);
		
		if (!toWebException.isCommitTransation()) {
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		}
	}
}
