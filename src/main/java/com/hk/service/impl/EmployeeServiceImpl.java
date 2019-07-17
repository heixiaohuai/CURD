package com.hk.service.impl;

import com.hk.dao.EmployeeMapper;
import com.hk.pojo.Employee;
import com.hk.service.EmployeeService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Classname EmployeeServiceImpl
 * @Description TODO
 * @Date 2019/7/17 15:47
 * @Created by 13055
 */
@Service
public class EmployeeServiceImpl implements EmployeeService {

	@Resource
	EmployeeMapper employeeMapper;

	/**
	 * @Description 查询所有的员工
	 * @param
	 * @return java.util.List<com.hk.pojo.Employee>
	 * @date 2019/7/17 15:49
	 * @author 13055
	 */
	@Override
	public List<Employee> getAll() {
		return employeeMapper.selectByExampleWithDept(null);
	}
}
