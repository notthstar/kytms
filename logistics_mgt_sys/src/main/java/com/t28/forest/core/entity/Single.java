package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * @author xyf
 * @since 2019-11-03
 */
public class Single implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "ID", type = IdType.INPUT)
    private String id;

    @TableField("CODE")
    private String code;

    @TableField("CREATE_NAME")
    private String createName;

    @TableField("CREATE_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
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
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date modifyTime;

    @TableField("NAME")
    private String name;

    @TableField("STATUS")
    private Integer status;

    @TableField("ACCOUNT_TYPE")
    private Integer accountType;

    @TableField("DATE_BILLING")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date dateBilling;

    @TableField("DRIVER_IPHONE")
    private String driverIphone;

    @TableField("TO_SEND_INFO")
    private String toSendInfo;

    @TableField("JC_CARRIER_ID")
    private String jcCarrierId;

    @TableField("DRIVER_TEMPORARY")
    private String driverTemporary;

    @TableField("VEHICLEHEAD_TEMPORARY")
    private String vehicleheadTemporary;

    @TableField("JC_ORGANIZATION_ID")
    private String jcOrganizationId;

    @TableField("CARRIER_TYPE")
    private Integer carrierType;

    @TableField("DRIVER_IPHONE_TEMPORARY")
    private String driverIphoneTemporary;

    @TableField("PLAN_CILCK_END_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date planCilckEndTime;

    @TableField("PLAN_CILCK_START_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date planCilckStartTime;

    @TableField("PLAN_END_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date planEndTime;

    @TableField("PLAN_START_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date planStartTime;

    @TableField("DRIVER")
    private String driver;

    @TableField("VEHICLE_HEAD")
    private String vehicleHead;

    @TableField("JC_VEHICLE_ID")
    private String jcVehicleId;

    @TableField("JC_DRIVER_ID")
    private String jcDriverId;

    @TableField("JC_VEHICLEHEAD_ID")
    private String jcVehicleheadId;

    @TableField("COST")
    private Double cost;

    @TableField("RATE")
    private Double rate;

    @TableField("TAXES")
    private Double taxes;

    @TableField("IS_OVERDUE_CARRIER")
    private Integer isOverdueCarrier;

    @TableField("IS_ABNORMAIL")
    private Integer isAbnormail;

    @TableField("NUMBER")
    private Integer number;

    @TableField("VOLUME")
    private Double volume;

    @TableField("WEIGHT")
    private Double weight;

    @TableField("REBUBBLE_RATIO")
    private String rebubbleRatio;

    @TableField("AGENT")
    private Double agent;

    @TableField("PRINT_CONUT")
    private Integer printConut;

    @TableField("ARRIVE_PAY")
    private Double arrivePay;


    public String getId() {
        return id;
    }

    public Single setId(String id) {
        this.id = id;
        return this;
    }

    public String getCode() {
        return code;
    }

    public Single setCode(String code) {
        this.code = code;
        return this;
    }

    public String getCreateName() {
        return createName;
    }

    public Single setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public Single setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public Single setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getField1() {
        return field1;
    }

    public Single setField1(String field1) {
        this.field1 = field1;
        return this;
    }

    public String getField2() {
        return field2;
    }

    public Single setField2(String field2) {
        this.field2 = field2;
        return this;
    }

    public String getField3() {
        return field3;
    }

    public Single setField3(String field3) {
        this.field3 = field3;
        return this;
    }

    public String getModifyName() {
        return modifyName;
    }

    public Single setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public Single setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
        return this;
    }

    public String getName() {
        return name;
    }

    public Single setName(String name) {
        this.name = name;
        return this;
    }

    public Integer getStatus() {
        return status;
    }

    public Single setStatus(Integer status) {
        this.status = status;
        return this;
    }

    public Integer getAccountType() {
        return accountType;
    }

    public Single setAccountType(Integer accountType) {
        this.accountType = accountType;
        return this;
    }

    public Date getDateBilling() {
        return dateBilling;
    }

    public Single setDateBilling(Date dateBilling) {
        this.dateBilling = dateBilling;
        return this;
    }

    public String getDriverIphone() {
        return driverIphone;
    }

    public Single setDriverIphone(String driverIphone) {
        this.driverIphone = driverIphone;
        return this;
    }

    public String getToSendInfo() {
        return toSendInfo;
    }

    public Single setToSendInfo(String toSendInfo) {
        this.toSendInfo = toSendInfo;
        return this;
    }

    public String getJcCarrierId() {
        return jcCarrierId;
    }

    public Single setJcCarrierId(String jcCarrierId) {
        this.jcCarrierId = jcCarrierId;
        return this;
    }

    public String getDriverTemporary() {
        return driverTemporary;
    }

    public Single setDriverTemporary(String driverTemporary) {
        this.driverTemporary = driverTemporary;
        return this;
    }

    public String getVehicleheadTemporary() {
        return vehicleheadTemporary;
    }

    public Single setVehicleheadTemporary(String vehicleheadTemporary) {
        this.vehicleheadTemporary = vehicleheadTemporary;
        return this;
    }

    public String getJcOrganizationId() {
        return jcOrganizationId;
    }

    public Single setJcOrganizationId(String jcOrganizationId) {
        this.jcOrganizationId = jcOrganizationId;
        return this;
    }

    public Integer getCarrierType() {
        return carrierType;
    }

    public Single setCarrierType(Integer carrierType) {
        this.carrierType = carrierType;
        return this;
    }

    public String getDriverIphoneTemporary() {
        return driverIphoneTemporary;
    }

    public Single setDriverIphoneTemporary(String driverIphoneTemporary) {
        this.driverIphoneTemporary = driverIphoneTemporary;
        return this;
    }

    public Date getPlanCilckEndTime() {
        return planCilckEndTime;
    }

    public Single setPlanCilckEndTime(Date planCilckEndTime) {
        this.planCilckEndTime = planCilckEndTime;
        return this;
    }

    public Date getPlanCilckStartTime() {
        return planCilckStartTime;
    }

    public Single setPlanCilckStartTime(Date planCilckStartTime) {
        this.planCilckStartTime = planCilckStartTime;
        return this;
    }

    public Date getPlanEndTime() {
        return planEndTime;
    }

    public Single setPlanEndTime(Date planEndTime) {
        this.planEndTime = planEndTime;
        return this;
    }

    public Date getPlanStartTime() {
        return planStartTime;
    }

    public Single setPlanStartTime(Date planStartTime) {
        this.planStartTime = planStartTime;
        return this;
    }

    public String getDriver() {
        return driver;
    }

    public Single setDriver(String driver) {
        this.driver = driver;
        return this;
    }

    public String getVehicleHead() {
        return vehicleHead;
    }

    public Single setVehicleHead(String vehicleHead) {
        this.vehicleHead = vehicleHead;
        return this;
    }

    public String getJcVehicleId() {
        return jcVehicleId;
    }

    public Single setJcVehicleId(String jcVehicleId) {
        this.jcVehicleId = jcVehicleId;
        return this;
    }

    public String getJcDriverId() {
        return jcDriverId;
    }

    public Single setJcDriverId(String jcDriverId) {
        this.jcDriverId = jcDriverId;
        return this;
    }

    public String getJcVehicleheadId() {
        return jcVehicleheadId;
    }

    public Single setJcVehicleheadId(String jcVehicleheadId) {
        this.jcVehicleheadId = jcVehicleheadId;
        return this;
    }

    public Double getCost() {
        return cost;
    }

    public Single setCost(Double cost) {
        this.cost = cost;
        return this;
    }

    public Double getRate() {
        return rate;
    }

    public Single setRate(Double rate) {
        this.rate = rate;
        return this;
    }

    public Double getTaxes() {
        return taxes;
    }

    public Single setTaxes(Double taxes) {
        this.taxes = taxes;
        return this;
    }

    public Integer getIsOverdueCarrier() {
        return isOverdueCarrier;
    }

    public Single setIsOverdueCarrier(Integer isOverdueCarrier) {
        this.isOverdueCarrier = isOverdueCarrier;
        return this;
    }

    public Integer getIsAbnormail() {
        return isAbnormail;
    }

    public Single setIsAbnormail(Integer isAbnormail) {
        this.isAbnormail = isAbnormail;
        return this;
    }

    public Integer getNumber() {
        return number;
    }

    public Single setNumber(Integer number) {
        this.number = number;
        return this;
    }

    public Double getVolume() {
        return volume;
    }

    public Single setVolume(Double volume) {
        this.volume = volume;
        return this;
    }

    public Double getWeight() {
        return weight;
    }

    public Single setWeight(Double weight) {
        this.weight = weight;
        return this;
    }

    public String getRebubbleRatio() {
        return rebubbleRatio;
    }

    public Single setRebubbleRatio(String rebubbleRatio) {
        this.rebubbleRatio = rebubbleRatio;
        return this;
    }

    public Double getAgent() {
        return agent;
    }

    public Single setAgent(Double agent) {
        this.agent = agent;
        return this;
    }

    public Integer getPrintConut() {
        return printConut;
    }

    public Single setPrintConut(Integer printConut) {
        this.printConut = printConut;
        return this;
    }

    public Double getArrivePay() {
        return arrivePay;
    }

    public Single setArrivePay(Double arrivePay) {
        this.arrivePay = arrivePay;
        return this;
    }

    @Override
    public String toString() {
        return "Single{" +
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
        ", accountType=" + accountType +
        ", dateBilling=" + dateBilling +
        ", driverIphone=" + driverIphone +
        ", toSendInfo=" + toSendInfo +
        ", jcCarrierId=" + jcCarrierId +
        ", driverTemporary=" + driverTemporary +
        ", vehicleheadTemporary=" + vehicleheadTemporary +
        ", jcOrganizationId=" + jcOrganizationId +
        ", carrierType=" + carrierType +
        ", driverIphoneTemporary=" + driverIphoneTemporary +
        ", planCilckEndTime=" + planCilckEndTime +
        ", planCilckStartTime=" + planCilckStartTime +
        ", planEndTime=" + planEndTime +
        ", planStartTime=" + planStartTime +
        ", driver=" + driver +
        ", vehicleHead=" + vehicleHead +
        ", jcVehicleId=" + jcVehicleId +
        ", jcDriverId=" + jcDriverId +
        ", jcVehicleheadId=" + jcVehicleheadId +
        ", cost=" + cost +
        ", rate=" + rate +
        ", taxes=" + taxes +
        ", isOverdueCarrier=" + isOverdueCarrier +
        ", isAbnormail=" + isAbnormail +
        ", number=" + number +
        ", volume=" + volume +
        ", weight=" + weight +
        ", rebubbleRatio=" + rebubbleRatio +
        ", agent=" + agent +
        ", printConut=" + printConut +
        ", arrivePay=" + arrivePay +
        "}";
    }
}
