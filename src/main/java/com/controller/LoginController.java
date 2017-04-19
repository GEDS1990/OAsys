package com.controller;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.entity.Dept;
import com.entity.Employees;
import com.entity.Job;
import com.service.DeptService;
import com.service.EmpLoyeeService;

@Controller
@RequestMapping
public class LoginController {
	@Autowired
	private EmpLoyeeService eservice;
	@Autowired
	private DeptService deptService;

	@RequestMapping("/login")
	public String login() {
		return "login";
	}

	@RequestMapping("/submit")
	public ModelAndView submit(HttpServletRequest request) {
		Set<String> auths = new HashSet<String>(0);
		ModelAndView mv = new ModelAndView();
		mv.setViewName("login");
		mv.addObject("msg", "账号或密码错误");
		String email = request.getParameter("email");
		String pwd = request.getParameter("password");
		Employees user = eservice.getEmployeesByEmali(email);
		if (user != null && user.getPwd() != null)
			if (user.getPwd().equals(pwd)) {
				if (user.getUserLevel() == 1) {
					auths.add("most");
					auths.add("more");
					auths.add("least");
				} else if (user.getUserLevel() == 2) {
					auths.add("more");
					auths.add("least");
				} else if (user.getUserLevel() == 3)
					auths.add("least");
				request.getSession().setAttribute("kAUTHS", auths);
				request.getSession().removeAttribute("depts");
				request.getSession().removeAttribute("jobs");
				List<Dept> depts = deptService.getDepts();
				List<Job> jobs = deptService.getJobList();
				request.getSession().setAttribute("birthday", user.getBirthday());
				request.getSession().setAttribute("depts", depts);
				request.getSession().setAttribute("jobs", jobs);
				request.getSession().setAttribute("user", user);
				mv.addObject("user", user);
				mv.setViewName("personal");
				return mv;
			} else
				return mv;
		else
			return mv;
	}

	@RequestMapping("/out")
	public String out(HttpServletRequest request) {
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("birthday");
		request.getSession().removeAttribute("depts");
		request.getSession().removeAttribute("jobs");
		return "login";
	}

	@RequestMapping("/check")
	@ResponseBody
	public String check(String email) {
		if (eservice.getEmployeesByEmali(email) == null)
			return "success";
		else
			return "fail";
	}
}
