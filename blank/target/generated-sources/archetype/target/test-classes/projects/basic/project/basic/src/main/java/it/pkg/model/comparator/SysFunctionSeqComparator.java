package it.pkg.model.comparator;

import java.util.Comparator;

import it.pkg.model.sys.SysFunction;

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