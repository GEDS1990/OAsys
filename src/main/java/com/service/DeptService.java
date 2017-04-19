package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.DeptDAO;
import com.entity.Dept;
import com.entity.Job;

@Service
@Transactional
public class DeptService {
	@Autowired
	DeptDAO deptDAO;

	public List<Dept> getDepts() {
		return deptDAO.getDepts();

	}

	public Dept getDept(int deptId) {
		return deptDAO.getDept(deptId);
	}

	public void addDept(Dept dept) {
		deptDAO.addDept(dept);
	}

	public void deleteDeptById(int deptId) {
		deptDAO.deleteDeptById(deptId);
	}

	public void updateDept(Dept dept) {
		deptDAO.updateDept(dept);
	}

	public List<Job> getJobList() {
		return deptDAO.getJobList();
	}
}
