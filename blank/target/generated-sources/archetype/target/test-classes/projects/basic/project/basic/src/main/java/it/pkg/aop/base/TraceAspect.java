package it.pkg.aop.base;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.util.StopWatch;

import it.pkg.util.base.LogUtil;

@Aspect
@Component
public class TraceAspect {
	
	@Order(1)
	@Around("it.pkg.aop.base.SystemArchitecture.inActionLayer() && !it.pkg.aop.base.SystemArchitecture.setOperation() && !it.pkg.aop.base.SystemArchitecture.getOperation()")
	public Object traceProfile(ProceedingJoinPoint pjp) throws Throwable{
		StopWatch sw = new StopWatch();
		Object re = null;
		try {
			LogUtil.trace("[进入方法]"+pjp.getTarget().getClass().getName()+"-->"+pjp.getSignature().getName());
			sw.start();
			re=pjp.proceed(pjp.getArgs());
			LogUtil.trace("[退出方法]"+pjp.getTarget().getClass().getName()+"-->"+pjp.getSignature().getName());
		} catch (Throwable e) {
			LogUtil.trace("[方法异常]"+pjp.getTarget().getClass().getName()+"-->"+pjp.getSignature().getName());
			throw e;
		} finally {
			sw.stop();
			LogUtil.trace("[运行时间]:"+sw.getTotalTimeSeconds());
		}
		return re;
	}
}
