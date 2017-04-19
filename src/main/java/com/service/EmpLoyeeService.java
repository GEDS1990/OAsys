package com.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.EmployeeDAO;
import com.entity.Employees;

@Service
@Transactional
public class EmpLoyeeService {
	@Autowired
	private EmployeeDAO employeeDAO;

	// 查找所有员工信息
	public List<Employees> getEmployees() {
		return employeeDAO.getEmployees();
	}

	// 根据ID查找员工信息
	public Employees getEmployeesByID(int id) {
		return employeeDAO.getEmployeesByID(id);
	}

	// 根据姓名查询
	public List<Employees> getEmployeesByName(String name) {
		return employeeDAO.getEmployeesByName(name);
	}

	public Employees getEmployeesByEmali(String email) {
		return employeeDAO.getEmployeesByEmail(email);
	}

	// 添加员工
	public void addEmployees(Employees employees) {
		employeeDAO.addEmployees(employees);
	}

	// 编辑员工信息
	public void updateEmployees(Employees employees) {
		Employees employees2 = employeeDAO.getEmployeesByID(employees.getEmployeeId());
		if (!employees.getAddress().isEmpty())
			employees2.setAddress(employees.getAddress());
		if (!employees.getAgreement().isEmpty())
			employees2.setAgreement(employees.getAgreement());
		if (!employees.getEmail().isEmpty())
			employees2.setEmail(employees.getEmail());
		if (!employees.getEmployeeName().isEmpty())
			employees2.setEmployeeName(employees.getEmployeeName());
		if (!employees.getMobile().isEmpty())
			employees2.setMobile(employees.getMobile());
		if (!employees.getNocode().isEmpty())
			employees2.setNocode(employees.getNocode());
		if (!employees.getSex().isEmpty())
			employees2.setSex(employees.getSex());
		/*
		 * if(!employees.getPhoto().isEmpty())
		 * employees2.setPhoto(employees.getPhoto());
		 */
		/*
		 * if (employees.getPwd() != null || !employees.getPwd().isEmpty())
		 * employees2.setPwd(employees.getPwd());
		 */
		if (employees.getBirthday() != null)
			employees2.setBirthday(employees.getBirthday());
		if (!employees.getLearn().isEmpty())
			employees2.setLearn(employees.getLearn());
		if (employees.getUserLevel() != 0)
			employees2.setUserLevel(employees.getUserLevel());
		if (!employees.getWorkState().isEmpty())
			employees2.setWorkState(employees.getWorkState());
		if (employees.getJob().getJobId() != 0) {
			employees2.setJob(employeeDAO.getJobById(employees.getJob().getJobId()));
		}
		if (employees.getDept().getDeptId() != 0) {
			employees2.setDept(employeeDAO.getDeptById(employees.getDept().getDeptId()));
		}
		employeeDAO.updateEmployees(employees2);
		;
	}

	// 根据ID删除员工
	public void deleteEmployeesByID(String id) {
		employeeDAO.deleteEmployeesByID(id);
	}
}
