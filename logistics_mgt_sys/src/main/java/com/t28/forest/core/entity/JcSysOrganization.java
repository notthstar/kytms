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
@TableName("jc_sys_organization")
public class JcSysOrganization implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "ID", type = IdType.AUTO)
    private String id;

    @TableField("CODE")
    private String code;

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

    @TableField("LATITUDE")
    private String latitude;

    @TableField("LEVEL")
    private String level;

    @TableField("TYPE")
    private Integer type;

    @TableField("ZID")
    private String zid;

    @TableField("ADDRESS")
    private String address;

    @TableField("IS_OVERDUE_CARRIER")
    private Integer isOverdueCarrier;

    @TableField("IS_OVERDUE_CONTRACT")
    private Integer isOverdueContract;

    @TableField("PRINCIPAL")
    private String principal;

    @TableField("ORDER_CODE")
    private Integer orderCode;

    @TableField("DISPATCH_CODE")
    private Integer dispatchCode;

    @TableField("SHIPMENT_CODE")
    private Integer shipmentCode;

    @TableField("VEHICLE_PLAN_CODE")
    private Integer vehiclePlanCode;

    @TableField("PRESCO_CODE")
    private Integer prescoCode;

    public String getId() {
        return id;
    }

    public JcSysOrganization setId(String id) {
        this.id = id;
        return this;
    }
    public String getCode() {
        return code;
    }

    public JcSysOrganization setCode(String code) {
        this.code = code;
        return this;
    }
    public String getCreateName() {
        return createName;
    }

    public JcSysOrganization setCreateName(String createName) {
        this.createName = createName;
        return this;
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

    public JcSysOrganization setDescription(String description) {
        this.description = description;
        return this;
    }
    public String getField1() {
        return field1;
    }

    public JcSysOrganization setField1(String field1) {
        this.field1 = field1;
        return this;
    }
    public String getField2() {
        return field2;
    }

    public JcSysOrganization setField2(String field2) {
        this.field2 = field2;
        return this;
    }
    public String getField3() {
        return field3;
    }

    public JcSysOrganization setField3(String field3) {
        this.field3 = field3;
        return this;
    }
    public String getModifyName() {
        return modifyName;
    }

    public JcSysOrganization setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
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

    public JcSysOrganization setName(String name) {
        this.name = name;
        return this;
    }
    public Integer getStatus() {
        return status;
    }

    public JcSysOrganization setStatus(Integer status) {
        this.status = status;
        return this;
    }
    public String getLatitude() {
        return latitude;
    }

    public JcSysOrganization setLatitude(String latitude) {
        this.latitude = latitude;
        return this;
    }
    public String getLevel() {
        return level;
    }

    public JcSysOrganization setLevel(String level) {
        this.level = level;
        return this;
    }
    public Integer getType() {
        return type;
    }

    public JcSysOrganization setType(Integer type) {
        this.type = type;
        return this;
    }
    public String getZid() {
        return zid;
    }

    public JcSysOrganization setZid(String zid) {
        this.zid = zid;
        return this;
    }
    public String getAddress() {
        return address;
    }

    public JcSysOrganization setAddress(String address) {
        this.address = address;
        return this;
    }
    public Integer getIsOverdueCarrier() {
        return isOverdueCarrier;
    }

    public JcSysOrganization setIsOverdueCarrier(Integer isOverdueCarrier) {
        this.isOverdueCarrier = isOverdueCarrier;
        return this;
    }
    public Integer getIsOverdueContract() {
        return isOverdueContract;
    }

    public JcSysOrganization setIsOverdueContract(Integer isOverdueContract) {
        this.isOverdueContract = isOverdueContract;
        return this;
    }
    public String getPrincipal() {
        return principal;
    }

    public JcSysOrganization setPrincipal(String principal) {
        this.principal = principal;
        return this;
    }
    public Integer getOrderCode() {
        return orderCode;
    }

    public JcSysOrganization setOrderCode(Integer orderCode) {
        this.orderCode = orderCode;
        return this;
    }
    public Integer getDispatchCode() {
        return dispatchCode;
    }

    public JcSysOrganization setDispatchCode(Integer dispatchCode) {
        this.dispatchCode = dispatchCode;
        return this;
    }
    public Integer getShipmentCode() {
        return shipmentCode;
    }

    public JcSysOrganization setShipmentCode(Integer shipmentCode) {
        this.shipmentCode = shipmentCode;
        return this;
    }
    public Integer getVehiclePlanCode() {
        return vehiclePlanCode;
    }

    public JcSysOrganization setVehiclePlanCode(Integer vehiclePlanCode) {
        this.vehiclePlanCode = vehiclePlanCode;
        return this;
    }
    public Integer getPrescoCode() {
        return prescoCode;
    }

    public JcSysOrganization setPrescoCode(Integer prescoCode) {
        this.prescoCode = prescoCode;
        return this;
    }

    @Override
    public String toString() {
        return "JcSysOrganization{" +
            "id=" + id +
            ", code=" + code +
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
            ", latitude=" + latitude +
            ", level=" + level +
            ", type=" + type +
            ", zid=" + zid +
            ", address=" + address +
            ", isOverdueCarrier=" + isOverdueCarrier +
            ", isOverdueContract=" + isOverdueContract +
            ", principal=" + principal +
            ", orderCode=" + orderCode +
            ", dispatchCode=" + dispatchCode +
            ", shipmentCode=" + shipmentCode +
            ", vehiclePlanCode=" + vehiclePlanCode +
            ", prescoCode=" + prescoCode +
        "}";
    }
}
