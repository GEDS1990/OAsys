package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.entity.Task;

@Repository
public class TaskDAO {
	@Resource
	private SessionFactory sessionFactory;

	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}

	public List<Task> getTasks(int employeeId) {
		return this.getSession().createQuery("from Task t where t.employees.employeeId=?").setParameter(0, employeeId)
				.getResultList();
	}

	public void saveTask(Task task) {
		this.getSession().save(task);
	}

	public void deleteTaskById(int id) {
		this.getSession().createQuery("delete Task where taskId = ?").setParameter(0, id).executeUpdate();
	}

	public void updateTask(Task task) {
		this.getSession().update(task);
	}
}
