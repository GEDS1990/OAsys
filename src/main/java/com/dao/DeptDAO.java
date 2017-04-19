package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.entity.Dept;
import com.entity.Job;

@Repository
public class DeptDAO {

	@Resource
	SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	@SuppressWarnings("unchecked")
	public List<Dept> getDepts() {
		return this.getSession().createQuery("from Dept").list();

	}

	public Dept getDept(int deptId) {
		return (Dept) this.getSession().createQuery("from Dept d where d.deptId=?").setParameter(0, deptId)
				.uniqueResult();
	}

	public void addDept(Dept dept) {
		this.getSession().save(dept);
	}

	public void deleteDeptById(int deptId) {
		this.getSession().createQuery("delete Dept where deptId=?").setParameter(0, deptId).executeUpdate();
	}

	public void updateDept(Dept dept) {
		this.getSession().update(dept);
	}

	@SuppressWarnings("unchecked")
	public List<Job> getJobList() {
		return this.getSession().createQuery("from Job").list();
	}
}
