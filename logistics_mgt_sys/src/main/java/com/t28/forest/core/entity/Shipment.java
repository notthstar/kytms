package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;
import java.util.Objects;

/**
 * @author xyf
 * @since 2019-11-03
 */
@TableName("jc_shipment")
public class Shipment implements Serializable {

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

    @TableField("BACK_NUMBER")
    private Integer backNumber;

    @TableField("CARRIAGE_IS_EXCEED")
    private Integer carriageIsExceed;

    @TableField("CARRIER_TYPE")
    private Integer carrierType;

    @TableField("FACT_ARRIVE_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date factArriveTime;

    @TableField("FACT_LEAVER_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date factLeaverTime;

    @TableField("FEE_TYPE")
    private Integer feeType;

    @TableField("IS_ABNORMAL")
    private Integer isAbnormal;

    @TableField("JS_STATUS")
    private Integer jsStatus;

    @TableField("LIENSE")
    private String liense;

    @TableField("LOADING_INFO")
    private String loadingInfo;

    @TableField("LOADING_METHOD")
    private Integer loadingMethod;

    @TableField("NUMBER")
    private Double number;

    @TableField("OPERATION_PATTERN")
    private Integer operationPattern;

    @TableField("ORDER_CODE")
    private String orderCode;

    @TableField("OUT_DRIVER")
    private String outDriver;

    @TableField("PLAN_LEAVE_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date planLeaveTime;

    @TableField("REFUSE")
    private Integer refuse;

    @TableField("RELATEBILL1")
    private String relatebill1;

    @TableField("REQUIRE_ARRIVE_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date requireArriveTime;

    @TableField("SHIPMENT_METHOD")
    private Integer shipmentMethod;

    @TableField("TAN")
    private String tan;

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

    @TableField("JC_CARRIER_ID")
    private String jcCarrierId;

    @TableField("JC_DRIVER_ID")
    private String jcDriverId;

    @TableField("JC_ORGANIZATION_ID")
    private String jcOrganizationId;

    @TableField("JC_SETTLEMENT_ID")
    private String jcSettlementId;

    @TableField("JC_VEHICLE_ID")
    private String jcVehicleId;

    @TableField("JC_VEHICLE_HEAD_ID")
    private String jcVehicleHeadId;

    @TableField("ACTION_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date actionTime;

    @TableField("JC_FROM_ORGANIZATION_ID")
    private String jcFromOrganizationId;

    @TableField("JC_NEW_ORGANIZATION_ID")
    private String jcNewOrganizationId;

    @TableField("JC_NEXT_ORGANIZATION_ID")
    private String jcNextOrganizationId;

    @TableField("JC_TO_ORGANIZATION_ID")
    private String jcToOrganizationId;

    @TableField("ORG_IDS")
    private String orgIds;

    @TableField("OUT_IPHPNE")
    private String outIphpne;

    @TableField("ORGNAME_LIST")
    private String orgnameList;

    @TableField("JZ_WEIGHT")
    private Double jzWeight;

    @TableField("IS_INOUTCOME")
    private Integer isInoutcome;

    @TableField("JC_RULE_ID")
    private String jcRuleId;


    public String getId() {
        return id;
    }

    public Shipment setId(String id) {
        this.id = id;
        return this;
    }

    public String getCode() {
        return code;
    }

    public Shipment setCode(String code) {
        this.code = code;
        return this;
    }

    public String getCreateName() {
        return createName;
    }

    public Shipment setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public Shipment setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public Shipment setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getField1() {
        return field1;
    }

    public Shipment setField1(String field1) {
        this.field1 = field1;
        return this;
    }

    public String getField2() {
        return field2;
    }

    public Shipment setField2(String field2) {
        this.field2 = field2;
        return this;
    }

    public String getField3() {
        return field3;
    }

    public Shipment setField3(String field3) {
        this.field3 = field3;
        return this;
    }

    public String getModifyName() {
        return modifyName;
    }

    public Shipment setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public Shipment setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
        return this;
    }

    public String getName() {
        return name;
    }

    public Shipment setName(String name) {
        this.name = name;
        return this;
    }

    public Integer getStatus() {
        if (Objects.isNull(status)) {
            return 1;
        }
        return status;
    }

    public Shipment setStatus(Integer status) {
        this.status = status;
        return this;
    }

    public Integer getBackNumber() {
        return backNumber;
    }

    public Shipment setBackNumber(Integer backNumber) {
        this.backNumber = backNumber;
        return this;
    }

    public Integer getCarriageIsExceed() {
        return carriageIsExceed;
    }

    public Shipment setCarriageIsExceed(Integer carriageIsExceed) {
        this.carriageIsExceed = carriageIsExceed;
        return this;
    }

    public Integer getCarrierType() {
        return carrierType;
    }

    public Shipment setCarrierType(Integer carrierType) {
        this.carrierType = carrierType;
        return this;
    }

    public Date getFactArriveTime() {
        return factArriveTime;
    }

    public Shipment setFactArriveTime(Date factArriveTime) {
        this.factArriveTime = factArriveTime;
        return this;
    }

    public Date getFactLeaverTime() {
        return factLeaverTime;
    }

    public Shipment setFactLeaverTime(Date factLeaverTime) {
        this.factLeaverTime = factLeaverTime;
        return this;
    }

    public Integer getFeeType() {
        return feeType;
    }

    public Shipment setFeeType(Integer feeType) {
        this.feeType = feeType;
        return this;
    }

    public Integer getIsAbnormal() {
        return isAbnormal;
    }

    public Shipment setIsAbnormal(Integer isAbnormal) {
        this.isAbnormal = isAbnormal;
        return this;
    }

    public Integer getJsStatus() {
        return jsStatus;
    }

    public Shipment setJsStatus(Integer jsStatus) {
        this.jsStatus = jsStatus;
        return this;
    }

    public String getLiense() {
        return liense;
    }

    public Shipment setLiense(String liense) {
        this.liense = liense;
        return this;
    }

    public String getLoadingInfo() {
        return loadingInfo;
    }

    public Shipment setLoadingInfo(String loadingInfo) {
        this.loadingInfo = loadingInfo;
        return this;
    }

    public Integer getLoadingMethod() {
        return loadingMethod;
    }

    public Shipment setLoadingMethod(Integer loadingMethod) {
        this.loadingMethod = loadingMethod;
        return this;
    }

    public Double getNumber() {
        return number;
    }

    public Shipment setNumber(Double number) {
        this.number = number;
        return this;
    }

    public Integer getOperationPattern() {
        return operationPattern;
    }

    public Shipment setOperationPattern(Integer operationPattern) {
        this.operationPattern = operationPattern;
        return this;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public Shipment setOrderCode(String orderCode) {
        this.orderCode = orderCode;
        return this;
    }

    public String getOutDriver() {
        return outDriver;
    }

    public Shipment setOutDriver(String outDriver) {
        this.outDriver = outDriver;
        return this;
    }

    public Date getPlanLeaveTime() {
        return planLeaveTime;
    }

    public Shipment setPlanLeaveTime(Date planLeaveTime) {
        this.planLeaveTime = planLeaveTime;
        return this;
    }

    public Integer getRefuse() {
        return refuse;
    }

    public Shipment setRefuse(Integer refuse) {
        this.refuse = refuse;
        return this;
    }

    public String getRelatebill1() {
        return relatebill1;
    }

    public Shipment setRelatebill1(String relatebill1) {
        this.relatebill1 = relatebill1;
        return this;
    }

    public Date getRequireArriveTime() {
        return requireArriveTime;
    }

    public Shipment setRequireArriveTime(Date requireArriveTime) {
        this.requireArriveTime = requireArriveTime;
        return this;
    }

    public Integer getShipmentMethod() {
        return shipmentMethod;
    }

    public Shipment setShipmentMethod(Integer shipmentMethod) {
        this.shipmentMethod = shipmentMethod;
        return this;
    }

    public String getTan() {
        return tan;
    }

    public Shipment setTan(String tan) {
        this.tan = tan;
        return this;
    }

    public Date getTime() {
        return time;
    }

    public Shipment setTime(Date time) {
        this.time = time;
        return this;
    }

    public Integer getTransportPro() {
        return transportPro;
    }

    public Shipment setTransportPro(Integer transportPro) {
        this.transportPro = transportPro;
        return this;
    }

    public Double getValue() {
        return value;
    }

    public Shipment setValue(Double value) {
        this.value = value;
        return this;
    }

    public Double getVolume() {
        return volume;
    }

    public Shipment setVolume(Double volume) {
        this.volume = volume;
        return this;
    }

    public Double getWeight() {
        return weight;
    }

    public Shipment setWeight(Double weight) {
        this.weight = weight;
        return this;
    }

    public String getJcCarrierId() {
        return jcCarrierId;
    }

    public Shipment setJcCarrierId(String jcCarrierId) {
        this.jcCarrierId = jcCarrierId;
        return this;
    }

    public String getJcDriverId() {
        return jcDriverId;
    }

    public Shipment setJcDriverId(String jcDriverId) {
        this.jcDriverId = jcDriverId;
        return this;
    }

    public String getJcOrganizationId() {
        return jcOrganizationId;
    }

    public Shipment setJcOrganizationId(String jcOrganizationId) {
        this.jcOrganizationId = jcOrganizationId;
        return this;
    }

    public String getJcSettlementId() {
        return jcSettlementId;
    }

    public Shipment setJcSettlementId(String jcSettlementId) {
        this.jcSettlementId = jcSettlementId;
        return this;
    }

    public String getJcVehicleId() {
        return jcVehicleId;
    }

    public Shipment setJcVehicleId(String jcVehicleId) {
        this.jcVehicleId = jcVehicleId;
        return this;
    }

    public String getJcVehicleHeadId() {
        return jcVehicleHeadId;
    }

    public Shipment setJcVehicleHeadId(String jcVehicleHeadId) {
        this.jcVehicleHeadId = jcVehicleHeadId;
        return this;
    }

    public Date getActionTime() {
        return actionTime;
    }

    public Shipment setActionTime(Date actionTime) {
        this.actionTime = actionTime;
        return this;
    }

    public String getJcFromOrganizationId() {
        return jcFromOrganizationId;
    }

    public Shipment setJcFromOrganizationId(String jcFromOrganizationId) {
        this.jcFromOrganizationId = jcFromOrganizationId;
        return this;
    }

    public String getJcNewOrganizationId() {
        return jcNewOrganizationId;
    }

    public Shipment setJcNewOrganizationId(String jcNewOrganizationId) {
        this.jcNewOrganizationId = jcNewOrganizationId;
        return this;
    }

    public String getJcNextOrganizationId() {
        return jcNextOrganizationId;
    }

    public Shipment setJcNextOrganizationId(String jcNextOrganizationId) {
        this.jcNextOrganizationId = jcNextOrganizationId;
        return this;
    }

    public String getJcToOrganizationId() {
        return jcToOrganizationId;
    }

    public Shipment setJcToOrganizationId(String jcToOrganizationId) {
        this.jcToOrganizationId = jcToOrganizationId;
        return this;
    }

    public String getOrgIds() {
        return orgIds;
    }

    public Shipment setOrgIds(String orgIds) {
        this.orgIds = orgIds;
        return this;
    }

    public String getOutIphpne() {
        return outIphpne;
    }

    public Shipment setOutIphpne(String outIphpne) {
        this.outIphpne = outIphpne;
        return this;
    }

    public String getOrgnameList() {
        return orgnameList;
    }

    public Shipment setOrgnameList(String orgnameList) {
        this.orgnameList = orgnameList;
        return this;
    }

    public Double getJzWeight() {
        return jzWeight;
    }

    public Shipment setJzWeight(Double jzWeight) {
        this.jzWeight = jzWeight;
        return this;
    }

    public Integer getIsInoutcome() {
        return isInoutcome;
    }

    public Shipment setIsInoutcome(Integer isInoutcome) {
        this.isInoutcome = isInoutcome;
        return this;
    }

    public String getJcRuleId() {
        return jcRuleId;
    }

    public Shipment setJcRuleId(String jcRuleId) {
        this.jcRuleId = jcRuleId;
        return this;
    }

    @Override
    public String toString() {
        return "Shipment{" +
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
        ", carriageIsExceed=" + carriageIsExceed +
        ", carrierType=" + carrierType +
        ", factArriveTime=" + factArriveTime +
        ", factLeaverTime=" + factLeaverTime +
        ", feeType=" + feeType +
        ", isAbnormal=" + isAbnormal +
        ", jsStatus=" + jsStatus +
        ", liense=" + liense +
        ", loadingInfo=" + loadingInfo +
        ", loadingMethod=" + loadingMethod +
        ", number=" + number +
        ", operationPattern=" + operationPattern +
        ", orderCode=" + orderCode +
        ", outDriver=" + outDriver +
        ", planLeaveTime=" + planLeaveTime +
        ", refuse=" + refuse +
        ", relatebill1=" + relatebill1 +
        ", requireArriveTime=" + requireArriveTime +
        ", shipmentMethod=" + shipmentMethod +
        ", tan=" + tan +
        ", time=" + time +
        ", transportPro=" + transportPro +
        ", value=" + value +
        ", volume=" + volume +
        ", weight=" + weight +
        ", jcCarrierId=" + jcCarrierId +
        ", jcDriverId=" + jcDriverId +
        ", jcOrganizationId=" + jcOrganizationId +
        ", jcSettlementId=" + jcSettlementId +
        ", jcVehicleId=" + jcVehicleId +
        ", jcVehicleHeadId=" + jcVehicleHeadId +
        ", actionTime=" + actionTime +
        ", jcFromOrganizationId=" + jcFromOrganizationId +
        ", jcNewOrganizationId=" + jcNewOrganizationId +
        ", jcNextOrganizationId=" + jcNextOrganizationId +
        ", jcToOrganizationId=" + jcToOrganizationId +
        ", orgIds=" + orgIds +
        ", outIphpne=" + outIphpne +
        ", orgnameList=" + orgnameList +
        ", jzWeight=" + jzWeight +
        ", isInoutcome=" + isInoutcome +
        ", jcRuleId=" + jcRuleId +
        "}";
    }
}
