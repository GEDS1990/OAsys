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
	
	//��ȡ�û������ļ�
	public List<File> getFiles(int employeeId) {
		return fileDao.getFiles(employeeId);
	}
	
	//����ļ�
	public void addFile(File file) {
		fileDao.addFile(file);
	}
	
	//ɾ���ļ�
	public void deleteFileById(int fileId) {
		fileDao.deleteFileById(fileId);
	}
}
