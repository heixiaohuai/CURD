package com.hk.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hk.pojo.Employee;
import com.hk.service.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Classname EmployeeController
 * @Description 处理员工的CRUD处理
 * @Date 2019/7/17 15:41
 * @Created by 13055
 */
@Controller
public class EmployeeController {
	@Resource
	EmployeeService employeeServiceImpl;

	/**
	 * @Description 员工分页查询
	 * @param
	 * @param pageNum
	 * @return java.lang.String
	 * @date 2019/7/17 15:52
	 * @author 13055
	 */
	@RequestMapping(value = "/getemps")
	public String getEmps(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
						  Model model){
		//引入PageHelper分页插件，使用方法仅为传入的页码以及每一页的大小
		PageHelper.startPage(pageNum, 10);
		//startPage后面紧跟着的这个查询就是分页查询
		List<Employee> employeeList = employeeServiceImpl.getAll();
		//插叙完成后使用PageInfo包装查询后的信息，所以只需要将PageInfo返回给页面即可。
		//PageInfo中封装了详细的分页信息以及我们查询出来的分页信息，并且连续显示的页数（5页）
		PageInfo page = new PageInfo(employeeList, 3);
		//使用Model返回数据
		model.addAttribute("pageInfo", page);

		return "list";
	}
}
