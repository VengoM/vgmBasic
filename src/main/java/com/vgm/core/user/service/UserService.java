package com.vgm.core.user.service;

import com.vgm.core.user.entity.User;
import com.vgm.core.user.query.UserDBParam;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Set;

public interface UserService {

    /**
     * 创建用户
     * @param user
     */
    public void createUser(User user);

    public void updateUser(User user);

    public void deleteUser(Long userId);

    /**
     * 修改密码
     * @param userId
     * @param newPassword
     */
    public void changePassword(Long userId, String newPassword);

    /**
     * 锁定
     * @param userId
     */
    void lock(Long userId);

    /**
     * 解锁
     * @param userId
     */
    void unlock(Long userId);
    /**
     * 充值密码为123456
     * @param userId
     */
    void resetPassword(Long userId);

    User findOne(Long userId);

    List<User> findAll();

    /**
     * 根据用户名查找用户
     * @param username
     * @return
     */
    public User findByUsername(String username);

    /**
     * 根据用户名查找其角色
     * @param username
     * @return
     */
    public Set<String> findRoles(String username);

    /**
     * 根据用户名查找其权限
     * @param username
     * @return
     */
    public Set<String> findPermissions(String username);
    
    public Page<User> findAllUser(Pageable pageable);

    Page<User> query(UserDBParam param, Pageable pageable);

    /**
     * 根据用户名查找其有效角色
     * @param username
     * @return
     */
    Set<String> findAvailableRoles(String username);
}
