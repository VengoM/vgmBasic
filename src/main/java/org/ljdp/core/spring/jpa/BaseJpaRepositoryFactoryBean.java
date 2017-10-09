package org.ljdp.core.spring.jpa;

import java.io.Serializable;

import javax.persistence.EntityManager;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.support.JpaRepositoryFactory;
import org.springframework.data.jpa.repository.support.JpaRepositoryFactoryBean;
import org.springframework.data.repository.core.RepositoryInformation;
import org.springframework.data.repository.core.RepositoryMetadata;
import org.springframework.data.repository.core.support.RepositoryFactorySupport;

public class BaseJpaRepositoryFactoryBean<R extends JpaRepository<T, I>, T, I extends Serializable>
		extends JpaRepositoryFactoryBean<R, T, I>  {

	public BaseJpaRepositoryFactoryBean(Class<? extends R> repositoryInterface) {
		super(repositoryInterface);
	}

	protected RepositoryFactorySupport createRepositoryFactory(
			EntityManager entityManager) {

		return new BaseJpaRepositoryFactory(entityManager);
	}

	private static class BaseJpaRepositoryFactory<T, I extends Serializable> extends
			JpaRepositoryFactory {

		private EntityManager entityManager;

		public BaseJpaRepositoryFactory(EntityManager entityManager) {
			super(entityManager);

			this.entityManager = entityManager;
		}

		protected Object getTargetRepository(RepositoryInformation information) {
			//获取继承的接口
			Class[] ifs = information.getRepositoryInterface().getInterfaces();
			for (int i = 0; i < ifs.length; i++) {
				//如果存在自定义的接口，返回自定义的实现
				if(ifs[i].equals(DynamicJpaRepository.class)) {
					return new DynamicJpaRepositoryImpl<T, I>(
							(Class<T>) information.getDomainType(), entityManager);
				}
			}
			;
			return super.getTargetRepository(information);
		}

		protected Class<?> getRepositoryBaseClass(RepositoryMetadata metadata) {
			// The RepositoryMetadata can be safely ignored, it is used by the
			// JpaRepositoryFactory
			// to check for QueryDslJpaRepository's which is out of scope.

			//获取继承的接口
			Class[] ifs = metadata.getRepositoryInterface().getInterfaces();
			for (int i = 0; i < ifs.length; i++) {
				//如果存在自定义的接口，返回自定义的接口
				if(ifs[i].equals(DynamicJpaRepository.class)) {
					return DynamicJpaRepository.class;
				}
			}

			return super.getRepositoryBaseClass(metadata);
		}
	}
}
