package org.ljdp.core.spring.jpa;

import org.ljdp.core.db.RoDBQueryParam;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.support.JpaEntityInformation;
import org.springframework.data.jpa.repository.support.SimpleJpaRepository;

import javax.persistence.EntityManager;
import java.io.Serializable;
import java.util.List;

public class DynamicJpaRepositoryImpl<T, ID extends Serializable> 
			extends SimpleJpaRepository<T, ID>
			implements DynamicJpaRepository<T, ID>{

	//private final Class<T> domainClass;
	protected JpaDynamicQueryDAO<T> dynamicDao;

	public DynamicJpaRepositoryImpl(JpaEntityInformation<T, ?> entityInformation, EntityManager entityManager) {
		super(entityInformation, entityManager);
	}

	public DynamicJpaRepositoryImpl(JpaEntityInformation<T, ?> entityInformation, EntityManager entityManager, Class<T> domainClass) {
		super(entityInformation, entityManager);
		dynamicDao = new JpaDynamicQueryDAO<T>(entityManager, domainClass);
	}

	public DynamicJpaRepositoryImpl(Class<T> domainClass, EntityManager em) {
		super(domainClass, em);
		dynamicDao = new JpaDynamicQueryDAO<T>(em, domainClass);
	}

	public String test(String str){
		return "DynamicJpaRepositoryImpl："+str;
	}

	public Page<T> query(RoDBQueryParam params, Pageable pageable) {
		return dynamicDao.query(params, pageable);
	}

	public List<T> queryDataOnly(RoDBQueryParam params, Pageable pageable) {
		return dynamicDao.queryDataOnly(params, pageable);
	}

	public List<T> query(RoDBQueryParam params) {
		return dynamicDao.query(params);
	}

	public List<T> query(RoDBQueryParam params, Sort sort) {
		return dynamicDao.query(params, sort);
	}

	public int count(RoDBQueryParam params) {
		return dynamicDao.count(params);
	}

	public JpaDynamicQueryDAO<T> getDynamicDao() {
		return dynamicDao;
	}
}
