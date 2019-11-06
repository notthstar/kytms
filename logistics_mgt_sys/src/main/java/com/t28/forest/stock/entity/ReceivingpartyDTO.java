/**
 * @description
 * @author HF
 * @create 2019/10/29
 * @since 1.0.0
 */
package com.t28.forest.stock.entity;

import java.util.Date;

public class ReceivingpartyDTO {
   private String id;
    private String createName;
    private Date createTime;
    private  String description;
    private  String field1;
    private String field2;
    private String field3;
    private String modifyName;
    private Date modifyTime;
    private String name;
    private Integer status;
    private String adderss;
    private String contactperson;
    private Date factArriveTime;
    private  Date factLeaveTime;
    private  String iphone;
    private  String ltl;
    private  Integer orderby;
    private  Date planLeaveTime;
    private  Date requireArriveTime;
    private  Integer type;
    private  String jcOrderId;
    private  String jcZonrId;
    private  String DetaileAddress;

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
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getAdderss() {
        return adderss;
    }

    public void setAdderss(String adderss) {
        this.adderss = adderss;
    }

    public String getContactperson() {
        return contactperson;
    }

    public void setContactperson(String contactperson) {
        this.contactperson = contactperson;
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

    public String getIphone() {
        return iphone;
    }

    public void setIphone(String iphone) {
        this.iphone = iphone;
    }

    public String getLtl() {
        return ltl;
    }

    public void setLtl(String ltl) {
        this.ltl = ltl;
    }

    public Integer getOrderby() {
        return orderby;
    }

    public void setOrderby(Integer orderby) {
        this.orderby = orderby;
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getJcOrderId() {
        return jcOrderId;
    }

    public void setJcOrderId(String jcOrderId) {
        this.jcOrderId = jcOrderId;
    }

    public String getJcZonrId() {
        return jcZonrId;
    }

    public void setJcZonrId(String jcZonrId) {
        this.jcZonrId = jcZonrId;
    }

    public String getDetaileAddress() {
        return DetaileAddress;
    }

    public void setDetaileAddress(String detaileAddress) {
        DetaileAddress = detaileAddress;
    }

    @Override
    public String toString() {
        return "ReceivingpartyDTO{" +
                "id='" + id + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", description='" + description + '\'' +
                ", field1='" + field1 + '\'' +
                ", field2='" + field2 + '\'' +
                ", field3='" + field3 + '\'' +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                ", name='" + name + '\'' +
                ", status=" + status +
                ", adderss='" + adderss + '\'' +
                ", contactperson='" + contactperson + '\'' +
                ", factArriveTime=" + factArriveTime +
                ", factLeaveTime=" + factLeaveTime +
                ", iphone='" + iphone + '\'' +
                ", ltl='" + ltl + '\'' +
                ", orderby=" + orderby +
                ", planLeaveTime=" + planLeaveTime +
                ", requireArriveTime=" + requireArriveTime +
                ", type=" + type +
                ", jcOrderId='" + jcOrderId + '\'' +
                ", jcZonrId='" + jcZonrId + '\'' +
                ", DetaileAddress='" + DetaileAddress + '\'' +
                '}';
    }
}
