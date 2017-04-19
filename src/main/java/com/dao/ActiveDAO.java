package com.dao;

import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;
import org.springframework.stereotype.Repository;

import com.entity.Active;
import com.entity.Activeinfo;
import com.entity.Employees;

@Repository
public class ActiveDAO {
	
	@Resource private SessionFactory sessionFactory;
	
	public Session getSession() {
		return sessionFactory.getCurrentSession();
	}
	
	//添加活动
	public void addActive(Active  active) {
		this.getSession().save(active);
	}
	
	//查看活动信息
	@SuppressWarnings({ "deprecation", "unchecked" })
	public List<Active> getActives() {
		return this.getSession().createCriteria(Active.class).list();
	}
	
	//活动投票
	@SuppressWarnings({ "deprecation", "rawtypes" })
	public String updateActiveAgreeNum(int activeAgreeNum,int activeId,int employeeId) {
		if ((Activeinfo)this.getSession().createQuery("from Activeinfo a where a.active.activeId=? and a.employees.employeeId=?").setParameter(0, activeId).setParameter(1, employeeId).uniqueResult()==null) {
			String hql="update Active a set a.activeAgreeNum=? where a.activeId=?";
			Query query  = this.getSession().createQuery(hql); 
			query.setInteger(0,activeAgreeNum+1);
			query.setInteger(1,activeId);
			query.executeUpdate();
			Active active = new Active();
			active.setActiveId(activeId);
			Employees employees = new Employees();
			employees.setEmployeeId(employeeId);
			Activeinfo activeinfo = new Activeinfo();
			activeinfo.setEmployees(employees);
			activeinfo.setActive(active);
			this.getSession().save(activeinfo);
			return "success";
		} else {
			return "wrong";
		}
	}
	
	//删除活动
	public void deleteActiveByID(int activeId) {
		this.getSession().createQuery("delete Active a where a.activeId=?").setParameter(0, activeId).executeUpdate();
	}
}
