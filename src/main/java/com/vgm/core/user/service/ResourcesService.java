package com.vgm.core.user.service;

import com.vgm.common.TreeVO;
import com.vgm.core.user.entity.Resources;
import com.vgm.core.user.query.ResourcesDBParam;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Set;

public interface ResourcesService {


    public void createResource(Resources resources);
    public void updateResource(Resources resources);
    public void deleteResource(Long resourcesId);

    Resources findOne(Long resourcesId);
    List<Resources> findAll();

    /**
     * 得到资源对应的权限字符串
     * @param resourcesIds
     * @return
     */
    Set<String> findPermissions(Set<Long> resourcesIds);

    /**
     * 根据用户权限得到菜单
     * @param permissions
     * @return
     */
    List<Resources> findMenus(Set<String> permissions);

    /**
     * 得到所有资源对应的权限字符串
     * @return
     */
    Set<String> findAllPermissions();

    Page<Resources> findAll(Pageable pageable);

    List<TreeVO> treeMenus(Set<String> permissions);

    List<TreeVO> tree(ResourcesDBParam param);

    void available(Long id, boolean available);
}
