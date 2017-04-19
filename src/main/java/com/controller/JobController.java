package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.entity.Dept;
import com.entity.Job;
import com.service.DeptService;
import com.service.JobService;

import tools.Auth;

@Controller
@RequestMapping("/job")
public class JobController {

	@Autowired
	JobService jobService;
	@Autowired
	DeptService dService;

	@RequestMapping("/show")
	@Auth("most")
	public String redirect(Model model) {
		return "dept";
	}

	@RequestMapping("/getJobs")
	@ResponseBody
	public List<Job> getJobs() {
		return jobService.getJobs();
	}

	@RequestMapping("/add")
	@Auth("most")
	public String addJob(Job job) {
		jobService.addJob(job);
		return "redirect:show";
	}

	@RequestMapping("/delete")
	@ResponseBody
	public void deleteJobById(int jobId) {
		jobService.deleteJobById(jobId);
	}

	@RequestMapping("/update")
	@ResponseBody
	public String updateJob(@RequestBody Job job, int deptId) {

		Dept dept = new Dept();
		dept.setDeptId(deptId);
		job.setDept(dept);
		jobService.updateJob(job);
		return "success";
	}
}
