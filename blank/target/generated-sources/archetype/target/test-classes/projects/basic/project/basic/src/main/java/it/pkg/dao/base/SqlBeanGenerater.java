package it.pkg.dao.base;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.cglib.beans.BeanGenerator;
import org.springframework.cglib.beans.BulkBean;

import it.pkg.util.base.StringUtil;


public class SqlBeanGenerater {
	
	private static HashMap<String, SqlBeanPlaceHolder> hmssbph=new HashMap<String,SqlBeanPlaceHolder>();
	
	public static List<Object> generateBySqlList(String sql,List<Object[]> los){
		List<Object> re=new ArrayList<Object>();
		for (Object[] objects : los) {
			re.add(generateBySqlObject(sql,objects));
		}
		return re;
	}

	public static Object generateBySqlObject(String sql,Object[] os){
		String selectstr=StringUtils.substringBetween(sql, "select", "from");
		SqlBeanPlaceHolder sbph;
		if(hmssbph.containsKey(selectstr)){
			sbph=hmssbph.get(selectstr);
		}else{
			String[] selects=selectstr.split(",");

			String[] names=new String[os.length];
			for (int i=0;i<selects.length;i++) {
				String select=selects[i];
				String[] parts=select.split(" ");
				if(parts.length==0){
					continue;
				}
				if(parts.length==1){
					names[i]=parts[0].trim();
					continue;
				}
				if(parts.length==2){
					names[i]=parts[1].trim();
					continue;
				}
				if(parts.length==3){
					names[i]=parts[2].trim();
					continue;
				}
			}
			sbph=new SqlBeanPlaceHolder();
			sbph.types=new Class[names.length];
			sbph.getters=new String[names.length];
			sbph.setters=new String[names.length];
			for (int i = 0; i < names.length; i++) {
				sbph.bg.addProperty(names[i],os[i].getClass());
				sbph.types[i]=os[i].getClass();
				sbph.getters[i]=StringUtil.addPrefix("get", names[i]);
				sbph.setters[i]=StringUtil.addPrefix("set", names[i]);
			}
			sbph.clazz=(Class<?>)sbph.bg.createClass();
			sbph.bk=BulkBean.create(sbph.clazz, sbph.getters, sbph.setters, sbph.types);
			hmssbph.put(selectstr, sbph);
		}
		Object bean=sbph.bg.create();
		sbph.bk.setPropertyValues(bean, os);
		return bean;
	}

}

class SqlBeanPlaceHolder{
	BeanGenerator bg=new BeanGenerator();
	Class<?> clazz;
	String getters[];
	String setters[];
	Class<?> types[];
	BulkBean bk;
}

