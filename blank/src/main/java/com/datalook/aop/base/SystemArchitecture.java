package com.datalook.aop.base;


import org.aspectj.lang.annotation.Pointcut;

public class SystemArchitecture {

    /*
     * A join point is in the web layer if the method is defined
     * in a type in the com.xyz.someapp.web package or any sub-package
     * under that.
     */
    @Pointcut("within(com.datalook.action..*)")
    public void inActionLayer() {}

    /*
     * A join point is in the service layer if the method is defined
     * in a type in the com.xyz.someapp.service package or any sub-package
     * under that.
     */
    @Pointcut("within(com.datalook.service..*)")
    public void inServiceLayer() {}

    /*
     * A join point is in the data access layer if the method is defined
     * in a type in the com.xyz.someapp.dao package or any sub-package
     * under that.
     */
    @Pointcut("within(com.datalook.dao..*)")
    public void inDAOLayer() {}

    @Pointcut("execution(* set*(..))")
    public void setOperation() {}

    @Pointcut("execution(* get*(..))")
    public void getOperation() {}

}