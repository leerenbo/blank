package it.pkg.util.base;

import java.util.Date;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;

@Component
public class LogUtil {
	
	private static Logger infoLogger = LogManager.getLogger("info");
	
	private static Logger errorLogger = LogManager.getLogger("error");
	
	private static Logger consoleLogger = LogManager.getLogger("trace");
	
	public static void info(Object o){
		infoLogger.info(o);
	}
	
	public static void error(Object o){
		errorLogger.error(o);
	}

	public static void trace(Object o){
		consoleLogger.trace(o);
	}
	
	public static void debug(Object o){
		consoleLogger.debug(o);
	}
	
	public static void fatal(Object o){
		consoleLogger.fatal(o);
	}
	
	public static void warn(Object o){
		consoleLogger.warn(o);
	}
//	@PostConstruct
	public void test() {
		long star=new Date().getTime();
		Logger logger = LogManager.getLogger("info");
		Logger logger2 = LogManager.getLogger("error");
		for(int i=0;i<1000000;i++){
			logger.info("info");
			logger2.error("error");
		}
		long end=new Date().getTime();
		System.out.println(end-star);
	}
}
