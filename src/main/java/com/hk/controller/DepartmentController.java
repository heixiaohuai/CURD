package com.hk.controller;

import com.hk.pojo.Department;
import com.hk.pojo.Message;
import com.hk.service.DepartmentService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Classname DepartmentController
 * @Description TODO
 * @Date 2019/7/18 11:30
 * @Created by 13055
 */
@Controller
public class DepartmentController {
	@Resource
	private DepartmentService departmentServiceImpl;

	/**
	 * @Description 返回所有的部门信息并且封装在通用的Message类里面
	 * @param
	 * @return com.hk.pojo.Message
	 * @date 2019/7/18 11:35
	 * @author 13055
	 */
	@RequestMapping(value = "/getdepts")
	@ResponseBody
	public Message getDepts(){
		List<Department> departmentList = departmentServiceImpl.getDepartmentList();
		return Message.success().add("deptInfo", departmentList);
	}

}
