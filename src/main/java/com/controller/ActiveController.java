package com.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Active;
import com.entity.Employees;
import com.service.ActiveService;

import tools.Auth;

@Controller
@RequestMapping("/Active")
public class ActiveController {

	@Autowired
	ActiveService activeService;

	@RequestMapping("/addActive")
	@Auth(value = "most")
	public String addActive(Active active) {
		activeService.addActive(active);
		return "redirect:show";
	}

	@RequestMapping("/vote")
	@Auth("least")
	public String redirect() {
		return "activeVote";
	}

	@RequestMapping("/show")
	@Auth("least")
	public String showActive() {
		return "active";
	}

	@RequestMapping("/getActives")
	@ResponseBody
	public List<Active> getActives() {
		return activeService.getActives();
	}

	@RequestMapping("/activeVote")
	@ResponseBody
	public String updateActiveAgreeNum(int activeAgreeNum, int activeId, HttpServletRequest request) {
		Employees user = (Employees) request.getSession().getAttribute("user");
		return activeService.updateActiveAgreeNum(activeAgreeNum, activeId, user.getEmployeeId());
	}

	@RequestMapping("/deleteActive")
	@ResponseBody
	public void deleteActiveByID(int activeId) {
		activeService.deleteActiveByID(activeId);
	}
}
