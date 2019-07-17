package com.hk.test;

import com.hk.dao.DepartmentMapper;
import com.hk.pojo.Department;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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

	@Test
	public void testCURD(){
//		ApplicationContext ioc = new ClassPathXmlApplicationContext("ApplicationContext.xml");
//		DepartmentMapper bean = ioc.getBean(DepartmentMapper.class);

		System.out.println(departmentMapper);

		//1、插入几个部门
		departmentMapper.insertSelective(new Department(null, "开发部"));
		departmentMapper.insertSelective(new Department(null, "测试部"));
	}
}
