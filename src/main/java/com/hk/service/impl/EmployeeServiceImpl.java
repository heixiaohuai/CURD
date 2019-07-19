package com.hk.service.impl;

import com.hk.dao.EmployeeMapper;
import com.hk.pojo.Employee;
import com.hk.pojo.EmployeeExample;
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

	@Override
	public void saveEmp(Employee employee) {
		employeeMapper.insertSelective(employee);
	}

	@Override
	public boolean checkEmail(String emial) {
		EmployeeExample example = new EmployeeExample();
		EmployeeExample.Criteria criteria = example.createCriteria();
		criteria.andEmpEmailEqualTo(emial);
		long count = employeeMapper.countByExample(example);
		return count == 0 ;
	}

	@Override
	public Employee getEmp(Integer id) {
		return employeeMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateEmp(Employee employee) {
		//根据z
		employeeMapper.updateByPrimaryKeySelective(employee);
	}

	@Override
	public void deleteEmpById(Integer id) {
		employeeMapper.deleteByPrimaryKey(id);
	}

	@Override
	public void deleteEmpBatch(List<Integer> ids) {
		EmployeeExample example = new EmployeeExample();
		EmployeeExample.Criteria criteria = example.createCriteria();
		criteria.andEmpIdIn(ids);
		employeeMapper.deleteByExample(example);
	}
}
