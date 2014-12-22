#set( $symbol_pound = '#' )
#set( $symbol_dollar = '$' )
#set( $symbol_escape = '\' )
package ${package}.jBPM;

import javax.annotation.Resource;

import org.jbpm.test.JbpmJUnitBaseTestCase;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.kie.api.io.ResourceType;
import org.kie.api.runtime.KieSession;
import org.kie.api.runtime.manager.RuntimeEngine;
import org.kie.api.runtime.manager.RuntimeEnvironment;
import org.kie.api.runtime.manager.RuntimeEnvironmentBuilder;
import org.kie.api.runtime.manager.RuntimeManager;
import org.kie.api.runtime.manager.RuntimeManagerFactory;
import org.kie.api.runtime.process.ProcessInstance;
import org.kie.internal.io.ResourceFactory;
import org.kie.internal.runtime.manager.context.EmptyContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * This is a sample file to test a process.
 */
@RunWith(SpringJUnit4ClassRunner.class) 
@ContextConfiguration(locations={"classpath:applicationContext.xml","classpath:jBPM6.xml"}) 
public class ProcessT extends JbpmJUnitBaseTestCase {

	@Resource(name="runtimeManager")
	RuntimeManager runtimeManager;
	
	@Test
	public void testProcess() {
		RuntimeEngine engine = runtimeManager.getRuntimeEngine(null);
		KieSession ksession = engine.getKieSession();

		ProcessInstance processInstance = ksession.startProcess("com.sample.bpmn.hello");

		runtimeManager.disposeRuntimeEngine(engine);
		runtimeManager.close();
	}

	public static void main(String[] args) {
		org.kie.api.io.Resource r=org.kie.internal.io.ResourceFactory.newClassPathResource("jbpm/processes/sample.bpmn2");
		// 先设置会被RuntimeManager的设置 first configure environment that will be used
		// by RuntimeManager
		RuntimeEnvironment environment = RuntimeEnvironmentBuilder.Factory.get().newEmptyBuilder().addAsset(r, ResourceType.BPMN2).get();
		// 接着，创建RuntimeManager-下面例子中是单例策略 next create RuntimeManager - in this
		// case singleton strategy is chosen
		RuntimeManager manager = RuntimeManagerFactory.Factory.get().newSingletonRuntimeManager(environment);
		// then get RuntimeEngine out of manager - using empty context as
		// singleton does not keep track of runtime engine as there is only one
		// 然后从manager中获得RuntimeEngine-使用空上下文，因为单例不需要保留runtime引擎的痕迹，因为引擎只有一个。
		RuntimeEngine runtimeEngine = manager.getRuntimeEngine(EmptyContext.get());
		// get KieSession from runtime runtimeEngine - already initialized with
		// all handlers, listeners, etc that were configured on the environment
		// 从RuntimeEngine获取KieSession-已经初始换好所有，handlers,listeners，等我们再environment设置好的
		KieSession ksession = runtimeEngine.getKieSession();
		ksession.setGlobal("test", "haha");
		ProcessInstance processInstance = ksession.startProcess("com.sample.bpmn.hello");
		
		// 添加流程引擎的调用 add invocations to the process engine here,
		// 例如 e.g. ksession.startProcess(processId);
		// 最后释放 RuntimeEngine and last dispose the runtime engine
		manager.disposeRuntimeEngine(runtimeEngine);

	}

}