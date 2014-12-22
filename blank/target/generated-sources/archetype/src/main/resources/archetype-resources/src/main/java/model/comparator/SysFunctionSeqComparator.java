#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.model.comparator;

import java.util.Comparator;

import ${package}.model.sys.SysFunction;

public class SysFunctionSeqComparator implements Comparator<SysFunction>{
	@Override
	public int compare(SysFunction o1, SysFunction o2) {
		if(o1.getSeq()>o2.getSeq()){
			return 1;
		}
		else if(o1.getSeq()==o2.getSeq()){
			return 0;
		}else{
			return -1;
		}
	}
}