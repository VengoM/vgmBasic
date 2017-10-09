package com.vgm.core.user.repository;

import com.vgm.core.user.entity.Resources;
import org.ljdp.core.spring.jpa.DynamicJpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Set;

public interface ResourcesRepository extends DynamicJpaRepository<Resources,Long>, ResourcesRepositoryCustom {

    @Query(value="select distinct T.permission from Resources T ")
    public Set<String> findAllPermissions();

    @Query(value="from Resources T WHERE T.type = 'menu'")
    public List<Resources> findAllMenus();
}
