package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.entity.Dept;
import com.entity.Employees;
import com.entity.Job;

@Repository
public class EmployeeDAO {
	@Resource
	private SessionFactory sessionFactory;

	private Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	// 查找所有员工信息
	@SuppressWarnings("unchecked")
	public List<Employees> getEmployees() {
		return this.getSession().createQuery("from Employees").list();
	}

	// 根据ID查找员工信息
	public Employees getEmployeesByID(int id) {
		return (Employees) this.getSession().createQuery("from Employees where id = " + id).uniqueResult();
	}

	// 根据姓名模糊查询
	@SuppressWarnings("unchecked")
	public List<Employees> getEmployeesByName(String name) {
		return this.getSession().createQuery("from Employees where employeeName like :name ")
				.setParameter("name", "%" + name + "%").list();
	}

	// 根据邮件查询
	public Employees getEmployeesByEmail(String email) {
		return (Employees) this.getSession().createQuery("from Employees where email = ?").setParameter(0, email)
				.uniqueResult();
	}

	// 添加员工
	public void addEmployees(Employees employees) {
		this.getSession().save(employees);
	}

	// 编辑员工信息
	public void updateEmployees(Employees employees) {
		this.getSession().update(employees);
	}

	// 根据ID删除员工
	public void deleteEmployeesByID(String id) {
		this.getSession().createQuery("delete from Employees where id=" + id).executeUpdate();
	}

	public Job getJobById(int id) {
		return (Job) this.getSession().createQuery("from Job where jobId=?").setParameter(0, id).uniqueResult();
	}

	public Dept getDeptById(int id) {
		return (Dept) this.getSession().createQuery("from Dept d where d.deptId=?").setParameter(0, id).uniqueResult();
	}
}
