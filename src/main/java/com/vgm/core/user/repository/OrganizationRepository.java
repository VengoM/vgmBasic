package com.vgm.core.user.repository;

import com.vgm.core.user.entity.Organization;
import org.ljdp.core.spring.jpa.DynamicJpaRepository;

public interface OrganizationRepository extends DynamicJpaRepository<Organization,Long>, OrganizationRepositoryCustom {

}
