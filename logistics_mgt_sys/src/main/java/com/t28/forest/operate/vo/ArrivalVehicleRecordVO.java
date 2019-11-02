package com.t28.forest.operate.vo;

import java.util.Date;

/**
 * @author XiangYuFeng
 * @description 到货车辆记录页面展示对象
 * @create 2019/11/2
 * @since 1.0.0
 */
public class ArrivalVehicleRecordVO {
    /**
     * 唯一ID标识
     */
    private String id;
    /**
     * 所属机构组织
     */
    private String name;
    /**
     * 运单号
     */
    private String code;
    /**
     * 运单日期
     */
    private Date time;
    /**
     * 出发站点
     */
    private String organName1;
    /**
     * 当前站
     */
    private String organName2;
    /**
     * 下一站
     */
    private String organName3;
    /**
     * 目的站点
     */
    private String organName4;
    /**
     *订单号
     */
    private String orderCode;
    /**
     * 客户订单号
     */
    private String relateBill;
    /**
     * 状态
     */
    private Integer status;
    /**
     * 运作模式
     */
    private Integer operationPattern;
    /**
     * 承运商名称
     */
    private String carName;
    /**
     * 承运商类型
     */
    private Integer carrierType;
    /**
     * 车牌号
     */
    private String liens;
    /**
     * 司机名称
     */
    private String outDriver;
    /**
     * 是否超时
     */
    private Integer carriageIsExceed;
    /**
     * 运输协议号
     */
    private String tan;
    /**
     * 数量
     */
    private Integer number;
    /**
     * 重量
     */
    private Double weight;
    /**
     * 体积
     */
    private Double volume;
    /**
     * 货值
     */
    private Double value;
    /**
     * 创建人
     */
    private String createName;
    /**
     * 创建时间
     */
    private Date createTime;
    /**
     * 修改人
     */
    private String modifyName;
    /**
     * 修改时间
     */
    private Date modifyTime;
    /**
     * 是否有异常
     */
    private Integer isAbnormal;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public String getOrganName1() {
        return organName1;
    }

    public void setOrganName1(String organName1) {
        this.organName1 = organName1;
    }

    public String getOrganName2() {
        return organName2;
    }

    public void setOrganName2(String organName2) {
        this.organName2 = organName2;
    }

    public String getOrganName3() {
        return organName3;
    }

    public void setOrganName3(String organName3) {
        this.organName3 = organName3;
    }

    public String getOrganName4() {
        return organName4;
    }

    public void setOrganName4(String organName4) {
        this.organName4 = organName4;
    }

    public String getOrderCode() {
        return orderCode;
    }

    public void setOrderCode(String orderCode) {
        this.orderCode = orderCode;
    }

    public String getRelateBill() {
        return relateBill;
    }

    public void setRelateBill(String relateBill) {
        this.relateBill = relateBill;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getOperationPattern() {
        return operationPattern;
    }

    public void setOperationPattern(Integer operationPattern) {
        this.operationPattern = operationPattern;
    }

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public Integer getCarrierType() {
        return carrierType;
    }

    public void setCarrierType(Integer carrierType) {
        this.carrierType = carrierType;
    }

    public String getLiens() {
        return liens;
    }

    public void setLiens(String liens) {
        this.liens = liens;
    }

    public String getOutDriver() {
        return outDriver;
    }

    public void setOutDriver(String outDriver) {
        this.outDriver = outDriver;
    }

    public Integer getCarriageIsExceed() {
        return carriageIsExceed;
    }

    public void setCarriageIsExceed(Integer carriageIsExceed) {
        this.carriageIsExceed = carriageIsExceed;
    }

    public String getTan() {
        return tan;
    }

    public void setTan(String tan) {
        this.tan = tan;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Double getWeight() {
        return weight;
    }

    public void setWeight(Double weight) {
        this.weight = weight;
    }

    public Double getVolume() {
        return volume;
    }

    public void setVolume(Double volume) {
        this.volume = volume;
    }

    public Double getValue() {
        return value;
    }

    public void setValue(Double value) {
        this.value = value;
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

    public Integer getIsAbnormal() {
        return isAbnormal;
    }

    public void setIsAbnormal(Integer isAbnormal) {
        this.isAbnormal = isAbnormal;
    }

    @Override
    public String toString() {
        return "ArrivalVehicleRecordVO{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", code='" + code + '\'' +
                ", time=" + time +
                ", organName1='" + organName1 + '\'' +
                ", organName2='" + organName2 + '\'' +
                ", organName3='" + organName3 + '\'' +
                ", organName4='" + organName4 + '\'' +
                ", orderCode='" + orderCode + '\'' +
                ", relateBill='" + relateBill + '\'' +
                ", status=" + status +
                ", operationPattern=" + operationPattern +
                ", carName='" + carName + '\'' +
                ", carrierType=" + carrierType +
                ", liens='" + liens + '\'' +
                ", outDriver='" + outDriver + '\'' +
                ", carriageIsExceed=" + carriageIsExceed +
                ", tan='" + tan + '\'' +
                ", number=" + number +
                ", weight=" + weight +
                ", volume=" + volume +
                ", value=" + value +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                ", isAbnormal=" + isAbnormal +
                '}';
    }
}