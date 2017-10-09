package com.vgm.core.user.service;

import com.vgm.core.user.entity.Role;
import com.vgm.core.user.query.RoleDBParam;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Set;

public interface RoleService {


    public void createRole(Role role);
    public void updateRole(Role role);
    public void deleteRole(Long roleId);

    public Role findOne(Long roleId);
    public List<Role> findAll();

    /**
     * 根据角色编号得到角色标识符列表
     * @param roleIds
     * @return
     */
    Set<String> findRoles(Long... roleIds);

    /**
     * 根据角色编号得到权限字符串列表
     * @param roleIds
     * @return
     */
    Set<String> findPermissions(Long[] roleIds);

    Page<Role> findAll(Pageable pageable);

    Page<Role> doQuery(RoleDBParam param, Pageable pageable);

    void available(Long id, boolean available);

    /**
     * 获取有效角色标识
     * @param roleIds
     * @return
     */
    Set<String> findAvailableRoles(Long... roleIds);
}
