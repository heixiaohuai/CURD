package com.hk.test;

import com.hk.dao.DepartmentMapper;
import com.hk.dao.EmployeeMapper;
import com.hk.pojo.Department;
import com.hk.pojo.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Random;
import java.util.UUID;

/**
 * @Classname TestMapper
 * @Description TODO
 * @Date 2019/7/17 14:17
 * @Created by 13055
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:ApplicationContext.xml"})
public class TestMapper {
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;

	@Test
	public void testCURD(){
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("ApplicationContext.xml");
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);

		//1、插入几个部门
//		departmentMapper.insertSelective(new Department(null, "开发部"));
//		departmentMapper.insertSelective(new Department(null, "测试部"));
//		departmentMapper.insertSelective(new Department(null, "运营部"));

//		employeeMapper.insertSelective(new Employee(null,"张三",24,"M","1305558920@qq.com",1));
//		employeeMapper.insertSelective(new Employee(null,"小芳",29,"F","1233232190@qq.com",2));
//		employeeMapper.insertSelective(new Employee(null,"赵云",28,"M","7987892312@qq.com",3));

		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for (int i = 0; i < 100; i++) {
			String emp_name = UUID.randomUUID().toString().substring(0, 5);
			String emp_email = emp_name+"@qq.com";
			Random random = new Random();
			int emp_age = random.nextInt(23)+22;
			mapper.insertSelective(new Employee(null, emp_name, emp_age,"M", emp_email, 1));
		}

//		employeeMapper.deleteByPrimaryKey(59);
	}
}
