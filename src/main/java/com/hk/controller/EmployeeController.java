package com.hk.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.hk.pojo.Employee;
import com.hk.pojo.Message;
import com.hk.service.EmployeeService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	 * @Description 将分页的信息以json格式返回，使用ResponseBody需要导入Jackson的jar
	 * @param
	 * @param pageNum
	 * @return com.github.pagehelper.PageInfo
	 * @date 2019/7/17 18:57
	 * @author 13055
	 */
	@RequestMapping(value = "/getemps")
	@ResponseBody
	public Message getEmpsWithJson(@RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum){
		//引入PageHelper分页插件，使用方法仅为传入的页码以及每一页的大小
		PageHelper.startPage(pageNum, 10);
		//startPage后面紧跟着的这个查询就是分页查询
		List<Employee> employeeList = employeeServiceImpl.getAll();
		//插叙完成后使用PageInfo包装查询后的信息，所以只需要将PageInfo返回给页面即可。
		//PageInfo中封装了详细的分页信息以及我们查询出来的分页信息，并且连续显示的页数（5页）
		PageInfo page = new PageInfo(employeeList, 3);
		return Message.success().add("pageInfo",page);
	}

	/**
	 * @Description 保存员工
	 * @param
	 * @return com.hk.pojo.Message
	 * @date 2019/7/18 12:09
	 * @author 13055
	 */
	@RequestMapping(value = "/emp", method = RequestMethod.POST)
	@ResponseBody
	public Message addEmps(@Valid Employee employee, BindingResult result){
		if (result.hasErrors()){
			Map<String, Object> errorMap = new HashMap<>();
			List<FieldError> fieldErrors = result.getFieldErrors();
			for (FieldError f : fieldErrors){
				errorMap.put(f.getField(),f.getDefaultMessage());
			}
			return Message.failed().add("errorFields", errorMap);
		}else {
			employeeServiceImpl.saveEmp(employee);
			return Message.success();
		}
	}

	/**
	 * @Description 检查邮箱是否可用
	 * @param
	 * @param email
	 * @return com.hk.pojo.Message
	 * @date 2019/7/18 15:43
	 * @author 13055
	 */
	@RequestMapping(value = "/checkemail")
	@ResponseBody
	public Message checkEmail(@Valid @RequestParam("empEmail") String email){
		boolean b = employeeServiceImpl.checkEmail(email);
		if (b){
			return Message.success();
		}else {
			return Message.failed();
		}
	}

	/**
	 * @Description 按照员工的id查询员工的信息
	 * @param
	 * @param id
	 * @return com.hk.pojo.Message
	 * @date 2019/7/18 18:48
	 * @author 13055
	 */
	@RequestMapping(value = "/emp/{id}", method = RequestMethod.GET)
	@ResponseBody
	public Message getEmp(@PathVariable("id") Integer id){
		Employee employee = employeeServiceImpl.getEmp(id);
		return Message.success().add("empInfo", employee);
	}


	/**
	 * @Description 员工更新的方法
	 * @param
	 * @param employee
	 * @return com.hk.pojo.Message
	 * @date 2019/7/18 20:15
	 * @author 13055
	 */
	@RequestMapping(value = "/emp/{empId}", method = RequestMethod.PUT)
	@ResponseBody
	public Message updateEmp(Employee employee){
		employeeServiceImpl.updateEmp(employee);
		return Message.success();
	}
	
	/**  
	 * @Description 删除单个员工，以及批量删除员工
	 * @param 
	 * @param ids
	 * @return com.hk.pojo.Message
	 * @date 2019/7/18 21:37
	 * @author 13055
	 */       
	@RequestMapping(value = "/emp/{ids}", method = RequestMethod.DELETE)
	@ResponseBody
	public Message deleteEmpById(@PathVariable("ids") String ids){
		//批量删除
		if (ids.contains("-")){
			String[] id = ids.split("-");
			List<Integer> idList = new ArrayList<>();
			for (String s : id) {
				idList.add(Integer.parseInt(s));
			}
			employeeServiceImpl.deleteEmpBatch(idList);
		}else {
			Integer id = Integer.parseInt(ids);
			employeeServiceImpl.deleteEmpById(id);
		}
		return Message.success();
	}


	/**
	 * @Description 员工分页查询
	 * @param
	 * @param pageNum
	 * @return java.lang.String
	 * @date 2019/7/17 15:52
	 * @author 13055
	 */
//	@RequestMapping(value = "/getemps")
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
