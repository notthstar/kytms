package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;
import java.sql.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author lcy
 * @since 2019-10-30
 */
@TableName("jc_order_back")
public class JcOrderBack implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "ID", type = IdType.AUTO)
    private String id;

    @TableField("CREATE_NAME")
    private String createName;

    @TableField("CREATE_TIME")
    private Date createTime;

    @TableField("DESCRIPTION")
    private String description;

    @TableField("FIELD1")
    private String field1;

    @TableField("FIELD2")
    private String field2;

    @TableField("FIELD3")
    private String field3;

    @TableField("MODIFY_NAME")
    private String modifyName;

    @TableField("MODIFY_TIME")
    private Date modifyTime;

    @TableField("NAME")
    private String name;

    @TableField("STATUS")
    private Integer status;

    @TableField("BACK_NUMBER")
    private Integer backNumber;

    @TableField("BACK_TIME")
    private Date backTime;

    @TableField("BACK_TYPE")
    private Integer backType;

    @TableField("EXPRESS_CODE")
    private String expressCode;

    @TableField("EXPRESS_NAME")
    private String expressName;

    @TableField("IS_RECEIVE")
    private Integer isReceive;

    @TableField("IS_SUBMIT")
    private Integer isSubmit;

    @TableField("SING_NUMBER")
    private Integer singNumber;

    @TableField("TIME")
    private Date time;

    @TableField("JC_ORDER_ID")
    private String jcOrderId;

    @TableField("JC_ORGANIZATION_ID")
    private String jcOrganizationId;

    @TableField("IS_UPLOAD")
    private Integer isUpload;

    public String getId() {
        return id;
    }

    public JcOrderBack setId(String id) {
        this.id = id;
        return this;
    }
    public String getCreateName() {
        return createName;
    }

    public JcOrderBack setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public JcOrderBack setDescription(String description) {
        this.description = description;
        return this;
    }
    public String getField1() {
        return field1;
    }

    public JcOrderBack setField1(String field1) {
        this.field1 = field1;
        return this;
    }
    public String getField2() {
        return field2;
    }

    public JcOrderBack setField2(String field2) {
        this.field2 = field2;
        return this;
    }
    public String getField3() {
        return field3;
    }

    public JcOrderBack setField3(String field3) {
        this.field3 = field3;
        return this;
    }
    public String getModifyName() {
        return modifyName;
    }

    public JcOrderBack setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public String getName() {
        return name;
    }

    public JcOrderBack setName(String name) {
        this.name = name;
        return this;
    }
    public Integer getStatus() {
        return status;
    }

    public JcOrderBack setStatus(Integer status) {
        this.status = status;
        return this;
    }
    public Integer getBackNumber() {
        return backNumber;
    }

    public JcOrderBack setBackNumber(Integer backNumber) {
        this.backNumber = backNumber;
        return this;
    }

    public Integer getBackType() {
        return backType;
    }

    public JcOrderBack setBackType(Integer backType) {
        this.backType = backType;
        return this;
    }
    public String getExpressCode() {
        return expressCode;
    }

    public JcOrderBack setExpressCode(String expressCode) {
        this.expressCode = expressCode;
        return this;
    }
    public String getExpressName() {
        return expressName;
    }

    public JcOrderBack setExpressName(String expressName) {
        this.expressName = expressName;
        return this;
    }
    public Integer getIsReceive() {
        return isReceive;
    }

    public JcOrderBack setIsReceive(Integer isReceive) {
        this.isReceive = isReceive;
        return this;
    }
    public Integer getIsSubmit() {
        return isSubmit;
    }

    public JcOrderBack setIsSubmit(Integer isSubmit) {
        this.isSubmit = isSubmit;
        return this;
    }
    public Integer getSingNumber() {
        return singNumber;
    }

    public JcOrderBack setSingNumber(Integer singNumber) {
        this.singNumber = singNumber;
        return this;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public Date getBackTime() {
        return backTime;
    }

    public void setBackTime(Date backTime) {
        this.backTime = backTime;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getJcOrderId() {
        return jcOrderId;
    }

    public JcOrderBack setJcOrderId(String jcOrderId) {
        this.jcOrderId = jcOrderId;
        return this;
    }
    public String getJcOrganizationId() {
        return jcOrganizationId;
    }

    public JcOrderBack setJcOrganizationId(String jcOrganizationId) {
        this.jcOrganizationId = jcOrganizationId;
        return this;
    }
    public Integer getIsUpload() {
        return isUpload;
    }

    public JcOrderBack setIsUpload(Integer isUpload) {
        this.isUpload = isUpload;
        return this;
    }

    @Override
    public String toString() {
        return "JcOrderBack{" +
            "id=" + id +
            ", createName=" + createName +
            ", createTime=" + createTime +
            ", description=" + description +
            ", field1=" + field1 +
            ", field2=" + field2 +
            ", field3=" + field3 +
            ", modifyName=" + modifyName +
            ", modifyTime=" + modifyTime +
            ", name=" + name +
            ", status=" + status +
            ", backNumber=" + backNumber +
            ", backTime=" + backTime +
            ", backType=" + backType +
            ", expressCode=" + expressCode +
            ", expressName=" + expressName +
            ", isReceive=" + isReceive +
            ", isSubmit=" + isSubmit +
            ", singNumber=" + singNumber +
            ", time=" + time +
            ", jcOrderId=" + jcOrderId +
            ", jcOrganizationId=" + jcOrganizationId +
            ", isUpload=" + isUpload +
        "}";
    }
}
