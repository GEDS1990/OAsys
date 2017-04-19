package com.dao;

import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;

import com.entity.Dept;
import com.entity.File;

@Repository
public class FileDao {
	
	@Resource SessionFactory sessionFactory;
	
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	
	//获取用户所有文件
	@SuppressWarnings("unchecked")
	public List<File> getFiles(int employeeId) {
		return this.getSession().createQuery("from File f where f.employeesByFileTo.employeeId=?").setParameter(0, employeeId).getResultList();
	}
	
	//添加文件
	public void addFile(File file) {
		this.getSession().save(file);
	}
	
	//删除文件
	public void deleteFileById(int fileId) {
		this.getSession().createQuery("delete File where fileId=?").setParameter(0, fileId).executeUpdate();
	}
}
