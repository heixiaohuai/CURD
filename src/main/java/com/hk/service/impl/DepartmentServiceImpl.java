package com.hk.service.impl;

import com.hk.dao.DepartmentMapper;
import com.hk.pojo.Department;
import com.hk.service.DepartmentService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @Classname DepartmentServiceImpl
 * @Description TODO
 * @Date 2019/7/18 11:31
 * @Created by 13055
 */
@Service
public class DepartmentServiceImpl implements DepartmentService {
	@Resource
	private DepartmentMapper departmentMapper;

	@Override
	public List<Department> getDepartmentList() {
		return departmentMapper.selectByExample(null);
	}
}
