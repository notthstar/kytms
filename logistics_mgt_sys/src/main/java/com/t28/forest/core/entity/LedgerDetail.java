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
public class LedgerDetail implements Serializable {

    private static final long serialVersionUID=1L;

    @TableId(value = "ID", type = IdType.INPUT)
    private String id;

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

    @TableField("AMOUNT")
    private Double amount;

    @TableField("EXPLAIN1")
    private String explain1;

    @TableField("EXPLAIN2")
    private String explain2;

    @TableField("EXPLAIN3")
    private String explain3;

    @TableField("INPUT")
    private Double input;

    @TableField("OCCURRENCE_TIME")
    private String occurrenceTime;

    @TableField("TAXRATE")
    private Double taxrate;

    @TableField("JC_FEE_TYPE_ID")
    private String jcFeeTypeId;

    @TableField("JC_LEDGER_ID")
    private String jcLedgerId;

    @TableField("COST")
    private Integer cost;

    @TableField("TYPE")
    private Integer type;

    @TableField("JC_ORDER_ID")
    private String jcOrderId;

    @TableField("JC_PRESCO_ID")
    private String jcPrescoId;

    @TableField("JC_SHIPMENT_ID")
    private String jcShipmentId;

    @TableField("JC_SINGLE_ID")
    private String jcSingleId;

    @TableField("JC_FEE_SEED_ID")
    private String jcFeeSeedId;

    @TableField("JC_OTHERFEE_ID")
    private String jcOtherfeeId;

    @TableField("ARRIVE_PAY")
    private Double arrivePay;

    @TableField("BACK_PAY")
    private Double backPay;

    @TableField("HXMONEY")
    private Double hxmoney;

    @TableField("MONTY_PAY")
    private Double montyPay;

    @TableField("NOW_PAY")
    private Double nowPay;

    @TableField("WHMONEY")
    private Double whmoney;

    @TableField("CASH_ADVANCES")
    private Double cashAdvances;

    @TableField("OIL_PREPAID")
    private Double oilPrepaid;

    @TableField("YU_E")
    private Double yuE;

    @TableField("Z_FY")
    private Double zFy;

    @TableField("Z_GXYF")
    private Double zGxyf;

    @TableField("Z_QTFY")
    private Double zQtfy;

    @TableField("Z_SHF")
    private Double zShf;

    @TableField("Z_THF")
    private Double zThf;

    @TableField("YAJIN")
    private Double yajin;

    @TableField("YF_YOUKA")
    private Double yfYouka;

    @TableField("AFFIRM_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date affirmTime;

    @TableField("COLLECT_METHOD")
    private String collectMethod;

    @TableField("INCOME")
    private Double income;

    @TableField("IS_INOUTCOME")
    private Integer isInoutcome;

    @TableField("OUTCOME")
    private Double outcome;

    @TableField("PAY_METHOD")
    private String payMethod;

    @TableField("SETTLEMENT_METHOD")
    private String settlementMethod;

    @TableField("JC_CARRIER_ID")
    private String jcCarrierId;

    @TableField("JC_SHIPMENT_TEMPLATE_ID")
    private String jcShipmentTemplateId;


    public String getId() {
        return id;
    }

    public LedgerDetail setId(String id) {
        this.id = id;
        return this;
    }

    public String getCreateName() {
        return createName;
    }

    public LedgerDetail setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public LedgerDetail setCreateTime(Date createTime) {
        this.createTime = createTime;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public LedgerDetail setDescription(String description) {
        this.description = description;
        return this;
    }

    public String getField1() {
        return field1;
    }

    public LedgerDetail setField1(String field1) {
        this.field1 = field1;
        return this;
    }

    public String getField2() {
        return field2;
    }

    public LedgerDetail setField2(String field2) {
        this.field2 = field2;
        return this;
    }

    public String getField3() {
        return field3;
    }

    public LedgerDetail setField3(String field3) {
        this.field3 = field3;
        return this;
    }

    public String getModifyName() {
        return modifyName;
    }

    public LedgerDetail setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public LedgerDetail setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
        return this;
    }

    public String getName() {
        return name;
    }

    public LedgerDetail setName(String name) {
        this.name = name;
        return this;
    }

    public Integer getStatus() {
        return status;
    }

    public LedgerDetail setStatus(Integer status) {
        this.status = status;
        return this;
    }

    public Double getAmount() {
        return amount;
    }

    public LedgerDetail setAmount(Double amount) {
        this.amount = amount;
        return this;
    }

    public String getExplain1() {
        return explain1;
    }

    public LedgerDetail setExplain1(String explain1) {
        this.explain1 = explain1;
        return this;
    }

    public String getExplain2() {
        return explain2;
    }

    public LedgerDetail setExplain2(String explain2) {
        this.explain2 = explain2;
        return this;
    }

    public String getExplain3() {
        return explain3;
    }

    public LedgerDetail setExplain3(String explain3) {
        this.explain3 = explain3;
        return this;
    }

    public Double getInput() {
        return input;
    }

    public LedgerDetail setInput(Double input) {
        this.input = input;
        return this;
    }

    public String getOccurrenceTime() {
        return occurrenceTime;
    }

    public LedgerDetail setOccurrenceTime(String occurrenceTime) {
        this.occurrenceTime = occurrenceTime;
        return this;
    }

    public Double getTaxrate() {
        return taxrate;
    }

    public LedgerDetail setTaxrate(Double taxrate) {
        this.taxrate = taxrate;
        return this;
    }

    public String getJcFeeTypeId() {
        return jcFeeTypeId;
    }

    public LedgerDetail setJcFeeTypeId(String jcFeeTypeId) {
        this.jcFeeTypeId = jcFeeTypeId;
        return this;
    }

    public String getJcLedgerId() {
        return jcLedgerId;
    }

    public LedgerDetail setJcLedgerId(String jcLedgerId) {
        this.jcLedgerId = jcLedgerId;
        return this;
    }

    public Integer getCost() {
        return cost;
    }

    public LedgerDetail setCost(Integer cost) {
        this.cost = cost;
        return this;
    }

    public Integer getType() {
        return type;
    }

    public LedgerDetail setType(Integer type) {
        this.type = type;
        return this;
    }

    public String getJcOrderId() {
        return jcOrderId;
    }

    public LedgerDetail setJcOrderId(String jcOrderId) {
        this.jcOrderId = jcOrderId;
        return this;
    }

    public String getJcPrescoId() {
        return jcPrescoId;
    }

    public LedgerDetail setJcPrescoId(String jcPrescoId) {
        this.jcPrescoId = jcPrescoId;
        return this;
    }

    public String getJcShipmentId() {
        return jcShipmentId;
    }

    public LedgerDetail setJcShipmentId(String jcShipmentId) {
        this.jcShipmentId = jcShipmentId;
        return this;
    }

    public String getJcSingleId() {
        return jcSingleId;
    }

    public LedgerDetail setJcSingleId(String jcSingleId) {
        this.jcSingleId = jcSingleId;
        return this;
    }

    public String getJcFeeSeedId() {
        return jcFeeSeedId;
    }

    public LedgerDetail setJcFeeSeedId(String jcFeeSeedId) {
        this.jcFeeSeedId = jcFeeSeedId;
        return this;
    }

    public String getJcOtherfeeId() {
        return jcOtherfeeId;
    }

    public LedgerDetail setJcOtherfeeId(String jcOtherfeeId) {
        this.jcOtherfeeId = jcOtherfeeId;
        return this;
    }

    public Double getArrivePay() {
        return arrivePay;
    }

    public LedgerDetail setArrivePay(Double arrivePay) {
        this.arrivePay = arrivePay;
        return this;
    }

    public Double getBackPay() {
        return backPay;
    }

    public LedgerDetail setBackPay(Double backPay) {
        this.backPay = backPay;
        return this;
    }

    public Double getHxmoney() {
        return hxmoney;
    }

    public LedgerDetail setHxmoney(Double hxmoney) {
        this.hxmoney = hxmoney;
        return this;
    }

    public Double getMontyPay() {
        return montyPay;
    }

    public LedgerDetail setMontyPay(Double montyPay) {
        this.montyPay = montyPay;
        return this;
    }

    public Double getNowPay() {
        return nowPay;
    }

    public LedgerDetail setNowPay(Double nowPay) {
        this.nowPay = nowPay;
        return this;
    }

    public Double getWhmoney() {
        return whmoney;
    }

    public LedgerDetail setWhmoney(Double whmoney) {
        this.whmoney = whmoney;
        return this;
    }

    public Double getCashAdvances() {
        return cashAdvances;
    }

    public LedgerDetail setCashAdvances(Double cashAdvances) {
        this.cashAdvances = cashAdvances;
        return this;
    }

    public Double getOilPrepaid() {
        return oilPrepaid;
    }

    public LedgerDetail setOilPrepaid(Double oilPrepaid) {
        this.oilPrepaid = oilPrepaid;
        return this;
    }

    public Double getYuE() {
        return yuE;
    }

    public LedgerDetail setYuE(Double yuE) {
        this.yuE = yuE;
        return this;
    }

    public Double getzFy() {
        return zFy;
    }

    public LedgerDetail setzFy(Double zFy) {
        this.zFy = zFy;
        return this;
    }

    public Double getzGxyf() {
        return zGxyf;
    }

    public LedgerDetail setzGxyf(Double zGxyf) {
        this.zGxyf = zGxyf;
        return this;
    }

    public Double getzQtfy() {
        return zQtfy;
    }

    public LedgerDetail setzQtfy(Double zQtfy) {
        this.zQtfy = zQtfy;
        return this;
    }

    public Double getzShf() {
        return zShf;
    }

    public LedgerDetail setzShf(Double zShf) {
        this.zShf = zShf;
        return this;
    }

    public Double getzThf() {
        return zThf;
    }

    public LedgerDetail setzThf(Double zThf) {
        this.zThf = zThf;
        return this;
    }

    public Double getYajin() {
        return yajin;
    }

    public LedgerDetail setYajin(Double yajin) {
        this.yajin = yajin;
        return this;
    }

    public Double getYfYouka() {
        return yfYouka;
    }

    public LedgerDetail setYfYouka(Double yfYouka) {
        this.yfYouka = yfYouka;
        return this;
    }

    public Date getAffirmTime() {
        return affirmTime;
    }

    public LedgerDetail setAffirmTime(Date affirmTime) {
        this.affirmTime = affirmTime;
        return this;
    }

    public String getCollectMethod() {
        return collectMethod;
    }

    public LedgerDetail setCollectMethod(String collectMethod) {
        this.collectMethod = collectMethod;
        return this;
    }

    public Double getIncome() {
        return income;
    }

    public LedgerDetail setIncome(Double income) {
        this.income = income;
        return this;
    }

    public Integer getIsInoutcome() {
        return isInoutcome;
    }

    public LedgerDetail setIsInoutcome(Integer isInoutcome) {
        this.isInoutcome = isInoutcome;
        return this;
    }

    public Double getOutcome() {
        return outcome;
    }

    public LedgerDetail setOutcome(Double outcome) {
        this.outcome = outcome;
        return this;
    }

    public String getPayMethod() {
        return payMethod;
    }

    public LedgerDetail setPayMethod(String payMethod) {
        this.payMethod = payMethod;
        return this;
    }

    public String getSettlementMethod() {
        return settlementMethod;
    }

    public LedgerDetail setSettlementMethod(String settlementMethod) {
        this.settlementMethod = settlementMethod;
        return this;
    }

    public String getJcCarrierId() {
        return jcCarrierId;
    }

    public LedgerDetail setJcCarrierId(String jcCarrierId) {
        this.jcCarrierId = jcCarrierId;
        return this;
    }

    public String getJcShipmentTemplateId() {
        return jcShipmentTemplateId;
    }

    public LedgerDetail setJcShipmentTemplateId(String jcShipmentTemplateId) {
        this.jcShipmentTemplateId = jcShipmentTemplateId;
        return this;
    }

    @Override
    public String toString() {
        return "LedgerDetail{" +
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
        ", amount=" + amount +
        ", explain1=" + explain1 +
        ", explain2=" + explain2 +
        ", explain3=" + explain3 +
        ", input=" + input +
        ", occurrenceTime=" + occurrenceTime +
        ", taxrate=" + taxrate +
        ", jcFeeTypeId=" + jcFeeTypeId +
        ", jcLedgerId=" + jcLedgerId +
        ", cost=" + cost +
        ", type=" + type +
        ", jcOrderId=" + jcOrderId +
        ", jcPrescoId=" + jcPrescoId +
        ", jcShipmentId=" + jcShipmentId +
        ", jcSingleId=" + jcSingleId +
        ", jcFeeSeedId=" + jcFeeSeedId +
        ", jcOtherfeeId=" + jcOtherfeeId +
        ", arrivePay=" + arrivePay +
        ", backPay=" + backPay +
        ", hxmoney=" + hxmoney +
        ", montyPay=" + montyPay +
        ", nowPay=" + nowPay +
        ", whmoney=" + whmoney +
        ", cashAdvances=" + cashAdvances +
        ", oilPrepaid=" + oilPrepaid +
        ", yuE=" + yuE +
        ", zFy=" + zFy +
        ", zGxyf=" + zGxyf +
        ", zQtfy=" + zQtfy +
        ", zShf=" + zShf +
        ", zThf=" + zThf +
        ", yajin=" + yajin +
        ", yfYouka=" + yfYouka +
        ", affirmTime=" + affirmTime +
        ", collectMethod=" + collectMethod +
        ", income=" + income +
        ", isInoutcome=" + isInoutcome +
        ", outcome=" + outcome +
        ", payMethod=" + payMethod +
        ", settlementMethod=" + settlementMethod +
        ", jcCarrierId=" + jcCarrierId +
        ", jcShipmentTemplateId=" + jcShipmentTemplateId +
        "}";
    }
}
