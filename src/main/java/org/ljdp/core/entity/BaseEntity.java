package org.ljdp.core.entity;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.persistence.Version;

@MappedSuperclass
public abstract class BaseEntity<ID extends Serializable> implements Serializable {

	private static final long serialVersionUID = 2035013017939483936L;

	private ID id;
	// 创建日期
	protected Date createDate;
	// 更新日期
	protected Date modifyDate;
	// 创建人
	protected Long createUserId;
	// 更新人
	protected Long modifyUserId;
	// 版本号
	protected Integer version;
	// 是否删除
	protected String deleted = "N";

	
	@Id 
	@GeneratedValue
	@Column(name="ID")
	public ID getId() {
		return id;
	}
	

	public void setId(ID id) {
		this.id = id;
	}
	
	/**
	 * @return the createDate
	 */
	@Column(name = "CREATE_DATE")
	public Date getCreateDate() {
		return createDate;
	}

	/**
	 * @param createDate
	 *            the createDate to set
	 */
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	/**
	 * @return the modifyDate
	 */
	@Column(name = "MODIFY_DATE")
	public Date getModifyDate() {
		return modifyDate;
	}

	/**
	 * @param modifyDate
	 *            the modifyDate to set
	 */
	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	/**
	 * @return the createUserId
	 */
	@Column(name = "CREATE_USER_ID")
	public Long getCreateUserId() {
		return createUserId;
	}

	/**
	 * @param createUserId
	 *            the createUserId to set
	 */
	public void setCreateUserId(Long createUserId) {
		this.createUserId = createUserId;
	}

	/**
	 * @return the modifyUserId
	 */
	@Column(name = "MODIFY_USER_ID")
	public Long getModifyUserId() {
		return modifyUserId;
	}

	/**
	 * @param modifyUserId
	 *            the modifyUserId to set
	 */
	public void setModifyUserId(Long modifyUserId) {
		this.modifyUserId = modifyUserId;
	}

	/**
	 * @return the version
	 */
	@Version
	@Column(name = "VERSION")
	public Integer getVersion() {
		return version;
	}

	/**
	 * @param version
	 *            the version to set
	 */
	public void setVersion(Integer version) {
		this.version = version;
	}

	/**
	 * @return the deleted
	 */
	@Column(name = "DELETED")
	public String getDeleted() {
		return deleted;
	}

	/**
	 * @param deleted
	 *            the deleted to set
	 */
	public void setDeleted(String deleted) {
		this.deleted = deleted;
	}
	
}
