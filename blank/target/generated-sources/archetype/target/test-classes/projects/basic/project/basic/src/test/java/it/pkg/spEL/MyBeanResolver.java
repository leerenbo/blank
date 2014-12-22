package it.pkg.spEL;

import org.springframework.expression.AccessException;
import org.springframework.expression.BeanResolver;
import org.springframework.expression.EvaluationContext;

public class MyBeanResolver implements BeanResolver {
	@Override
	public Object resolve(EvaluationContext arg0, String arg1) throws AccessException {
		System.out.println(arg0);
		System.out.println(arg1);
		return true;
	}
}
