package com.controller;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Employees;
import com.service.EmpLoyeeService;

import tools.Auth;

@Controller
@RequestMapping("/Staff")
public class StaffController {
	@Autowired
	private EmpLoyeeService employeeServie;

	@RequestMapping("/add")
	@Auth("more")
	public String addEmployee(Employees employees) {
		employeeServie.addEmployees(employees);
		return "redirect:/Staff/";
	}

	@RequestMapping()
	@Auth("more")
	public String redirect() {
		return "StaffManagement";
	}

	@RequestMapping("/search")
	@ResponseBody
	public List<Employees> search() {
		return employeeServie.getEmployees();

	}

	@RequestMapping("/delete")
	@ResponseBody
	public String delete(String id) {
		employeeServie.deleteEmployeesByID(id);
		return "success";
	}

	@RequestMapping("/update")
	@Auth("more")
	public String update(Employees employees, HttpServletRequest request) {
		employeeServie.updateEmployees(employees);
		Employees user = (Employees) request.getSession().getAttribute("user");
		int id = user.getEmployeeId();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("birthday");
		user = employeeServie.getEmployeesByID(id);
		String birthday;
		if (user.getBirthday() != null)
			birthday = sdf.format(user.getBirthday());
		else
			birthday = "";
		request.getSession().setAttribute("birthday", birthday);
		request.getSession().setAttribute("user", user);
		return "redirect:/Staff/";
	}

	@RequestMapping("/checkId")
	@ResponseBody
	public String checkId(int id) {
		if (employeeServie.getEmployeesByID(id) == null)
			return "fail";
		else
			return "success";
	}
}
