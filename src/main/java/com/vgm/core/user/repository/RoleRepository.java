package com.vgm.core.user.repository;

import com.vgm.core.user.entity.Role;
import org.ljdp.core.spring.jpa.DynamicJpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RoleRepository extends DynamicJpaRepository<Role,Long>, RoleRepositoryCustom {
    @Query("from Role")
    public List<Role> findAll();
}
