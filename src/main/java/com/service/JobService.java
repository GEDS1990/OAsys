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
	
	//�鿴ְλ
	public List<Job> getJobs() {
		return jobDAO.getJobs();
	}
	
	//���ְλ
	public void addJob(Job job) {
		jobDAO.addJob(job);
	}
	
	//ɾ������
	public void deleteJobById(int JobId) {
		jobDAO.deleteJobById(JobId);
	}
	
	//����ְλ
		public void updateJob(Job job) {
			jobDAO.updateJob(job);
		}
}
