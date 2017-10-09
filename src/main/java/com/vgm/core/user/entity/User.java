package com.vgm.core.user.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name="sys_user")
public class User implements Serializable {
    
    private Long id; //编号
	private String organizationIds; //所属公司
    private String username; //用户名
    private String password; //密码
    private String salt; //加密密码的盐
    private String roleIds; //拥有的角色列表
    private Boolean locked = Boolean.FALSE;

    public User() {
    }

    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO) //mysql conf
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SEQ_SYS_USER")
    @SequenceGenerator(name="SEQ_SYS_USER",allocationSize=1,initialValue=1, sequenceName="SEQ_SYS_USER")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }
    
    public User(String username, String password) {
        this.username = username;
        this.password = password;
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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    @Transient
    public String getCredentialsSalt() {
        return username + salt;
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

        User user = (User) o;

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
                ", password='" + password + '\'' +
                ", salt='" + salt + '\'' +
                ", roleIds=" + roleIds +
                ", locked=" + locked +
                '}';
    }

    @Transient
    public List<Long> getRoleIdsList() {
    	List<Long> result = new ArrayList<Long>();
    	if(roleIds != null && !"".equals(roleIds) ) {
    		for(String roleId : roleIds.split(",")){
        		result.add(Long.parseLong(roleId));
        	}
    	}
		return result;
    }

    @Transient
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
