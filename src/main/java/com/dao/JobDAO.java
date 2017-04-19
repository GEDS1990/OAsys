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
	
	//�鿴ְλ
	@SuppressWarnings("unchecked")
	public List<Job> getJobs() {
		return this.getSession().createQuery("from Job").list();
	}
	
	//���ְλ
	public void addJob(Job job) {
		this.getSession().save(job);
	}
	
	//ɾ��ְλ
	public void deleteJobById(int JobId) {
		this.getSession().createQuery("delete Job where JobId=?").setParameter(0, JobId).executeUpdate();
	}
	
	//����ְλ
	public void updateJob(Job job) {
		this.getSession().update(job);
	}
}
