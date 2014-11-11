package com.datalook.spEL;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.common.TemplateParserContext;
import org.springframework.expression.spel.SpelParserConfiguration;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;

public class Ex85x {

	@Test
	public void Literalexpressions() {
		ExpressionParser parser = new SpelExpressionParser();

		// evals to "Hello World"
		String helloWorld = (String) parser.parseExpression("'Hello World'").getValue();
		System.out.println(helloWorld);

		double avogadrosNumber = (Double) parser.parseExpression("6.0221415E+23").getValue();
		System.out.println(avogadrosNumber);
		// evals to 2147483647
		int maxValue = (Integer) parser.parseExpression("0x7FFFFFFF").getValue();
		System.out.println(maxValue);

		boolean trueValue = (Boolean) parser.parseExpression("true").getValue();
		System.out.println(trueValue);

		Object nullValue = parser.parseExpression("null").getValue();
		System.out.println(nullValue);
	}

	@Test
	public void PropertiesArraysListsMapsIndexers() {
		Inventor i = new Inventor("tesla", new Date(), "china");
		i.setPlaceOfBirth(new PlaceOfBirth("dalian"));
		i.setInventions(new String[] { "asdf", "qwer", "zxcv" });
		StandardEvaluationContext context = new StandardEvaluationContext(i);

		Society s = new Society();
		s.getMembers().add(i);
		Inventor i2 = new Inventor("lirenbo", "where");
		s.getMembers().add(i2);
		s.getOfficers().put("president", i);
		s.getOfficers().put("advisors", s.getMembers());
		StandardEvaluationContext societyContext = new StandardEvaluationContext(s);

		ExpressionParser parser = new SpelExpressionParser();

		int year = (Integer) parser.parseExpression("Birthdate.Year + 1900").getValue(context);
		System.out.println(year);

		String city = (String) parser.parseExpression("placeOfBirth.City").getValue(context);
		System.out.println(city);

		String invention = parser.parseExpression("inventions[2]").getValue(context, String.class);
		System.out.println(invention);

		String name = parser.parseExpression("Members[0].Name").getValue(societyContext, String.class);
		System.out.println(name);
		// List and Array navigation
		// evaluates to "Wireless communication"
		String invention2 = parser.parseExpression("Members[0].Inventions[2]").getValue(societyContext, String.class);
		System.out.println(invention2);

		Inventor pupin = parser.parseExpression("Officers[president]").getValue(societyContext, Inventor.class);
		System.out.println(pupin);

		// evaluates to "Idvor"
		String city2 = parser.parseExpression("Officers[president].PlaceOfBirth.City").getValue(societyContext, String.class);
		System.out.println(city2);

		// setting values
		parser.parseExpression("Officers[advisors][0].PlaceOfBirth.Country").setValue(societyContext, "Croatia");
		System.out.println(((Inventor) s.getMembers().get(0)).getPlaceOfBirth().getCountry());
	}

	@Test
	public void Inlinelists() {
		StandardEvaluationContext context = new StandardEvaluationContext();
		ExpressionParser parser = new SpelExpressionParser();
		List numbers = (List) parser.parseExpression("{1,2,3,4}").getValue(context);
		System.out.println(numbers);
		List listOfLists = (List) parser.parseExpression("{{'a','b'},{'x','y'}}").getValue(context);
		System.out.println(listOfLists);
	}

	@Test
	public void InlineMaps() {
		StandardEvaluationContext context = new StandardEvaluationContext();
		ExpressionParser parser = new SpelExpressionParser();
		Map inventorInfo = (Map) parser.parseExpression("{name:'Nikola',dob:'10-July-1856'}").getValue(context);
		System.out.println(inventorInfo);
		Map mapOfMaps = (Map) parser.parseExpression("{name:{first:'Nikola',last:'Tesla'},dob:{day:10,month:'July',year:1856}}").getValue(context);
		System.out.println(mapOfMaps);
	}

	@Test
	public void Arrayconstruction() {
		StandardEvaluationContext context = new StandardEvaluationContext();
		ExpressionParser parser = new SpelExpressionParser();

		int[] numbers1 = (int[]) parser.parseExpression("new int[4]").getValue(context);
		System.out.println(numbers1);
		// Array with initializer
		int[] numbers2 = (int[]) parser.parseExpression("new int[]{1,2,3}").getValue(context);
		System.out.println(numbers2);
		// Multi dimensional array
		int[][] numbers3 = (int[][]) parser.parseExpression("new int[4][5]").getValue(context);
		System.out.println(numbers3);
	}

	@Test
	public void Methods() {

		Inventor i = new Inventor("tesla", new Date(), "china");
		i.setPlaceOfBirth(new PlaceOfBirth("dalian"));
		i.setInventions(new String[] { "asdf", "qwer", "zxcv" });
		StandardEvaluationContext context = new StandardEvaluationContext(i);

		Society s = new Society();
		s.getMembers().add(i);
		Inventor i2 = new Inventor("lirenbo", "where");
		s.getMembers().add(i2);
		s.getOfficers().put("president", i);
		s.getOfficers().put("advisors", s.getMembers());
		StandardEvaluationContext societyContext = new StandardEvaluationContext(s);

		ExpressionParser parser = new SpelExpressionParser();

		// string literal, evaluates to "bc"
		String c = parser.parseExpression("'abc'.substring(1, 3)").getValue(String.class);
		System.out.println(c);
		// evaluates to true
		boolean isMember = parser.parseExpression("isMember('Mihajlo Pupin')").getValue(societyContext, Boolean.class);
		System.out.println(isMember);

	}

	@Test
	public void Operators() {
		Inventor i = new Inventor("tesla", new Date(), "china");
		i.setPlaceOfBirth(new PlaceOfBirth("dalian"));
		i.setInventions(new String[] { "asdf", "qwer", "zxcv" });
		StandardEvaluationContext context = new StandardEvaluationContext(i);

		Society s = new Society();
		s.getMembers().add(i);
		Inventor i2 = new Inventor("lirenbo", "where");
		s.getMembers().add(i2);
		s.getOfficers().put("president", i);
		s.getOfficers().put("advisors", s.getMembers());
		StandardEvaluationContext societyContext = new StandardEvaluationContext(s);

		ExpressionParser parser = new SpelExpressionParser();

		// evaluates to true
		boolean trueValue1 = parser.parseExpression("2 == 2").getValue(Boolean.class);
		System.out.println(trueValue1);

		// evaluates to false
		boolean falseValue1 = parser.parseExpression("2 < -5.0").getValue(Boolean.class);
		System.out.println(falseValue1);

		// evaluates to true
		boolean trueValue2 = parser.parseExpression("'black' < 'block'").getValue(Boolean.class);
		System.out.println(trueValue2);

		// evaluates to false
		boolean falseValue2 = parser.parseExpression("'xyz' instanceof T(int)").getValue(Boolean.class);
		System.out.println(falseValue2);

		// evaluates to true
		boolean trueValue3 = parser.parseExpression("'5.00' matches '^-?\\d+(\\.\\d{2})?$'").getValue(Boolean.class);
		System.out.println(trueValue3);

		// evaluates to false
		boolean falseValue3 = parser.parseExpression("'5.0067' matches '^-?\\d+(\\.\\d{2})?$'").getValue(Boolean.class);
		System.out.println(falseValue3);

		// -- AND --
		// evaluates to false
		boolean falseValue4 = parser.parseExpression("true and false").getValue(Boolean.class);
		System.out.println(falseValue4);
		// evaluates to true
		boolean trueValue4 = parser.parseExpression("isMember('Nikola Tesla') and isMember('lirenbo')").getValue(societyContext, Boolean.class);
		System.out.println(trueValue4);

		// -- OR --
		// evaluates to true
		boolean trueValue5 = parser.parseExpression("true or false").getValue(Boolean.class);
		System.out.println(trueValue5);
		// evaluates to true
		boolean trueValue6 = parser.parseExpression("isMember('tesla') and isMember('lirenbo')").getValue(societyContext, Boolean.class);
		System.out.println(trueValue6);

		// -- NOT --
		// evaluates to false
		boolean falseValue5 = parser.parseExpression("!true").getValue(Boolean.class);
		System.out.println(falseValue5);

		// -- AND and NOT --
		boolean falseValue6 = parser.parseExpression("isMember('Nikola Tesla') and !isMember('lirenbo')").getValue(societyContext, Boolean.class);
		System.out.println(falseValue6);

	}

	@Test
	public void Mathematicaloperators() {
		ExpressionParser parser = new SpelExpressionParser();

		// Addition
		int two = parser.parseExpression("1 + 1").getValue(Integer.class); // 2
		System.out.println(two);

		String testString = parser.parseExpression("'test' + ' ' + 'string'").getValue(String.class); // test string
		System.out.println(testString);

		// Subtraction
		int four = parser.parseExpression("1 - -3").getValue(Integer.class); // 4
		System.out.println(four);

		double d = parser.parseExpression("1000.00 - 1e4").getValue(Double.class); // -9000
		System.out.println(d);

		// Multiplication
		int six = parser.parseExpression("-2 * -3").getValue(Integer.class); // 6
		System.out.println(six);

		double twentyFour = parser.parseExpression("2.0 * 3e0 * 4").getValue(Double.class); // 24.0
		System.out.println(twentyFour);

		// Division
		int minusTwo = parser.parseExpression("6 / -3").getValue(Integer.class); // -2
		System.out.println(minusTwo);

		double one = parser.parseExpression("8.0 / 4e0 / 2").getValue(Double.class); // 1.0
		System.out.println(one);

		// Modulus
		int three = parser.parseExpression("7 % 4").getValue(Integer.class); // 3
		System.out.println(three);

		int one1 = parser.parseExpression("8 / 5 % 2").getValue(Integer.class); // 1
		System.out.println(one1);

		// Operator precedence
		int minusTwentyOne = parser.parseExpression("1+2-3*8").getValue(Integer.class); // -21
		System.out.println(minusTwentyOne);

	}

	@Test
	public void Assignment() {
		ExpressionParser parser = new SpelExpressionParser();

		Inventor inventor = new Inventor();
		StandardEvaluationContext inventorContext = new StandardEvaluationContext(inventor);

		parser.parseExpression("Name").setValue(inventorContext, "Alexander Seovic2");
		System.out.println(inventor.getName());
		// alternatively
		String aleks = parser.parseExpression("Name = 'Alexandar Seovic'").getValue(inventorContext, String.class);
		System.out.println(inventor.getName());
	}

	@Test
	public void Types() {
		ExpressionParser parser = new SpelExpressionParser();

		Class dateClass = parser.parseExpression("T(java.util.Date)").getValue(Class.class);
		System.out.println(dateClass);

		Class stringClass = parser.parseExpression("T(String)").getValue(Class.class);
		System.out.println(stringClass);

		boolean trueValue = parser.parseExpression("T(java.math.RoundingMode).CEILING < T(java.math.RoundingMode).FLOOR").getValue(Boolean.class);
		System.out.println(trueValue);

	}

	@Test
	public void Constructors() {
		ExpressionParser p = new SpelExpressionParser();

		Society s = new Society();
		StandardEvaluationContext societyContext = new StandardEvaluationContext(s);

		Inventor einstein = p.parseExpression("new com.datalook.spEL.Inventor('Albert Einstein', 'German')").getValue(Inventor.class);
		System.out.println(einstein);
		// create new inventor instance within add method of List
		p.parseExpression("Members.add(new com.datalook.spEL.Inventor('Albert Einstein', 'German'))").getValue(societyContext);
		System.out.println(s.getMembers().size());
	}

	@Test
	public void Variables() {
		ExpressionParser parser = new SpelExpressionParser();

		Inventor tesla = new Inventor("Nikola Tesla", "Serbian");
		StandardEvaluationContext context = new StandardEvaluationContext(tesla);
		context.setVariable("newName", "Mike Tesla");

		parser.parseExpression("Name = #newName").getValue(context);
		System.out.println(tesla.getName()); // "Mike Tesla"

	}

	@Test
	public void thisandrootvariables() {
		// create an array of integers
		List<Integer> primes = new ArrayList<Integer>();
		primes.addAll(Arrays.asList(2, 3, 5, 7, 11, 13, 17));

		// create parser and set variable primes as the array of integers
		ExpressionParser parser = new SpelExpressionParser();
		StandardEvaluationContext context = new StandardEvaluationContext();
		context.setVariable("primes", primes);

		// all prime numbers > 10 from the list (using selection ?{...})
		// evaluates to [11, 13, 17]
		List<Integer> primesGreaterThanTen = (List<Integer>) parser.parseExpression("#primes.?[#this>10]").getValue(context);
		System.out.println(primesGreaterThanTen);
	}

	@Test
	public void Functions() throws NoSuchMethodException, SecurityException {
		ExpressionParser parser = new SpelExpressionParser();
		StandardEvaluationContext context = new StandardEvaluationContext();

		context.registerFunction("reverseString", StringUtils.class.getDeclaredMethod("reverseString", new Class[] { String.class }));

		String helloWorldReversed = parser.parseExpression("#reverseString('hello')").getValue(context, String.class);
		System.out.println(helloWorldReversed);

		String helloWorldReversed2 = parser.parseExpression("T(com.datalook.spEL.StringUtils).reverseString('hello')").getValue(context, String.class);
		System.out.println(helloWorldReversed2);

	}

	@Test
	public void Beanreferences() {
		ExpressionParser parser = new SpelExpressionParser();
		StandardEvaluationContext context = new StandardEvaluationContext();
		context.setBeanResolver(new MyBeanResolver());

		// This will end up calling resolve(context,"foo") on MyBeanResolver during evaluation
		Object bean = parser.parseExpression("@foo").getValue(context);
		System.out.println(bean);
	}

	@Test
	public void IfThenElse() {
		ExpressionParser parser = new SpelExpressionParser();
		String falseString = parser.parseExpression("false ? 'trueExp' : 'falseExp'").getValue(String.class);
		System.out.println(falseString);

		Inventor i = new Inventor("tesla", new Date(), "china");
		i.setPlaceOfBirth(new PlaceOfBirth("dalian"));
		i.setInventions(new String[] { "asdf", "qwer", "zxcv" });
		StandardEvaluationContext context = new StandardEvaluationContext(i);

		Society s = new Society();
		s.getMembers().add(i);
		Inventor i2 = new Inventor("lirenbo", "where");
		s.getMembers().add(i2);
		s.getOfficers().put("president", i);
		s.getOfficers().put("advisors", s.getMembers());
		StandardEvaluationContext societyContext = new StandardEvaluationContext(s);

		parser.parseExpression("Name").setValue(societyContext, "IEEE");
		societyContext.setVariable("queryName", "Nikola Tesla");

		String expression = "isMember(#queryName)? #queryName + ' is a member of the ' + Name + ' Society' : #queryName + ' is not a member of the ' + Name + ' Society'";
		System.out.println(expression);
		String queryResultString = parser.parseExpression(expression).getValue(societyContext, String.class);
		// queryResultString = "Nikola Tesla is a member of the IEEE Society"
		System.out.println(queryResultString);
	}

	@Test
	public void ElvisOperator() {
		// 缩写3元表达式 name != null ? name : "Unknown";
		ExpressionParser parser = new SpelExpressionParser();

		String name = parser.parseExpression("null?:'Unknown'").getValue(String.class);

		System.out.println(name); // Unknown

		parser = new SpelExpressionParser();

		Inventor tesla = new Inventor("Nikola Tesla", "Serbian");
		StandardEvaluationContext context = new StandardEvaluationContext(tesla);

		name = parser.parseExpression("Name?:'Elvis Presley'").getValue(context, String.class);

		System.out.println(name); // Nikola Tesla

		tesla.setName(null);

		name = parser.parseExpression("Name?:'Elvis Presley'").getValue(context, String.class);

		System.out.println(name); // Elvis Presley
	}

	@Test
	public void SafeNavigationoperator() {
		ExpressionParser parser = new SpelExpressionParser();

		Inventor tesla = new Inventor("Nikola Tesla", "Serbian");
		tesla.setPlaceOfBirth(new PlaceOfBirth("Smiljan"));

		StandardEvaluationContext context = new StandardEvaluationContext(tesla);

		String city = parser.parseExpression("PlaceOfBirth?.City").getValue(context, String.class);
		System.out.println(city); // Smiljan

		tesla.setPlaceOfBirth(null);

		city = parser.parseExpression("PlaceOfBirth?.City").getValue(context, String.class);

		System.out.println(city); // null - does not throw NullPointerException!!!
	}

	@Test
	public void CollectionSelection() {
		// $[...]匹配的第一个
		// ^[...]匹配的最后一个
		ExpressionParser parser = new SpelExpressionParser();

		Inventor i = new Inventor("tesla", new Date(), "china");
		i.setPlaceOfBirth(new PlaceOfBirth("dalian"));
		i.setInventions(new String[] { "asdf", "qwer", "zxcv" });
		StandardEvaluationContext context = new StandardEvaluationContext(i);

		Society s = new Society();
		s.getMembers().add(i);
		Inventor i2 = new Inventor("lirenbo", "where");
		s.getMembers().add(i2);
		s.getOfficers().put("president", i);
		s.getOfficers().put("advisors", s.getMembers());
		StandardEvaluationContext societyContext = new StandardEvaluationContext(s);

		List<Inventor> list = (List<Inventor>) parser.parseExpression("Members.?[Nationality == 'Serbian']").getValue(societyContext);
		System.out.println(list);

		HashMap<String, Integer> h = new HashMap<>();
		h.put("a", 12);
		Map newMap = (Map) parser.parseExpression("#root.?[value<27]").getValue(h);
		System.out.println(newMap);
	}

	@Test
	public void CollectionProjection() {
		Inventor i = new Inventor("tesla", new Date(), "china");
		i.setPlaceOfBirth(new PlaceOfBirth("dalian"));
		i.setInventions(new String[] { "asdf", "qwer", "zxcv" });
		StandardEvaluationContext context = new StandardEvaluationContext(i);

		Society s = new Society();
		s.getMembers().add(i);
		Inventor i2 = new Inventor("lirenbo", "where");
		s.getMembers().add(i2);
		s.getOfficers().put("president", i);
		s.getOfficers().put("advisors", s.getMembers());
		StandardEvaluationContext societyContext = new StandardEvaluationContext(s);

		ExpressionParser parser = new SpelExpressionParser(new SpelParserConfiguration(true, true));
		List placesOfBirth = (List) parser.parseExpression("Members.![placeOfBirth.city]").getValue(societyContext);
		System.out.println(placesOfBirth);
	}

	@Test
	public void Expressiontemplating() {
		ExpressionParser parser = new SpelExpressionParser();

		String randomPhrase = parser.parseExpression("random number is #{T(java.lang.Math).random()}", new TemplateParserContext()).getValue(String.class);
		System.out.println(randomPhrase);
	}

}
