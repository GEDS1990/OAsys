package com.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Employees;
import com.entity.Task;
import com.service.EmpLoyeeService;
import com.service.TaskService;

import tools.Auth;

@Controller
@RequestMapping("/person")
public class PersonalController {
	@Autowired
	private EmpLoyeeService eService;
	@Autowired
	private TaskService tService;

	@RequestMapping("")
	@Auth("least")
	public String redirect() {
		return "personal";
	}

	@RequestMapping("/tasks")
	@ResponseBody
	public List<Task> getTasks(HttpServletRequest request) {
		Employees user = (Employees) request.getSession().getAttribute("user");
		int id = user.getEmployeeId();
		return tService.getTasks(id);
	}

	@RequestMapping("/deleteTask")
	@ResponseBody
	public void deleteTask(int taskId) {
		tService.deleteTaskById(taskId);
	}

	@RequestMapping("/updateTask")
	@ResponseBody
	public String updateTask(@RequestBody Task task, HttpServletRequest request) {
		Employees user = (Employees) request.getSession().getAttribute("user");
		task.setEmployees(user);
		tService.updateTask(task);
		return "success";
	}

	@RequestMapping("/addTask")
	@ResponseBody
	public String addTask(@RequestBody Task task, HttpServletRequest request) {
		Employees user = (Employees) request.getSession().getAttribute("user");
		task.setEmployees(user);
		task.setGetTime(new Date());
		task.setTaskState("未完成");
		tService.saveTask(task);
		return "success";
	}

	@RequestMapping("/updateUser")
	@Auth("least")
	public String updateUser(Employees employees, HttpServletRequest request) {
		eService.updateEmployees(employees);
		request.getSession().removeAttribute("user");
		request.getSession().removeAttribute("birthday");
		request.getSession().setAttribute("user", eService.getEmployeesByID(employees.getEmployeeId()));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String birthday = sdf.format(eService.getEmployeesByID(employees.getEmployeeId()).getBirthday());
		request.getSession().setAttribute("birthday", birthday);
		return "redirect:/person";
	}

	@RequestMapping("/updatepwd")
	@ResponseBody
	public String updatepwd(String npwd, HttpServletRequest request) {
		Employees user = (Employees) request.getSession().getAttribute("user");
		int id = user.getEmployeeId();
		Employees employees = eService.getEmployeesByID(id);
		employees.setPwd(npwd);
		user = eService.getEmployeesByID(id);
		request.getSession().setAttribute("user", user);
		return "success";
	}
}
