package com.vgm.core.user.entity;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


@Entity
@Table(name="sys_role")
public class Role implements Serializable {
    
	private Long id; //编号
	private String role; //角色标识 程序中判断使用,如"admin"
	private String description; //角色描述,UI界面显示使用
    private String resourceIds; //拥有的资源
    private Boolean available = Boolean.FALSE; //是否可用,如果不可用将不会添加给用户

    public Role() {
    }

    public Role(String role, String description, Boolean available) {
        this.role = role;
        this.description = description;
        this.available = available;
    }

    @Id
//    @GeneratedValue(strategy = GenerationType.AUTO)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator="SEQ_SYS_ROLE")
    @SequenceGenerator(name="SEQ_SYS_ROLE",allocationSize=1,initialValue=1, sequenceName="SEQ_SYS_ROLE")
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(name = "ROLE")
    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    @Column(name = "DESCRIPTION")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "RESOURCE_IDS")
    public String getResourceIds() {
    	if(resourceIds==null || resourceIds=="")
    	{
    		return "0";
    	}
        return resourceIds;
    }

    public void setResourceIds(String resourceIds) {
        this.resourceIds = resourceIds;
    }

    @Transient
    public List<Long> getResourceIdsList() {
    	List<Long> result = new ArrayList<Long>();
    	if(resourceIds!=null || resourceIds!=""){
    		for(String resourceId : resourceIds.split(",")){
        		result.add(Long.parseLong(resourceId));
        	}
    	}
        return result;
    }

//    public void setResourceIdsStr(String resourceIdsStr) {
//        if(StringUtils.isEmpty(resourceIdsStr)) {
//            return;
//        }
//        String[] resourceIdStrs = resourceIdsStr.split(",");
//        for(String resourceIdStr : resourceIdStrs) {
//            if(StringUtils.isEmpty(resourceIdStr)) {
//                continue;
//            }
//            getResourceIds().add(Long.valueOf(resourceIdStr));
//        }
//    }

    @Column(name = "AVAILABLE")
    public Boolean getAvailable() {
        return available;
    }

    public void setAvailable(Boolean available) {
        this.available = available;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Role role = (Role) o;

        if (id != null ? !id.equals(role.id) : role.id != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        return id != null ? id.hashCode() : 0;
    }

//    @Override
//    public String toString() {
//        return "Role{" +
//                "id=" + id +
//                ", role='" + role + '\'' +
//                ", description='" + description + '\'' +
//                ", resourceIds=" + resourceIds +
//                ", available=" + available +
//                '}';
//    }
}
