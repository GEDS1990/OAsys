package test;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.hibernate.SessionFactory;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.entity.Employees;
import com.service.EmpLoyeeService;


public class JTest extends BaseJunit4Test {
	@Resource private SessionFactory sessionFactory;
	@Autowired private EmpLoyeeService eService;
@Test
public void test(){
	eService.deleteEmployeesByID("7");
	

}
}
