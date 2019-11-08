/**
 * @description JC_ZONE_STOREROOM数据传输对象
 * @author HF
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.core.entity;

import java.util.Date;

public class JcZoneStoreroom {
    private String id;
    private String createName;
    private Date createTime;
    private String description;
    private String field1;
    private String field2;
    private String field3;
    private String modifyName;
    private Date modifyTime;
    private String Name;
    private Integer Status;
    private String jcOrganizationId;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCreateName() {
        return createName;
    }

    public void setCreateName(String createName) {
        this.createName = createName;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getField1() {
        return field1;
    }

    public void setField1(String field1) {
        this.field1 = field1;
    }

    public String getField2() {
        return field2;
    }

    public void setField2(String field2) {
        this.field2 = field2;
    }

    public String getField3() {
        return field3;
    }

    public void setField3(String field3) {
        this.field3 = field3;
    }

    public String getModifyName() {
        return modifyName;
    }

    public void setModifyName(String modifyName) {
        this.modifyName = modifyName;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getName() {
        return Name;
    }

    public void setName(String name) {
        Name = name;
    }

    public Integer getStatus() {
        return Status;
    }

    public void setStatus(Integer status) {
        Status = status;
    }

    public String getJcOrganizationId() {
        return jcOrganizationId;
    }

    public void setJcOrganizationId(String jcOrganizationId) {
        this.jcOrganizationId = jcOrganizationId;
    }

    @Override
    public String toString() {
        return "JcZoneStoreroom{" +
                "id='" + id + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", description='" + description + '\'' +
                ", field1='" + field1 + '\'' +
                ", field2='" + field2 + '\'' +
                ", field3='" + field3 + '\'' +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                ", Name='" + Name + '\'' +
                ", Status=" + Status +
                ", jcOrganizationId='" + jcOrganizationId + '\'' +
                '}';
    }
}
