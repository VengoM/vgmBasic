package com.vgm.core.user.service;

import com.vgm.common.util.BeanCopyUtils;
import com.vgm.core.user.entity.User;
import com.vgm.core.user.query.UserDBParam;
import com.vgm.core.user.repository.UserRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Collections;
import java.util.List;
import java.util.Set;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Resource
    private UserRepository userRepository;
	@Resource
    private PasswordHelper passwordHelper;
	@Resource
    private RoleService roleService;

    /**
     * 创建用户
     * @param user
     */
    public void createUser(User user) {
        //加密密码
        passwordHelper.encryptPassword(user);
        userRepository.save(user);
    }

    public void updateUser(User user) {
        user.setPassword(null);
        User save = userRepository.getOne(user.getId());
        BeanCopyUtils.copyPropertiesIgnoreNull(save, user);
        userRepository.save(save);
    }

    public void deleteUser(Long userId) {
    	User user = new User();
    	user.setId(userId);
        userRepository.delete(user);
    }

    /**
     * 修改密码
     * @param userId
     * @param newPassword
     */
    public void changePassword(Long userId, String newPassword) {
        User user = userRepository.getOne(userId);
        user.setPassword(newPassword);
        passwordHelper.encryptPassword(user);
        userRepository.save(user);
    }

    /**
     * 锁定
     * @param userId
     */
    public void lock(Long userId) {
        User user = userRepository.getOne(userId);
        user.setLocked(true);
        userRepository.save(user);
    }

    /**
     * 解锁
     * @param userId
     */
    public void unlock(Long userId) {
        User user = userRepository.getOne(userId);
        user.setLocked(false);
        userRepository.save(user);
    }

    /**
     * 解锁
     * @param userId
     */
    public void resetPassword(Long userId) {
        this.changePassword(userId, "123456");
    }

    @Override
    public User findOne(Long userId) {
        return userRepository.getOne(userId);
    }

    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }

    /**
     * 根据用户名查找用户
     * @param username
     * @return
     */
    public User findByUsername(String username) {
        return userRepository.findByUsername(username);
    }

    /**
     * 根据用户名查找其角色
     * @param username
     * @return
     */
    public Set<String> findRoles(String username) {
        User user = findByUsername(username);
        if(user == null || user.getRoleIds() == null) {
            return Collections.EMPTY_SET;
        }
        return roleService.findRoles(user.getRoleIdsList().toArray(new Long[0]));
    }

    /**
     * 根据用户名查找其有效角色
     * @param username
     * @return
     */
    public Set<String> findAvailableRoles(String username) {
        User user = findByUsername(username);
        if(user == null || user.getRoleIds() == null) {
            return Collections.EMPTY_SET;
        }
        return roleService.findAvailableRoles(user.getRoleIdsList().toArray(new Long[0]));
    }

    /**
     * 根据用户名查找其权限
     * @param username
     * @return
     */
    public Set<String> findPermissions(String username) {
        User user =findByUsername(username);
        if(user == null) {
            return Collections.EMPTY_SET;
        }
        return roleService.findPermissions(user.getRoleIdsList().toArray(new Long[0]));
    }
    
	public Page<User> findAllUser(Pageable pageable) {
        return userRepository.findAll(pageable);
	}

    public Page<User> query(UserDBParam param, Pageable pageable) {
        return userRepository.query(param, pageable);
    }
}
