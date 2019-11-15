package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.util.Date;

/**
 * @author xyf
 * @since 2019-11-15
 */
@TableName("jc_vehicle_arrive")
public class VehicleArrive implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "ID", type = IdType.INPUT)
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

    @TableField("OPERATE_TIME")
    private Date operateTime;

    @TableField("VEHICLE_TIME")
    private Date vehicleTime;

    @TableField("WHICH_STATION")
    private String whichStation;

    @TableField("JC_ORGANIZATION_ID")
    private String jcOrganizationId;

    @TableField("JC_SHIPMENT_ID")
    private String jcShipmentId;

    @TableField("ARRIVE_TIME")
    private Date arriveTime;


    public String getId() {
        return id;
    }

    public VehicleArrive setId(String id) {
        this.id = id;
        return this;
    }

    public String getCreateName() {
        return createName;
    }

    public VehicleArrive setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public VehicleArrive setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public VehicleArrive setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getField1() {
        return field1;
    }

    public VehicleArrive setField1(String field1) {
        this.field1 = field1;
        return this;
    }

    public String getField2() {
        return field2;
    }

    public VehicleArrive setField2(String field2) {
        this.field2 = field2;
        return this;
    }

    public String getField3() {
        return field3;
    }

    public VehicleArrive setField3(String field3) {
        this.field3 = field3;
        return this;
    }

    public String getModifyName() {
        return modifyName;
    }

    public VehicleArrive setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public VehicleArrive setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
        return this;
    }

    public String getName() {
        return name;
    }

    public VehicleArrive setName(String name) {
        this.name = name;
        return this;
    }

    public Integer getStatus() {
        return status;
    }

    public VehicleArrive setStatus(Integer status) {
        this.status = status;
        return this;
    }

    public Date getOperateTime() {
        return operateTime;
    }

    public VehicleArrive setOperateTime(Date operateTime) {
        this.operateTime = operateTime;
        return this;
    }

    public Date getVehicleTime() {
        return vehicleTime;
    }

    public VehicleArrive setVehicleTime(Date vehicleTime) {
        this.vehicleTime = vehicleTime;
        return this;
    }

    public String getWhichStation() {
        return whichStation;
    }

    public VehicleArrive setWhichStation(String whichStation) {
        this.whichStation = whichStation;
        return this;
    }

    public String getJcOrganizationId() {
        return jcOrganizationId;
    }

    public VehicleArrive setJcOrganizationId(String jcOrganizationId) {
        this.jcOrganizationId = jcOrganizationId;
        return this;
    }

    public String getJcShipmentId() {
        return jcShipmentId;
    }

    public VehicleArrive setJcShipmentId(String jcShipmentId) {
        this.jcShipmentId = jcShipmentId;
        return this;
    }

    public Date getArriveTime() {
        return arriveTime;
    }

    public VehicleArrive setArriveTime(Date arriveTime) {
        this.arriveTime = arriveTime;
        return this;
    }

    @Override
    public String toString() {
        return "VehicleArrive{" +
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
        ", operateTime=" + operateTime +
        ", vehicleTime=" + vehicleTime +
        ", whichStation=" + whichStation +
        ", jcOrganizationId=" + jcOrganizationId +
        ", jcShipmentId=" + jcShipmentId +
        ", arriveTime=" + arriveTime +
        "}";
    }
}
