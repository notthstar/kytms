package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.sql.Date;
import com.baomidou.mybatisplus.annotation.TableField;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author lcy
 * @since 2019-10-30
 */
@TableName("jc_receivingparty")
public class JcReceivingparty implements Serializable {

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

    @TableField("ADDRESS")
    private String address;

    @TableField("CONTACTPERSON")
    private String contactperson;

    @TableField("FACT_ARRIVE_TIME")
    private Date factArriveTime;

    @TableField("FACT_LEAVE_TIME")
    private Date factLeaveTime;

    @TableField("IPHONE")
    private String iphone;

    @TableField("LTL")
    private String ltl;

    @TableField("ORDERBY")
    private Integer orderby;

    @TableField("PLAN_LEAVE_TIME")
    private Date planLeaveTime;

    @TableField("REQUIRE_ARRIVE_TIME")
    private Date requireArriveTime;

    @TableField("JC_ORGANIZATION_ID")
    private String jcOrganizationId;

    @TableField("JC_ZONE_ID")
    private String jcZoneId;

    @TableField("DETAILE_ADDRESS")
    private String detaileAddress;

    public String getId() {
        return id;
    }

    public JcReceivingparty setId(String id) {
        this.id = id;
        return this;
    }
    public String getCreateName() {
        return createName;
    }

    public JcReceivingparty setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public JcReceivingparty setDescription(String description) {
        this.description = description;
        return this;
    }
    public String getField1() {
        return field1;
    }

    public JcReceivingparty setField1(String field1) {
        this.field1 = field1;
        return this;
    }
    public String getField2() {
        return field2;
    }

    public JcReceivingparty setField2(String field2) {
        this.field2 = field2;
        return this;
    }
    public String getField3() {
        return field3;
    }

    public JcReceivingparty setField3(String field3) {
        this.field3 = field3;
        return this;
    }
    public String getModifyName() {
        return modifyName;
    }

    public JcReceivingparty setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public String getName() {
        return name;
    }

    public JcReceivingparty setName(String name) {
        this.name = name;
        return this;
    }
    public Integer getStatus() {
        return status;
    }

    public JcReceivingparty setStatus(Integer status) {
        this.status = status;
        return this;
    }
    public String getAddress() {
        return address;
    }

    public JcReceivingparty setAddress(String address) {
        this.address = address;
        return this;
    }
    public String getContactperson() {
        return contactperson;
    }

    public JcReceivingparty setContactperson(String contactperson) {
        this.contactperson = contactperson;
        return this;
    }

    public String getIphone() {
        return iphone;
    }

    public JcReceivingparty setIphone(String iphone) {
        this.iphone = iphone;
        return this;
    }
    public String getLtl() {
        return ltl;
    }

    public JcReceivingparty setLtl(String ltl) {
        this.ltl = ltl;
        return this;
    }
    public Integer getOrderby() {
        return orderby;
    }

    public JcReceivingparty setOrderby(Integer orderby) {
        this.orderby = orderby;
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

    public Date getFactArriveTime() {
        return factArriveTime;
    }

    public void setFactArriveTime(Date factArriveTime) {
        this.factArriveTime = factArriveTime;
    }

    public Date getFactLeaveTime() {
        return factLeaveTime;
    }

    public void setFactLeaveTime(Date factLeaveTime) {
        this.factLeaveTime = factLeaveTime;
    }

    public Date getPlanLeaveTime() {
        return planLeaveTime;
    }

    public void setPlanLeaveTime(Date planLeaveTime) {
        this.planLeaveTime = planLeaveTime;
    }

    public Date getRequireArriveTime() {
        return requireArriveTime;
    }

    public void setRequireArriveTime(Date requireArriveTime) {
        this.requireArriveTime = requireArriveTime;
    }

    public String getJcOrganizationId() {
        return jcOrganizationId;
    }

    public JcReceivingparty setJcOrganizationId(String jcOrganizationId) {
        this.jcOrganizationId = jcOrganizationId;
        return this;
    }
    public String getJcZoneId() {
        return jcZoneId;
    }

    public JcReceivingparty setJcZoneId(String jcZoneId) {
        this.jcZoneId = jcZoneId;
        return this;
    }
    public String getDetaileAddress() {
        return detaileAddress;
    }

    public JcReceivingparty setDetaileAddress(String detaileAddress) {
        this.detaileAddress = detaileAddress;
        return this;
    }

    @Override
    public String toString() {
        return "JcReceivingparty{" +
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
            ", address=" + address +
            ", contactperson=" + contactperson +
            ", factArriveTime=" + factArriveTime +
            ", factLeaveTime=" + factLeaveTime +
            ", iphone=" + iphone +
            ", ltl=" + ltl +
            ", orderby=" + orderby +
            ", planLeaveTime=" + planLeaveTime +
            ", requireArriveTime=" + requireArriveTime +
            ", jcOrganizationId=" + jcOrganizationId +
            ", jcZoneId=" + jcZoneId +
            ", detaileAddress=" + detaileAddress +
        "}";
    }
}
