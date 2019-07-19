package com.hk.service;

import com.hk.pojo.Employee;

import java.util.List;

/**
 * @Classname EmployeeService
 * @Description TODO
 * @Date 2019/7/17 15:47
 * @Created by 13055
 */
public interface EmployeeService {
	List<Employee> getAll();
	void saveEmp(Employee employee);
	boolean checkEmail(String emial);
	Employee getEmp(Integer id);
	void updateEmp(Employee employee);
	void deleteEmpById(Integer id);
	void deleteEmpBatch(List<Integer> ids);
}
