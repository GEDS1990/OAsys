package com.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.FileDao;
import com.entity.File;

@Service
@Transactional
public class FileService {
	
	@Autowired FileDao fileDao;
	
	//获取用户所有文件
	public List<File> getFiles(int employeeId) {
		return fileDao.getFiles(employeeId);
	}
	
	//添加文件
	public void addFile(File file) {
		fileDao.addFile(file);
	}
	
	//删除文件
	public void deleteFileById(int fileId) {
		fileDao.deleteFileById(fileId);
	}
}
