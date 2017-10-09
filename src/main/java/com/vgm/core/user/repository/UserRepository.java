package com.vgm.core.user.repository;

import com.vgm.core.user.entity.User;
import org.ljdp.core.spring.jpa.DynamicJpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface UserRepository extends DynamicJpaRepository<User,Long>, UserRepositoryCustom{

    @Query("from User where username = :username")
    public User findByUsername(@Param("username") String username);

    @Query("from User")
    public List<User> findAll();

}
