/**
 * @description
 * @author HF
 * @create 2019/10/29
 * @since 1.0.0
 */
package com.t28.forest.stock.entity;

import java.util.Date;

public class OrganizationDTO {
    private String id;
    private String code;
    private String createName;
    private Date createTime;
    private String description;
    private String field1;
    private String field2;
    private String field3;
    private String modifyname;
    private Date modifyTime;
    private String name;
    private Integer status;
    private String latitude;
    private String level;
    private Integer type;
    private String zid;
    private String address;
    private Integer isOverdueCarrier;
    private Integer isOverdueContract;
    private String principal;
    private Integer orderCode;
    private Integer dispatchCode;
    private Integer shipmentCode;
    private Integer cehiclPlanCode;
    private Integer prescoCode;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
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

    public String getModifyname() {
        return modifyname;
    }

    public void setModifyname(String modifyname) {
        this.modifyname = modifyname;
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

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getZid() {
        return zid;
    }

    public void setZid(String zid) {
        this.zid = zid;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getIsOverdueCarrier() {
        return isOverdueCarrier;
    }

    public void setIsOverdueCarrier(Integer isOverdueCarrier) {
        this.isOverdueCarrier = isOverdueCarrier;
    }

    public Integer getIsOverdueContract() {
        return isOverdueContract;
    }

    public void setIsOverdueContract(Integer isOverdueContract) {
        this.isOverdueContract = isOverdueContract;
    }

    public String getPrincipal() {
        return principal;
    }

    public void setPrincipal(String principal) {
        this.principal = principal;
    }

    public Integer getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(Integer orderCode) {
        this.orderCode = orderCode;
    }

    public Integer getDispatchCode() {
        return dispatchCode;
    }

    public void setDispatchCode(Integer dispatchCode) {
        this.dispatchCode = dispatchCode;
    }

    public Integer getShipmentCode() {
        return shipmentCode;
    }

    public void setShipmentCode(Integer shipmentCode) {
        this.shipmentCode = shipmentCode;
    }

    public Integer getCehiclPlanCode() {
        return cehiclPlanCode;
    }

    public void setCehiclPlanCode(Integer cehiclPlanCode) {
        this.cehiclPlanCode = cehiclPlanCode;
    }

    public Integer getPrescoCode() {
        return prescoCode;
    }

    public void setPrescoCode(Integer prescoCode) {
        this.prescoCode = prescoCode;
    }

    @Override
    public String toString() {
        return "OrganizationDTO{" +
                "id='" + id + '\'' +
                ", code='" + code + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", description='" + description + '\'' +
                ", field1='" + field1 + '\'' +
                ", field2='" + field2 + '\'' +
                ", field3='" + field3 + '\'' +
                ", modifyname='" + modifyname + '\'' +
                ", modifyTime=" + modifyTime +
                ", name='" + name + '\'' +
                ", status=" + status +
                ", latitude='" + latitude + '\'' +
                ", level='" + level + '\'' +
                ", type=" + type +
                ", zid='" + zid + '\'' +
                ", address='" + address + '\'' +
                ", isOverdueCarrier=" + isOverdueCarrier +
                ", isOverdueContract=" + isOverdueContract +
                ", principal='" + principal + '\'' +
                ", orderCode=" + orderCode +
                ", dispatchCode=" + dispatchCode +
                ", shipmentCode=" + shipmentCode +
                ", cehiclPlanCode=" + cehiclPlanCode +
                ", prescoCode=" + prescoCode +
                '}';
    }
}
