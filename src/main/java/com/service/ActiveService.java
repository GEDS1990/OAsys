package com.service;

import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dao.ActiveDAO;
import com.entity.Active;

@Service
@Transactional
public class ActiveService {
	
	@Autowired ActiveDAO activeDAO;
	
	//��ӻ
	public void addActive(Active  active) {
		activeDAO.addActive(active);
	}
	
	//�鿴���Ϣ
	public List<Active> getActives() {
		return activeDAO.getActives();
	}
	
	//�ͶƱ
	public String updateActiveAgreeNum(int activeAgreeNum,int activeId,int employeeId) {
		return activeDAO.updateActiveAgreeNum(activeAgreeNum, activeId, employeeId);
	}
	
	//ɾ���
	public void deleteActiveByID(int activeId) {
		activeDAO.deleteActiveByID(activeId);
	}
}
