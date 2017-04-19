package com.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Dept;
import com.service.DeptService;

import tools.Auth;

@Controller
@RequestMapping("/Dept")
public class DeptController {

	@Autowired
	DeptService deptService;

	@RequestMapping("/show")
	@Auth(value = "most")
	public String redirect() {
		return "dept";
	}

	@RequestMapping("/getDepts")
	@ResponseBody
	public List<Dept> getDepts() {
		return deptService.getDepts();

	}

	public Dept getDept(int deptId) {
		return deptService.getDept(deptId);
	}

	@RequestMapping("/addDept")
	@Auth
	public String addDept(Dept dept, HttpServletRequest request) {
		deptService.addDept(dept);
		request.getSession().removeAttribute("depts");
		List<Dept> depts = deptService.getDepts();
		request.getSession().setAttribute("depts", depts);
		return "redirect:show";
	}

	@RequestMapping("/deleteDept")
	@ResponseBody
	public void deleteDeptById(int deptId, HttpServletRequest request) {
		deptService.deleteDeptById(deptId);
		request.getSession().removeAttribute("depts");
		List<Dept> depts = deptService.getDepts();
		request.getSession().setAttribute("depts", depts);
	}

	@RequestMapping("/updateDept")
	@ResponseBody
	public String updateDept(@RequestBody Dept dept, HttpServletRequest request) {
		deptService.updateDept(dept);
		request.getSession().removeAttribute("depts");
		List<Dept> depts = deptService.getDepts();
		request.getSession().setAttribute("depts", depts);
		return "success";
	}

	@RequestMapping("/checkId")
	@ResponseBody
	public String checkId(int id) {
		if (deptService.getDept(id) == null)
			return "success";
		else
			return "fail";
	}
}
