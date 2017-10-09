package com.vgm.core.user.VO;

import com.vgm.core.user.entity.User;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class UserVO implements Serializable {

    private Long id; //编号
	private String organizationIds; //所属公司
    private String username; //用户名
    private String roleIds; //拥有的角色列表
    private Boolean locked = Boolean.FALSE;

    public UserVO() {

    }

    public UserVO(User user) {
        if (user != null) {
            id = user.getId();
            organizationIds = user.getOrganizationIds();
            username = user.getUsername();
            roleIds = user.getRoleIds();
            locked = user.getLocked();
        }
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getOrganizationIds() {
        return organizationIds;
    }

    public void setOrganizationIds(String organizationIds) {
        this.organizationIds = organizationIds;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getRoleIds() {
        return roleIds;
    }

    public void setRoleIds(String roleIds) {
        this.roleIds = roleIds;
    }
 
    public Boolean getLocked() {
        return locked;
    }

    public void setLocked(Boolean locked) {
        this.locked = locked;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        UserVO user = (UserVO) o;

        if (id != null ? !id.equals(user.id) : user.id != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return id != null ? id.hashCode() : 0;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", organizationIds=" + organizationIds +
                ", username='" + username + '\'' +
                ", roleIds=" + roleIds +
                ", locked=" + locked +
                '}';
    }

    public List<Long> getRoleIdsList() {
    	List<Long> result = new ArrayList<Long>();
        if(roleIds != null && !"".equals(roleIds) ) {
            for(String roleId : roleIds.split(",")){
                result.add(Long.parseLong(roleId));
            }
        }
		return result;
    }

    public List<Long> getOrganizationIdsList() {
        List<Long> result = new ArrayList<Long>();
        if(organizationIds != null && !"".equals(organizationIds) ) {
            for(String organizationId : organizationIds.split(",")){
                result.add(Long.parseLong(organizationIds));
            }
        }
        return result;
    }
}
