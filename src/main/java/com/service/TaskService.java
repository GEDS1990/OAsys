package com.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dao.TaskDAO;
import com.entity.Task;

@Service
@Transactional
public class TaskService {
	@Autowired
	private TaskDAO tDao;

	public List<Task> getTasks(int employeeId) {
		return tDao.getTasks(employeeId);
	}

	public void saveTask(Task task) {
		tDao.saveTask(task);
	}

	public void deleteTaskById(int id) {
		tDao.deleteTaskById(id);
	}

	public void updateTask(Task task) {
		tDao.updateTask(task);
	}
}
