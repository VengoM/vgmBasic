package com.vgm.core.user.service;


import com.vgm.common.TreeVO;
import com.vgm.common.util.BeanCopyUtils;
import com.vgm.core.user.entity.Resources;
import com.vgm.core.user.query.ResourcesDBParam;
import com.vgm.core.user.repository.ResourcesRepository;
import org.apache.commons.collections.IteratorUtils;
import org.apache.shiro.authz.permission.WildcardPermission;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.util.*;

@Service("resourcesService")
public class ResourcesServiceImpl implements ResourcesService {

	@Resource
    private ResourcesRepository resourcesRepository;

    @Override
    public void createResource(Resources resources) {
        resourcesRepository.save(resources);
    }

    @Override
    public void updateResource(Resources resource) {
        BeanCopyUtils.copyPropertiesIgnoreNull(resourcesRepository.getOne(resource.getId()), resource);
        resourcesRepository.save(resource);
    }

    @Override
    public void deleteResource(Long resourceId) {
    	Resources resources = new Resources();
    	resources.setId(resourceId);
        resourcesRepository.delete(resources);
    }

    @Override
    public Resources findOne(Long resourceId) {
        return resourcesRepository.getOne(resourceId);
    }

    @Override
    public List<Resources> findAll() {
        return IteratorUtils.toList(resourcesRepository.findAll().iterator());
    }

    public List<Resources> findAllMenus() {
        return resourcesRepository.findAllMenus();
    }

    @Override
    public Set<String> findPermissions(Set<Long> resourcesIds) {
        Set<String> permissions = new HashSet<String>();
        for(Long resourcesId : resourcesIds) {
            Resources resources = findOne(resourcesId);
            if(resources != null && !StringUtils.isEmpty(resources.getPermission())) {
                permissions.add(resources.getPermission());
            }
        }
        return permissions;
    }

    public Set<String> findAllPermissions() {
        return resourcesRepository.findAllPermissions();
    }

    @Override
    public List<Resources> findMenus(Set<String> permissions) {
        List<Resources> allResources = findAll();
        List<Resources> menus = new ArrayList<Resources>();
        for(Resources resources : allResources) {
            if(resources.isRootNode()) {
                continue;
            }
            if(resources.getType() != Resources.ResourceType.menu) {
                continue;
            }
            if(!hasPermission(permissions, resources)) {
                continue;
            }
            menus.add(resources);
        }
        return menus;
    }

    public List<Resources> findAvailableMenus(Set<String> permissions) {
        List<Resources> allResources = findAllMenus();
        List<Resources> menus = new ArrayList<Resources>();
        for(Resources resources : allResources) {
            if(resources.isRootNode()) {
                continue;
            }
            if(!resources.getAvailable()) {
                continue;
            }
            if(resources.getType() != Resources.ResourceType.menu) {
                continue;
            }
            if(!hasPermission(permissions, resources)) {
                continue;
            }
            menus.add(resources);
        }
        return menus;
    }

    /**
     * 生产TreeVO之后再去除无效资源
     * 2017-10-10 15:40:09
     * @param permissions
     * @return
     */
    public List<TreeVO> treeMenus(Set<String> permissions) {
        List<Resources> menus = findMenus(permissions);
        List<TreeVO> treeVOs = new ArrayList<>();
        for (Resources menu : menus ) {
            TreeVO treeVO = new TreeVO(
                    menu.getId().toString(),
                    menu.getName(),
                    menu,
                    menu.getParentId().toString(),
                    menu.getAvailable());
            treeVOs.add(treeVO);
        }
        List result = TreeVO.build(treeVOs);
        Iterator it = result.iterator();
        while (it.hasNext()) {
            TreeVO treeVO = (TreeVO) it.next();
            if (!treeVO.getAvailable()) {
                it.remove();
            }
        }
        return result;
    }

    private boolean hasPermission(Set<String> permissions, Resources resources) {
        if(StringUtils.isEmpty(resources.getPermission())) {
            return true;
        }
        for(String permission : permissions) {
            if(StringUtils.isEmpty(permission)) continue;
            WildcardPermission p1 = new WildcardPermission(permission);
            WildcardPermission p2 = new WildcardPermission(resources.getPermission());
            if(p1.implies(p2) || p2.implies(p1)) {
                return true;
            }
        }
        return false;
    }

    public Page<Resources> findAll(Pageable pageable) {
        return resourcesRepository.findAll(pageable);
    }

    public List<TreeVO> tree(ResourcesDBParam param) {
        List<Resources> list = resourcesRepository.query(param);
        List<TreeVO> treeVOs = new ArrayList<>();
        for (Resources res : list) {
            TreeVO treeVO = new TreeVO(
                    res.getId().toString(),
                    res.getName(),
                    res,
                    res.getParentId().toString());
            treeVOs.add(treeVO);
        }
        return TreeVO.build(treeVOs);
    }

    public void available(Long id,boolean available) {
        Resources res = resourcesRepository.getOne(id);
        res.setAvailable(available);
        resourcesRepository.save(res);
    }
}
