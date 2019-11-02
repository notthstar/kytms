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
 * @since 2019-11-01
 */
@TableName("jc_order")
public class JcOrder implements Serializable {

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

    @TableField("TIME")
    private Date time;

    @TableField("STATUS")
    private Integer status;

    @TableField("COSTOMER_TYPE")
    private Integer costomerType;

    @TableField("BACK_NUMBER")
    private Integer backNumber;

    @TableField("COSTOMER_IS_EXCEED")
    private Integer costomerIsExceed;

    @TableField("COSTOMER_NAME")
    private String costomerName;



    @TableField("FEE_TYEP")
    private Integer feeTyep;

    @TableField("FROM_CITY")
    private String fromCity;

    @TableField("FY_TIME")
    private Date fyTime;

    @TableField("HANDOVER_TYPE")
    private Integer handoverType;

    @TableField("IS_ABNORMAL")
    private Integer isAbnormal;

    @TableField("IS_BACK")
    private Integer isBack;

    @TableField("IS_BILLING")
    private Integer isBilling;

    @TableField("JS_STATUS")
    private Integer jsStatus;

    @TableField("LOADING_METHOD")
    private Integer loadingMethod;

    @TableField("NUMBER")
    private Integer number;

    @TableField("ORDER_MILEAGE")
    private Double orderMileage;


    @TableField("CODE")
    private String code;

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



    @TableField("TO_CITY")
    private String toCity;

    @TableField("TRANSPORT_PRO")
    private Integer transportPro;

    @TableField("VALUE")
    private Double value;

    @TableField("VOLUME")
    private Double volume;

    @TableField("WEIGHT")
    private Double weight;

    @TableField("YD_TIME")
    private Date ydTime;

    @TableField("JC_CUSTOMER_ID")
    private String jcCustomerId;

    @TableField("JC_ORGANIZATION_ID")
    private String jcOrganizationId;

    @TableField("JC_SETTLEMENT_ID")
    private String jcSettlementId;

    @TableField("JC_SINGLE_ID")
    private String jcSingleId;

    @TableField("FACT_ARRIVE_TIME")
    private Date factArriveTime;

    @TableField("FACT_LEAVE_TIME")
    private Date factLeaveTime;

    @TableField("PLAN_ARRIVE_TIME")
    private Date planArriveTime;

    @TableField("PLAN_LEAVE_TIME")
    private Date planLeaveTime;

    @TableField("JC_FROM_ORGANIZATION_ID")
    private String jcFromOrganizationId;

    @TableField("JC_TO_ORGANIZATION_ID")
    private String jcToOrganizationId;

    @TableField("HX_MONEY")
    private Double hxMoney;

    @TableField("HX_TYPE")
    private Integer hxType;

    @TableField("WHX_MONEY")
    private Double whxMoney;

    @TableField("JC_ZONE_STOREROOM_ID")
    private String jcZoneStoreroomId;

    @TableField("JC_END_ZONE_ID")
    private String jcEndZoneId;

    @TableField("JC_START_ZONE_ID")
    private String jcStartZoneId;

    @TableField("JC_FROM_CITY_ID")
    private String jcFromCityId;

    @TableField("JC_TO_CITY_ID")
    private String jcToCityId;

    @TableField("IS_TAKE")
    private Integer isTake;

    @TableField("AGENT")
    private Double agent;

    @TableField("QS_TIME")
    private Date qsTime;

    @TableField("QS_PERSON")
    private String qsPerson;

    @TableField("JZ_WEIGHT")
    private Double jzWeight;

    @TableField("JC_PRESCO_ID")
    private String jcPrescoId;

    @TableField("JS_TYPE")
    private Integer jsType;

    @TableField("PRICE")
    private Double price;

    @TableField("Z_AMOUNT")
    private Double zAmount;

    @TableField("IS_INOUTCOME")
    private Integer isInoutcome;

    public String getId() {
        return id;
    }

    public JcOrder setId(String id) {
        this.id = id;
        return this;
    }
    public String getCode() {
        return code;
    }

    public JcOrder setCode(String code) {
        this.code = code;
        return this;
    }
    public String getCreateName() {
        return createName;
    }

    public JcOrder setCreateName(String createName) {
        this.createName = createName;
        return this;
    }
    public String getDescription() {
        return description;
    }

    public JcOrder setDescription(String description) {
        this.description = description;
        return this;
    }
    public String getField1() {
        return field1;
    }

    public JcOrder setField1(String field1) {
        this.field1 = field1;
        return this;
    }
    public String getField2() {
        return field2;
    }

    public JcOrder setField2(String field2) {
        this.field2 = field2;
        return this;
    }
    public String getField3() {
        return field3;
    }

    public JcOrder setField3(String field3) {
        this.field3 = field3;
        return this;
    }
    public String getModifyName() {
        return modifyName;
    }

    public JcOrder setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public String getName() {
        return name;
    }

    public JcOrder setName(String name) {
        this.name = name;
        return this;
    }
    public Integer getStatus() {
        return status;
    }

    public JcOrder setStatus(Integer status) {
        this.status = status;
        return this;
    }
    public Integer getBackNumber() {
        return backNumber;
    }

    public JcOrder setBackNumber(Integer backNumber) {
        this.backNumber = backNumber;
        return this;
    }
    public Integer getCostomerIsExceed() {
        return costomerIsExceed;
    }

    public JcOrder setCostomerIsExceed(Integer costomerIsExceed) {
        this.costomerIsExceed = costomerIsExceed;
        return this;
    }
    public String getCostomerName() {
        return costomerName;
    }

    public JcOrder setCostomerName(String costomerName) {
        this.costomerName = costomerName;
        return this;
    }
    public Integer getCostomerType() {
        return costomerType;
    }

    public JcOrder setCostomerType(Integer costomerType) {
        this.costomerType = costomerType;
        return this;
    }
    public Integer getFeeTyep() {
        return feeTyep;
    }

    public JcOrder setFeeTyep(Integer feeTyep) {
        this.feeTyep = feeTyep;
        return this;
    }
    public String getFromCity() {
        return fromCity;
    }

    public JcOrder setFromCity(String fromCity) {
        this.fromCity = fromCity;
        return this;
    }

    public Integer getHandoverType() {
        return handoverType;
    }

    public JcOrder setHandoverType(Integer handoverType) {
        this.handoverType = handoverType;
        return this;
    }
    public Integer getIsAbnormal() {
        return isAbnormal;
    }

    public JcOrder setIsAbnormal(Integer isAbnormal) {
        this.isAbnormal = isAbnormal;
        return this;
    }
    public Integer getIsBack() {
        return isBack;
    }

    public JcOrder setIsBack(Integer isBack) {
        this.isBack = isBack;
        return this;
    }
    public Integer getIsBilling() {
        return isBilling;
    }

    public JcOrder setIsBilling(Integer isBilling) {
        this.isBilling = isBilling;
        return this;
    }
    public Integer getJsStatus() {
        return jsStatus;
    }

    public JcOrder setJsStatus(Integer jsStatus) {
        this.jsStatus = jsStatus;
        return this;
    }
    public Integer getLoadingMethod() {
        return loadingMethod;
    }

    public JcOrder setLoadingMethod(Integer loadingMethod) {
        this.loadingMethod = loadingMethod;
        return this;
    }
    public Integer getNumber() {
        return number;
    }

    public JcOrder setNumber(Integer number) {
        this.number = number;
        return this;
    }
    public Double getOrderMileage() {
        return orderMileage;
    }

    public JcOrder setOrderMileage(Double orderMileage) {
        this.orderMileage = orderMileage;
        return this;
    }
    public String getRelatebill1() {
        return relatebill1;
    }

    public JcOrder setRelatebill1(String relatebill1) {
        this.relatebill1 = relatebill1;
        return this;
    }
    public String getRelatebill2() {
        return relatebill2;
    }

    public JcOrder setRelatebill2(String relatebill2) {
        this.relatebill2 = relatebill2;
        return this;
    }
    public String getRelatebill3() {
        return relatebill3;
    }

    public JcOrder setRelatebill3(String relatebill3) {
        this.relatebill3 = relatebill3;
        return this;
    }
    public String getRelatebill4() {
        return relatebill4;
    }

    public JcOrder setRelatebill4(String relatebill4) {
        this.relatebill4 = relatebill4;
        return this;
    }
    public String getRelatebill5() {
        return relatebill5;
    }

    public JcOrder setRelatebill5(String relatebill5) {
        this.relatebill5 = relatebill5;
        return this;
    }
    public String getSalePersion() {
        return salePersion;
    }

    public JcOrder setSalePersion(String salePersion) {
        this.salePersion = salePersion;
        return this;
    }
    public Integer getShipmentMethod() {
        return shipmentMethod;
    }

    public JcOrder setShipmentMethod(Integer shipmentMethod) {
        this.shipmentMethod = shipmentMethod;
        return this;
    }

    public String getToCity() {
        return toCity;
    }

    public JcOrder setToCity(String toCity) {
        this.toCity = toCity;
        return this;
    }
    public Integer getTransportPro() {
        return transportPro;
    }

    public JcOrder setTransportPro(Integer transportPro) {
        this.transportPro = transportPro;
        return this;
    }
    public Double getValue() {
        return value;
    }

    public JcOrder setValue(Double value) {
        this.value = value;
        return this;
    }
    public Double getVolume() {
        return volume;
    }

    public JcOrder setVolume(Double volume) {
        this.volume = volume;
        return this;
    }
    public Double getWeight() {
        return weight;
    }

    public JcOrder setWeight(Double weight) {
        this.weight = weight;
        return this;
    }

    public String getJcCustomerId() {
        return jcCustomerId;
    }

    public JcOrder setJcCustomerId(String jcCustomerId) {
        this.jcCustomerId = jcCustomerId;
        return this;
    }
    public String getJcOrganizationId() {
        return jcOrganizationId;
    }

    public JcOrder setJcOrganizationId(String jcOrganizationId) {
        this.jcOrganizationId = jcOrganizationId;
        return this;
    }
    public String getJcSettlementId() {
        return jcSettlementId;
    }

    public JcOrder setJcSettlementId(String jcSettlementId) {
        this.jcSettlementId = jcSettlementId;
        return this;
    }
    public String getJcSingleId() {
        return jcSingleId;
    }

    public JcOrder setJcSingleId(String jcSingleId) {
        this.jcSingleId = jcSingleId;
        return this;
    }


    public String getJcFromOrganizationId() {
        return jcFromOrganizationId;
    }

    public JcOrder setJcFromOrganizationId(String jcFromOrganizationId) {
        this.jcFromOrganizationId = jcFromOrganizationId;
        return this;
    }
    public String getJcToOrganizationId() {
        return jcToOrganizationId;
    }

    public JcOrder setJcToOrganizationId(String jcToOrganizationId) {
        this.jcToOrganizationId = jcToOrganizationId;
        return this;
    }
    public Double getHxMoney() {
        return hxMoney;
    }

    public JcOrder setHxMoney(Double hxMoney) {
        this.hxMoney = hxMoney;
        return this;
    }
    public Integer getHxType() {
        return hxType;
    }

    public JcOrder setHxType(Integer hxType) {
        this.hxType = hxType;
        return this;
    }
    public Double getWhxMoney() {
        return whxMoney;
    }

    public JcOrder setWhxMoney(Double whxMoney) {
        this.whxMoney = whxMoney;
        return this;
    }
    public String getJcZoneStoreroomId() {
        return jcZoneStoreroomId;
    }

    public JcOrder setJcZoneStoreroomId(String jcZoneStoreroomId) {
        this.jcZoneStoreroomId = jcZoneStoreroomId;
        return this;
    }
    public String getJcEndZoneId() {
        return jcEndZoneId;
    }

    public JcOrder setJcEndZoneId(String jcEndZoneId) {
        this.jcEndZoneId = jcEndZoneId;
        return this;
    }
    public String getJcStartZoneId() {
        return jcStartZoneId;
    }

    public JcOrder setJcStartZoneId(String jcStartZoneId) {
        this.jcStartZoneId = jcStartZoneId;
        return this;
    }
    public String getJcFromCityId() {
        return jcFromCityId;
    }

    public JcOrder setJcFromCityId(String jcFromCityId) {
        this.jcFromCityId = jcFromCityId;
        return this;
    }
    public String getJcToCityId() {
        return jcToCityId;
    }

    public JcOrder setJcToCityId(String jcToCityId) {
        this.jcToCityId = jcToCityId;
        return this;
    }
    public Integer getIsTake() {
        return isTake;
    }

    public JcOrder setIsTake(Integer isTake) {
        this.isTake = isTake;
        return this;
    }
    public Double getAgent() {
        return agent;
    }

    public JcOrder setAgent(Double agent) {
        this.agent = agent;
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

    public Date getFyTime() {
        return fyTime;
    }

    public void setFyTime(Date fyTime) {
        this.fyTime = fyTime;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Date getYdTime() {
        return ydTime;
    }

    public void setYdTime(Date ydTime) {
        this.ydTime = ydTime;
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

    public Date getQsTime() {
        return qsTime;
    }

    public void setQsTime(Date qsTime) {
        this.qsTime = qsTime;
    }

    public String getQsPerson() {
        return qsPerson;
    }

    public JcOrder setQsPerson(String qsPerson) {
        this.qsPerson = qsPerson;
        return this;
    }
    public Double getJzWeight() {
        return jzWeight;
    }

    public JcOrder setJzWeight(Double jzWeight) {
        this.jzWeight = jzWeight;
        return this;
    }
    public String getJcPrescoId() {
        return jcPrescoId;
    }

    public JcOrder setJcPrescoId(String jcPrescoId) {
        this.jcPrescoId = jcPrescoId;
        return this;
    }
    public Integer getJsType() {
        return jsType;
    }

    public JcOrder setJsType(Integer jsType) {
        this.jsType = jsType;
        return this;
    }
    public Double getPrice() {
        return price;
    }

    public JcOrder setPrice(Double price) {
        this.price = price;
        return this;
    }
    public Double getzAmount() {
        return zAmount;
    }

    public JcOrder setzAmount(Double zAmount) {
        this.zAmount = zAmount;
        return this;
    }
    public Integer getIsInoutcome() {
        return isInoutcome;
    }

    public JcOrder setIsInoutcome(Integer isInoutcome) {
        this.isInoutcome = isInoutcome;
        return this;
    }

    @Override
    public String toString() {
        return "JcOrder{" +
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
            ", feeTyep=" + feeTyep +
            ", fromCity=" + fromCity +
            ", fyTime=" + fyTime +
            ", handoverType=" + handoverType +
            ", isAbnormal=" + isAbnormal +
            ", isBack=" + isBack +
            ", isBilling=" + isBilling +
            ", jsStatus=" + jsStatus +
            ", loadingMethod=" + loadingMethod +
            ", number=" + number +
            ", orderMileage=" + orderMileage +
            ", relatebill1=" + relatebill1 +
            ", relatebill2=" + relatebill2 +
            ", relatebill3=" + relatebill3 +
            ", relatebill4=" + relatebill4 +
            ", relatebill5=" + relatebill5 +
            ", salePersion=" + salePersion +
            ", shipmentMethod=" + shipmentMethod +
            ", time=" + time +
            ", toCity=" + toCity +
            ", transportPro=" + transportPro +
            ", value=" + value +
            ", volume=" + volume +
            ", weight=" + weight +
            ", ydTime=" + ydTime +
            ", jcCustomerId=" + jcCustomerId +
            ", jcOrganizationId=" + jcOrganizationId +
            ", jcSettlementId=" + jcSettlementId +
            ", jcSingleId=" + jcSingleId +
            ", factArriveTime=" + factArriveTime +
            ", factLeaveTime=" + factLeaveTime +
            ", planArriveTime=" + planArriveTime +
            ", planLeaveTime=" + planLeaveTime +
            ", jcFromOrganizationId=" + jcFromOrganizationId +
            ", jcToOrganizationId=" + jcToOrganizationId +
            ", hxMoney=" + hxMoney +
            ", hxType=" + hxType +
            ", whxMoney=" + whxMoney +
            ", jcZoneStoreroomId=" + jcZoneStoreroomId +
            ", jcEndZoneId=" + jcEndZoneId +
            ", jcStartZoneId=" + jcStartZoneId +
            ", jcFromCityId=" + jcFromCityId +
            ", jcToCityId=" + jcToCityId +
            ", isTake=" + isTake +
            ", agent=" + agent +
            ", qsTime=" + qsTime +
            ", qsPerson=" + qsPerson +
            ", jzWeight=" + jzWeight +
            ", jcPrescoId=" + jcPrescoId +
            ", jsType=" + jsType +
            ", price=" + price +
            ", zAmount=" + zAmount +
            ", isInoutcome=" + isInoutcome +
        "}";
    }
}
