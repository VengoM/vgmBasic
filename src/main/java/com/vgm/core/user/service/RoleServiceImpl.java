package com.vgm.core.user.service;

import com.vgm.common.util.BeanCopyUtils;
import com.vgm.core.user.entity.Role;
import com.vgm.core.user.query.RoleDBParam;
import com.vgm.core.user.repository.RoleRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashSet;
import java.util.List;
import java.util.Set;


@Service("roleService")
public class RoleServiceImpl implements RoleService {

	@Resource
    private RoleRepository roleRepository;
    @Resource
    private ResourcesService resourceService;

    public void createRole(Role role) {
        roleRepository.save(role);
    }

    public void updateRole(Role role) {
        BeanCopyUtils.copyPropertiesIgnoreNull(role, roleRepository.getOne(role.getId()));
        roleRepository.save(role);
    }

    public void deleteRole(Long roleId) {
    	Role role = new Role();
    	role.setId(roleId);
        roleRepository.delete(role);
    }

    @Override
    public Role findOne(Long roleId) {
        return roleRepository.getOne(roleId);
    }

    @Override
    public List<Role> findAll() {
        return roleRepository.findAll();
    }

    @Override
    public Set<String> findRoles(Long... roleIds) {
        Set<String> roles = new HashSet<String>();
        for(Long roleId : roleIds) {
            Role role = findOne(roleId);
            if(role != null) {
                roles.add(role.getRole());
            }
        }
        return roles;
    }

    public Set<String> findAvailableRoles(Long... roleIds) {
        Set<String> roles = new HashSet<String>();
        for(Long roleId : roleIds) {
            Role role = findOne(roleId);
            if(role != null&&role.getAvailable()) {
                roles.add(role.getRole());
            }
        }
        return roles;
    }

    public Set<String> findPermissions(Long[] roleIds) {
        Set<Long> resourceIds = new HashSet<Long>();
        for(Long roleId : roleIds) {
            Role role = findOne(roleId);
            if (role.getRole().equals("admin")) {
                return resourceService.findAllPermissions();
            }
            if(role != null&& role.getAvailable()) {
                resourceIds.addAll(role.getResourceIdsList());
            }
        }
        return resourceService.findPermissions(resourceIds);
    }

    public Page<Role> findAll(Pageable pageable) {
        return roleRepository.findAll(pageable);
    }

    public Page<Role> doQuery(RoleDBParam param, Pageable pageable) {
        return roleRepository.query(param, pageable);
    }

    public void available(Long id, boolean available) {
        Role role = roleRepository.getOne(id);
        role.setAvailable(available);
        roleRepository.save(role);
    }
}
