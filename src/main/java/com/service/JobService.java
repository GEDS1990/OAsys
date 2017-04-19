package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.JobDAO;
import com.entity.Job;

@Service
@Transactional
public class JobService {

	@Autowired JobDAO jobDAO;
	
	//查看职位
	public List<Job> getJobs() {
		return jobDAO.getJobs();
	}
	
	//添加职位
	public void addJob(Job job) {
		jobDAO.addJob(job);
	}
	
	//删除部门
	public void deleteJobById(int JobId) {
		jobDAO.deleteJobById(JobId);
	}
	
	//更新职位
		public void updateJob(Job job) {
			jobDAO.updateJob(job);
		}
}
