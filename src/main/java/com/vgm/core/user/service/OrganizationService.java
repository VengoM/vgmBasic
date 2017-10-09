package com.vgm.core.user.service;

import com.vgm.common.TreeVO;
import com.vgm.core.user.entity.Organization;

import java.util.List;


public interface OrganizationService {


    public void createOrganization(Organization organization);
    public void updateOrganization(Organization organization);
    public void deleteOrganization(Long organizationId);

    Organization findOne(Long organizationId);
    List<Organization> findAll();

/*
    Object findAllWithExclude(Organization excludeOraganization);
*/

    /*void move(Organization source, Organization target);*/

    List<TreeVO> tree();

    void available(Long id, boolean available);
}
