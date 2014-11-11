package com.datalook.spEL;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.SpelCompilerMode;
import org.springframework.expression.spel.SpelParserConfiguration;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

public class Ex83x {

	@Test
	public void e1() {
		class Simple {
			public List<Boolean> booleanList = new ArrayList<Boolean>();
		}

		Simple simple = new Simple();

		simple.booleanList.add(true);

		StandardEvaluationContext simpleContext = new StandardEvaluationContext(simple);

		ExpressionParser parser = new SpelExpressionParser();
		// false is passed in here as a string. SpEL and the conversion service will
		// correctly recognize that it needs to be a Boolean and convert it
		parser.parseExpression("booleanList[0]").setValue(simpleContext, "false");

		// b will be false
		Boolean b = simple.booleanList.get(0);
		System.out.println(b);
	}

	@Test
	public void e2() {
		class Demo {
			public List<String> list;
		}

		// Turn on:
		// - auto null reference initialization
		// - auto collection growing
		SpelParserConfiguration config = new SpelParserConfiguration(true, true);

		ExpressionParser parser = new SpelExpressionParser(config);

		Expression expression = parser.parseExpression("list[3]");

		Demo demo = new Demo();

		Object o = expression.getValue(demo);
		System.out.println(demo.list.size());
		// demo.list will now be a real collection of 4 entries
		// Each entry is a new empty String

	}

	@Test
	public void e3() {
		class MyMessage{
			public String payload="asdf";
		}
		SpelParserConfiguration config = new SpelParserConfiguration(SpelCompilerMode.IMMEDIATE, this.getClass().getClassLoader());

		SpelExpressionParser parser = new SpelExpressionParser(config);

		Expression expr = parser.parseExpression("payload");

		MyMessage message = new MyMessage();

		Object payload = expr.getValue(message);
		System.out.println(payload);
	}


}
