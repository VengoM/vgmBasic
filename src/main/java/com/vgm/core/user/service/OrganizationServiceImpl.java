package com.vgm.core.user.service;

import com.vgm.common.TreeVO;
import com.vgm.core.user.entity.Organization;
import com.vgm.core.user.repository.OrganizationRepository;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service("organizationService")
public class OrganizationServiceImpl implements OrganizationService {
	@Resource
    private OrganizationRepository organizationRepository;

    @Override
    public void createOrganization(Organization organization) {
        organizationRepository.save(organization);
    }

    @Override
    public void updateOrganization(Organization organization) {
        organizationRepository.save(organization);
    }

    @Override
    public void deleteOrganization(Long organizationId) {
    	Organization organization = new Organization();
    	organization.setId(organizationId);
        organizationRepository.delete(organization);
    }

    @Override
    public Organization findOne(Long organizationId) {
        return organizationRepository.getOne(organizationId);
    }

    @Override
    public List<Organization> findAll() {
        return organizationRepository.findAll();
    }

    /*@Override
    public List<Organization> findAllWithExclude(Organization excludeOraganization) {
        return organizationDao.findAllWithExclude(excludeOraganization.getId());
    }*/

    /*public void move(Organization source, Organization target) {
        organizationDao.move(source, target);
    }*/

    public List<TreeVO> tree() {
        List<Organization> orgs = findAll();
        List<TreeVO> treeVOs = new ArrayList<>();
        for (Organization org : orgs ) {
            TreeVO treeVO = new TreeVO(
                    org.getId().toString(),
                    org.getName(),
                    org,
                    org.getParentId().toString());
            treeVOs.add(treeVO);
        }
        return TreeVO.build(treeVOs);
    }

    public void available(Long id, boolean available) {
        Organization org = organizationRepository.getOne(id);
        org.setAvailable(available);
        organizationRepository.save(org);
    }
}
