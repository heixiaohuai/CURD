package com.hk.test;

import com.github.pagehelper.PageInfo;
import com.hk.pojo.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Classname TestMVC
 * @Description 使用Spring测试模块提供的测试请求功能，测试crud请求的正确性
 * 				使用Spring4进行测试时，需要servlet3.0的支持，不然会抛出
 * 				java.lang.ClassNotFoundException: javax.servlet.SessionCookieConfig异常
 * @Date 2019/7/17 16:11
 * @Created by 13055
 */
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:ApplicationContext.xml","classpath:SpringMVC.xml"})
public class TestMVC {
	//传入SpringMVC的IOC
	@Resource
	WebApplicationContext context;
	//虚拟的MVC请求，获取到处理请求
	MockMvc mockMvc;

	@Before
	public void initMockMvc(){
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}

	@Test
	public void testRequest() throws Exception {
		//模拟请求并拿到返回值
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/getemps").param("pageNum", "8")).andReturn();
		//请求成功后，请求域中会有pageInfo，取出并进行验证
		MockHttpServletRequest request = result.getRequest();
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("当前页码-->"+pageInfo.getPageNum());
		System.out.println("总记录数-->"+pageInfo.getTotal());
//		System.out.println("连续显示的页数-->"+pageInfo.getNavigatepageNums());
		System.out.println("总页码数-->"+pageInfo.getPages());
		List<Employee> list = pageInfo.getList();
		for (Employee e:list) {
			System.out.println(e);
		}
	}
}
