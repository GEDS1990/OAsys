package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.entity.Job;

@Repository
public class JobDAO {

	@Resource SessionFactory sessionFactory;
	
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	
	//查看职位
	@SuppressWarnings("unchecked")
	public List<Job> getJobs() {
		return this.getSession().createQuery("from Job").list();
	}
	
	//添加职位
	public void addJob(Job job) {
		this.getSession().save(job);
	}
	
	//删除职位
	public void deleteJobById(int JobId) {
		this.getSession().createQuery("delete Job where JobId=?").setParameter(0, JobId).executeUpdate();
	}
	
	//更新职位
	public void updateJob(Job job) {
		this.getSession().update(job);
	}
}
