package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;

import java.util.Date;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author lcy
 * @since 2019-10-30
 */
@TableName("jc_led")
public class JcLed implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "ID", type = IdType.AUTO)
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

    @TableField("BACK_NUMBER")
    private Integer backNumber;

    @TableField("COSTOMER_IS_EXCEED")
    private Integer costomerIsExceed;

    @TableField("COSTOMER_NAME")
    private String costomerName;

    @TableField("COSTOMER_TYPE")
    private Integer costomerType;

    @TableField("FACT_ARRIVE_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date factArriveTime;

    @TableField("FACT_LEAVE_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date factLeaveTime;

    @TableField("FEE_TYPE")
    private Integer feeType;

    @TableField("HANDOVER_TYPE")
    private Integer handoverType;

    @TableField("IS_ABNORMAL")
    private Integer isAbnormal;

    @TableField("IS_BACK")
    private Integer isBack;

    @TableField("NUMBER")
    private Integer number;

    @TableField("ORDER_MILEAGE")
    private Double orderMileage;

    @TableField("PLAN_ARRIVE_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date planArriveTime;

    @TableField("PLAN_LEAVE_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date planLeaveTime;

    @TableField("RELATEBILL1")
    private String relatebill1;

    @TableField("RELATEBILL2")
    private String relatebill2;

    @TableField("RELATEBILL3")
    private String relatebill3;

    @TableField("RELATEBILL4")
    private String relatebill4;

    @TableField("RELATEBILL5")
    private String relatebill5;

    @TableField("SALE_PERSION")
    private String salePersion;

    @TableField("SHIPMENT_METHOD")
    private Integer shipmentMethod;

    @TableField("TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date time;

    @TableField("TRANSPORT_PRO")
    private Integer transportPro;

    @TableField("VALUE")
    private Double value;

    @TableField("VOLUME")
    private Double volume;

    @TableField("WEIGHT")
    private Double weight;

    @TableField("JC_CUSTOMER_ID")
    private String jcCustomerId;

    @TableField("JC_END_ZONE_ID")
    private String jcEndZoneId;

    @TableField("JC_ORDER_ID")
    private String jcOrderId;

    @TableField("JC_ORGANIZATION_ID")
    private String jcOrganizationId;

    @TableField("JC_PRESCO_ID")
    private String jcPrescoId;

    @TableField("JC_SINGLE_ID")
    private String jcSingleId;

    @TableField("JC_START_ZONE_ID")
    private String jcStartZoneId;

    @TableField("JC_TO_ORGANIZATION_ID")
    private String jcToOrganizationId;

    @TableField("JC_ZONE_STOREROOM_ID")
    private String jcZoneStoreroomId;

    @TableField("JC_FORM_ORGANIZATION_ID")
    private String jcFormOrganizationId;

    @TableField("TYPE")
    private Integer type;

    @TableField("AGENT")
    private Double agent;

    @TableField("QS_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date qsTime;

    @TableField("QS_PERSON")
    private String qsPerson;

    @TableField("JZ_WEIGHT")
    private Double jzWeight;

    @TableField("ARRIVE_PAY")
    private Double arrivePay;

    @TableField("JC_SHIPMENT_ID")
    private String jcShipmentId;

    public String getId() {
        return id;
    }

    public JcLed setId(String id) {
        this.id = id;
        return this;
    }
    public String getCode() {
        return code;
    }

    public JcLed setCode(String code) {
        this.code = code;
        return this;
    }
    public String getCreateName() {
        return createName;
    }

    public JcLed setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public JcLed setDescription(String description) {
        this.description = description;
        return this;
    }
    public String getField1() {
        return field1;
    }

    public JcLed setField1(String field1) {
        this.field1 = field1;
        return this;
    }
    public String getField2() {
        return field2;
    }

    public JcLed setField2(String field2) {
        this.field2 = field2;
        return this;
    }
    public String getField3() {
        return field3;
    }

    public JcLed setField3(String field3) {
        this.field3 = field3;
        return this;
    }
    public String getModifyName() {
        return modifyName;
    }

    public JcLed setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public String getName() {
        return name;
    }

    public JcLed setName(String name) {
        this.name = name;
        return this;
    }
    public Integer getStatus() {
        return status;
    }

    public JcLed setStatus(Integer status) {
        this.status = status;
        return this;
    }
    public Integer getBackNumber() {
        return backNumber;
    }

    public JcLed setBackNumber(Integer backNumber) {
        this.backNumber = backNumber;
        return this;
    }
    public Integer getCostomerIsExceed() {
        return costomerIsExceed;
    }

    public JcLed setCostomerIsExceed(Integer costomerIsExceed) {
        this.costomerIsExceed = costomerIsExceed;
        return this;
    }
    public String getCostomerName() {
        return costomerName;
    }

    public JcLed setCostomerName(String costomerName) {
        this.costomerName = costomerName;
        return this;
    }
    public Integer getCostomerType() {
        return costomerType;
    }

    public JcLed setCostomerType(Integer costomerType) {
        this.costomerType = costomerType;
        return this;
    }

    public Integer getFeeType() {
        return feeType;
    }

    public JcLed setFeeType(Integer feeType) {
        this.feeType = feeType;
        return this;
    }
    public Integer getHandoverType() {
        return handoverType;
    }

    public JcLed setHandoverType(Integer handoverType) {
        this.handoverType = handoverType;
        return this;
    }
    public Integer getIsAbnormal() {
        return isAbnormal;
    }

    public JcLed setIsAbnormal(Integer isAbnormal) {
        this.isAbnormal = isAbnormal;
        return this;
    }
    public Integer getIsBack() {
        return isBack;
    }

    public JcLed setIsBack(Integer isBack) {
        this.isBack = isBack;
        return this;
    }
    public Integer getNumber() {
        return number;
    }

    public JcLed setNumber(Integer number) {
        this.number = number;
        return this;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Double getOrderMileage() {
        return orderMileage;
    }

    public JcLed setOrderMileage(Double orderMileage) {
        this.orderMileage = orderMileage;
        return this;
    }

    public String getRelatebill1() {
        return relatebill1;
    }

    public JcLed setRelatebill1(String relatebill1) {
        this.relatebill1 = relatebill1;
        return this;
    }
    public String getRelatebill2() {
        return relatebill2;
    }

    public JcLed setRelatebill2(String relatebill2) {
        this.relatebill2 = relatebill2;
        return this;
    }
    public String getRelatebill3() {
        return relatebill3;
    }

    public JcLed setRelatebill3(String relatebill3) {
        this.relatebill3 = relatebill3;
        return this;
    }
    public String getRelatebill4() {
        return relatebill4;
    }

    public JcLed setRelatebill4(String relatebill4) {
        this.relatebill4 = relatebill4;
        return this;
    }
    public String getRelatebill5() {
        return relatebill5;
    }

    public JcLed setRelatebill5(String relatebill5) {
        this.relatebill5 = relatebill5;
        return this;
    }
    public String getSalePersion() {
        return salePersion;
    }

    public JcLed setSalePersion(String salePersion) {
        this.salePersion = salePersion;
        return this;
    }
    public Integer getShipmentMethod() {
        return shipmentMethod;
    }

    public JcLed setShipmentMethod(Integer shipmentMethod) {
        this.shipmentMethod = shipmentMethod;
        return this;
    }

    public Integer getTransportPro() {
        return transportPro;
    }

    public JcLed setTransportPro(Integer transportPro) {
        this.transportPro = transportPro;
        return this;
    }
    public Double getValue() {
        return value;
    }

    public JcLed setValue(Double value) {
        this.value = value;
        return this;
    }
    public Double getVolume() {
        return volume;
    }

    public JcLed setVolume(Double volume) {
        this.volume = volume;
        return this;
    }
    public Double getWeight() {
        return weight;
    }

    public JcLed setWeight(Double weight) {
        this.weight = weight;
        return this;
    }
    public String getJcCustomerId() {
        return jcCustomerId;
    }

    public JcLed setJcCustomerId(String jcCustomerId) {
        this.jcCustomerId = jcCustomerId;
        return this;
    }
    public String getJcEndZoneId() {
        return jcEndZoneId;
    }

    public JcLed setJcEndZoneId(String jcEndZoneId) {
        this.jcEndZoneId = jcEndZoneId;
        return this;
    }
    public String getJcOrderId() {
        return jcOrderId;
    }

    public JcLed setJcOrderId(String jcOrderId) {
        this.jcOrderId = jcOrderId;
        return this;
    }
    public String getJcOrganizationId() {
        return jcOrganizationId;
    }

    public JcLed setJcOrganizationId(String jcOrganizationId) {
        this.jcOrganizationId = jcOrganizationId;
        return this;
    }
    public String getJcPrescoId() {
        return jcPrescoId;
    }

    public JcLed setJcPrescoId(String jcPrescoId) {
        this.jcPrescoId = jcPrescoId;
        return this;
    }
    public String getJcSingleId() {
        return jcSingleId;
    }

    public JcLed setJcSingleId(String jcSingleId) {
        this.jcSingleId = jcSingleId;
        return this;
    }
    public String getJcStartZoneId() {
        return jcStartZoneId;
    }

    public JcLed setJcStartZoneId(String jcStartZoneId) {
        this.jcStartZoneId = jcStartZoneId;
        return this;
    }
    public String getJcToOrganizationId() {
        return jcToOrganizationId;
    }

    public JcLed setJcToOrganizationId(String jcToOrganizationId) {
        this.jcToOrganizationId = jcToOrganizationId;
        return this;
    }
    public String getJcZoneStoreroomId() {
        return jcZoneStoreroomId;
    }

    public JcLed setJcZoneStoreroomId(String jcZoneStoreroomId) {
        this.jcZoneStoreroomId = jcZoneStoreroomId;
        return this;
    }
    public String getJcFormOrganizationId() {
        return jcFormOrganizationId;
    }

    public JcLed setJcFormOrganizationId(String jcFormOrganizationId) {
        this.jcFormOrganizationId = jcFormOrganizationId;
        return this;
    }
    public Integer getType() {
        return type;
    }

    public JcLed setType(Integer type) {
        this.type = type;
        return this;
    }
    public Double getAgent() {
        return agent;
    }

    public JcLed setAgent(Double agent) {
        this.agent = agent;
        return this;
    }

    public Date getCreateTime() {
        return createTime;
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

    public Date getPlanArriveTime() {
        return planArriveTime;
    }

    public void setPlanArriveTime(Date planArriveTime) {
        this.planArriveTime = planArriveTime;
    }

    public Date getPlanLeaveTime() {
        return planLeaveTime;
    }

    public void setPlanLeaveTime(Date planLeaveTime) {
        this.planLeaveTime = planLeaveTime;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Date getQsTime() {
        return qsTime;
    }

    public void setQsTime(Date qsTime) {
        this.qsTime = qsTime;
    }

    public String getQsPerson() {
        return qsPerson;
    }

    public JcLed setQsPerson(String qsPerson) {
        this.qsPerson = qsPerson;
        return this;
    }
    public Double getJzWeight() {
        return jzWeight;
    }

    public JcLed setJzWeight(Double jzWeight) {
        this.jzWeight = jzWeight;
        return this;
    }
    public Double getArrivePay() {
        return arrivePay;
    }

    public JcLed setArrivePay(Double arrivePay) {
        this.arrivePay = arrivePay;
        return this;
    }
    public String getJcShipmentId() {
        return jcShipmentId;
    }

    public JcLed setJcShipmentId(String jcShipmentId) {
        this.jcShipmentId = jcShipmentId;
        return this;
    }

    @Override
    public String toString() {
        return "JcLed{" +
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
            ", backNumber=" + backNumber +
            ", costomerIsExceed=" + costomerIsExceed +
            ", costomerName=" + costomerName +
            ", costomerType=" + costomerType +
            ", factArriveTime=" + factArriveTime +
            ", factLeaveTime=" + factLeaveTime +
            ", feeType=" + feeType +
            ", handoverType=" + handoverType +
            ", isAbnormal=" + isAbnormal +
            ", isBack=" + isBack +
            ", number=" + number +
            ", orderMileage=" + orderMileage +
            ", planArriveTime=" + planArriveTime +
            ", planLeaveTime=" + planLeaveTime +
            ", relatebill1=" + relatebill1 +
            ", relatebill2=" + relatebill2 +
            ", relatebill3=" + relatebill3 +
            ", relatebill4=" + relatebill4 +
            ", relatebill5=" + relatebill5 +
            ", salePersion=" + salePersion +
            ", shipmentMethod=" + shipmentMethod +
            ", time=" + time +
            ", transportPro=" + transportPro +
            ", value=" + value +
            ", volume=" + volume +
            ", weight=" + weight +
            ", jcCustomerId=" + jcCustomerId +
            ", jcEndZoneId=" + jcEndZoneId +
            ", jcOrderId=" + jcOrderId +
            ", jcOrganizationId=" + jcOrganizationId +
            ", jcPrescoId=" + jcPrescoId +
            ", jcSingleId=" + jcSingleId +
            ", jcStartZoneId=" + jcStartZoneId +
            ", jcToOrganizationId=" + jcToOrganizationId +
            ", jcZoneStoreroomId=" + jcZoneStoreroomId +
            ", jcFormOrganizationId=" + jcFormOrganizationId +
            ", type=" + type +
            ", agent=" + agent +
            ", qsTime=" + qsTime +
            ", qsPerson=" + qsPerson +
            ", jzWeight=" + jzWeight +
            ", arrivePay=" + arrivePay +
            ", jcShipmentId=" + jcShipmentId +
        "}";
    }
}
