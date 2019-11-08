/**
 * @description 出入库记录显示页面数据传输对象
 * @author HF
 * @create 2019/11/1
 * @since 1.0.0
 */
package com.t28.forest.stock.vo;

import java.util.Date;

public class InOutRecordsVO {
    private String id;
    /**
     * id
     */
    private String distributing;
    /**
     * 组织机构
     */
    private String  name;
    /**
     *库位名称
     */
    private String  code;
    /**
     *分段订单号
     */
    private Integer  type;
    /**
     * 出入库标志
     */
    private Date  time;
    /**
     *时间
     */
    private Integer  number;
    /**
     *数量
     */
    private Integer  volume;
    /**
     *体积
     */
    private Integer  weight;
    /**
     *重量
     */
    private String  description;
    /**
     *备注
     */
    private String  createName;
    /**
     *创建人
     */
    private Date  createTime;
    /**
     *创建时间
     */
    private String  modifyName;
    /**
     *修改人
     */
    private Date  modifyTime;
    /**
     *修改时间
     */

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDistributing() {
        return distributing;
    }

    public void setDistributing(String distributing) {
        this.distributing = distributing;
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

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Integer getVolume() {
        return volume;
    }

    public void setVolume(Integer volume) {
        this.volume = volume;
    }

    public Integer getWeight() {
        return weight;
    }

    public void setWeight(Integer weight) {
        this.weight = weight;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
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

    @Override
    public String toString() {
        return "InOutRecordsVO{" +
                "id='" + id + '\'' +
                ", distributing='" + distributing + '\'' +
                ", name='" + name + '\'' +
                ", code='" + code + '\'' +
                ", type=" + type +
                ", time=" + time +
                ", number=" + number +
                ", volume=" + volume +
                ", weight=" + weight +
                ", description='" + description + '\'' +
                ", createName='" + createName + '\'' +
                ", createTime=" + createTime +
                ", modifyName='" + modifyName + '\'' +
                ", modifyTime=" + modifyTime +
                '}';
    }
}
