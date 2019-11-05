package com.t28.forest.core.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 
 * </p>
 *
 * @author lcy
 * @since 2019-10-31
 */
@TableName("jc_presco")
public class JcPresco implements Serializable {

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

    @TableField("NAME")
    private String name;

    @TableField("STATUS")
    private Integer status;

    @TableField("ADDRESS")
    private String address;

    @TableField("COSTOMER_TPYE")
    private Integer costomerTpye;

    @TableField("DATE_ACCEPTED")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date dateAccepted;

    @TableField("PICK_MILEAGE")
    private Double pickMileage;

    @TableField("JC_SINGLE_ID")
    private String jcSingleId;

    @TableField("JC_ORGANIZATION_ID")
    private String jcOrganizationId;

    @TableField("COSTOMER_NAME_LS")
    private String costomerNameLs;

    @TableField("JC_COSTOMER_ID")
    private String jcCostomerId;

    @TableField("COSTOMER_NAME")
    private String costomerName;

    @TableField("FH_ADDRESS")
    private String fhAddress;

    @TableField("FH_IPHONE")
    private String fhIphone;

    @TableField("FH_LTL")
    private String fhLtl;

    @TableField("FH_NAME")
    private String fhName;

    @TableField("FH_PERSON")
    private String fhPerson;

    @TableField("SH_ADDRESS")
    private String shAddress;

    @TableField("SH_IPHONE")
    private String shIphone;

    @TableField("SH_LTL")
    private String shLtl;

    @TableField("SH_NAME")
    private String shName;

    @TableField("SH_PERSON")
    private String shPerson;

    @TableField("RELATEBILL1")
    private String relatebill1;

    @TableField("JC_SERVER_ZONE_ID")
    private String jcServerZoneId;

    @TableField("CONTACTPERSON")
    private String contactperson;

    @TableField("IPHONE")
    private String iphone;

    @TableField("FH_DETAILEADDRESS")
    private String fhDetaileaddress;

    @TableField("SH_DETAILEADDRESS")
    private String shDetaileaddress;

    @TableField("JZ_WEIGHT")
    private Double jzWeight;

    @TableField("NUMBER")
    private Integer number;

    @TableField("VALUE")
    private Double value;

    @TableField("VOLUME")
    private Double volume;

    @TableField("WEIGHT")
    private Double weight;

    @TableField("JC_ORDER_ID")
    private String jcOrderId;

    @TableField("MODIFY_NAME")
    private String modifyName;

    @TableField("MODIFY_TIME")
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    @JsonFormat(
            pattern = "yyyy-MM-dd HH:mm:ss",
            timezone = "GMT+8"
    )
    private Date modifyTime;


    public String getId() {
        return id;
    }

    public JcPresco setId(String id) {
        this.id = id;
        return this;
    }
    public String getCode() {
        return code;
    }

    public JcPresco setCode(String code) {
        this.code = code;
        return this;
    }
    public String getCreateName() {
        return createName;
    }

    public JcPresco setCreateName(String createName) {
        this.createName = createName;
        return this;
    }

    public String getDescription() {
        return description;
    }

    public JcPresco setDescription(String description) {
        this.description = description;
        return this;
    }
    public String getField1() {
        return field1;
    }

    public JcPresco setField1(String field1) {
        this.field1 = field1;
        return this;
    }
    public String getField2() {
        return field2;
    }

    public JcPresco setField2(String field2) {
        this.field2 = field2;
        return this;
    }
    public String getField3() {
        return field3;
    }

    public JcPresco setField3(String field3) {
        this.field3 = field3;
        return this;
    }
    public String getModifyName() {
        return modifyName;
    }

    public JcPresco setModifyName(String modifyName) {
        this.modifyName = modifyName;
        return this;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public JcPresco() {
        super();
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

    public void setDateAccepted(Date dateAccepted) {
        this.dateAccepted = dateAccepted;
    }

    public String getName() {
        return name;
    }

    public JcPresco setName(String name) {
        this.name = name;
        return this;
    }
    public Integer getStatus() {
        return status;
    }

    public JcPresco setStatus(Integer status) {
        this.status = status;
        return this;
    }
    public String getAddress() {
        return address;
    }

    public JcPresco setAddress(String address) {
        this.address = address;
        return this;
    }
    public Integer getCostomerTpye() {
        return costomerTpye;
    }

    public JcPresco setCostomerTpye(Integer costomerTpye) {
        this.costomerTpye = costomerTpye;
        return this;
    }

    public Date getDateAccepted() {
        return dateAccepted;
    }

    public Double getPickMileage() {
        return pickMileage;
    }

    public void setPickMileage(Double pickMileage) {
        this.pickMileage = pickMileage;
    }

    public String getJcSingleId() {
        return jcSingleId;
    }

    public JcPresco setJcSingleId(String jcSingleId) {
        this.jcSingleId = jcSingleId;
        return this;
    }
    public String getJcOrganizationId() {
        return jcOrganizationId;
    }

    public JcPresco setJcOrganizationId(String jcOrganizationId) {
        this.jcOrganizationId = jcOrganizationId;
        return this;
    }
    public String getCostomerNameLs() {
        return costomerNameLs;
    }

    public JcPresco setCostomerNameLs(String costomerNameLs) {
        this.costomerNameLs = costomerNameLs;
        return this;
    }
    public String getJcCostomerId() {
        return jcCostomerId;
    }

    public JcPresco setJcCostomerId(String jcCostomerId) {
        this.jcCostomerId = jcCostomerId;
        return this;
    }
    public String getCostomerName() {
        return costomerName;
    }

    public JcPresco setCostomerName(String costomerName) {
        this.costomerName = costomerName;
        return this;
    }
    public String getFhAddress() {
        return fhAddress;
    }

    public JcPresco setFhAddress(String fhAddress) {
        this.fhAddress = fhAddress;
        return this;
    }
    public String getFhIphone() {
        return fhIphone;
    }

    public JcPresco setFhIphone(String fhIphone) {
        this.fhIphone = fhIphone;
        return this;
    }
    public String getFhLtl() {
        return fhLtl;
    }

    public JcPresco setFhLtl(String fhLtl) {
        this.fhLtl = fhLtl;
        return this;
    }
    public String getFhName() {
        return fhName;
    }

    public JcPresco setFhName(String fhName) {
        this.fhName = fhName;
        return this;
    }
    public String getFhPerson() {
        return fhPerson;
    }

    public JcPresco setFhPerson(String fhPerson) {
        this.fhPerson = fhPerson;
        return this;
    }
    public String getShAddress() {
        return shAddress;
    }

    public JcPresco setShAddress(String shAddress) {
        this.shAddress = shAddress;
        return this;
    }
    public String getShIphone() {
        return shIphone;
    }

    public JcPresco setShIphone(String shIphone) {
        this.shIphone = shIphone;
        return this;
    }
    public String getShLtl() {
        return shLtl;
    }

    public JcPresco setShLtl(String shLtl) {
        this.shLtl = shLtl;
        return this;
    }
    public String getShName() {
        return shName;
    }

    public JcPresco setShName(String shName) {
        this.shName = shName;
        return this;
    }
    public String getShPerson() {
        return shPerson;
    }

    public JcPresco setShPerson(String shPerson) {
        this.shPerson = shPerson;
        return this;
    }
    public String getRelatebill1() {
        return relatebill1;
    }

    public JcPresco setRelatebill1(String relatebill1) {
        this.relatebill1 = relatebill1;
        return this;
    }
    public String getJcServerZoneId() {
        return jcServerZoneId;
    }

    public JcPresco setJcServerZoneId(String jcServerZoneId) {
        this.jcServerZoneId = jcServerZoneId;
        return this;
    }
    public String getContactperson() {
        return contactperson;
    }

    public JcPresco setContactperson(String contactperson) {
        this.contactperson = contactperson;
        return this;
    }
    public String getIphone() {
        return iphone;
    }

    public JcPresco setIphone(String iphone) {
        this.iphone = iphone;
        return this;
    }
    public String getFhDetaileaddress() {
        return fhDetaileaddress;
    }

    public JcPresco setFhDetaileaddress(String fhDetaileaddress) {
        this.fhDetaileaddress = fhDetaileaddress;
        return this;
    }
    public String getShDetaileaddress() {
        return shDetaileaddress;
    }

    public JcPresco setShDetaileaddress(String shDetaileaddress) {
        this.shDetaileaddress = shDetaileaddress;
        return this;
    }
    public Double getJzWeight() {
        return jzWeight;
    }

    public JcPresco setJzWeight(Double jzWeight) {
        this.jzWeight = jzWeight;
        return this;
    }
    public Integer getNumber() {
        return number;
    }

    public JcPresco setNumber(Integer number) {
        this.number = number;
        return this;
    }
    public Double getValue() {
        return value;
    }

    public JcPresco setValue(Double value) {
        this.value = value;
        return this;
    }
    public Double getVolume() {
        return volume;
    }

    public JcPresco setVolume(Double volume) {
        this.volume = volume;
        return this;
    }
    public Double getWeight() {
        return weight;
    }

    public JcPresco setWeight(Double weight) {
        this.weight = weight;
        return this;
    }
    public String getJcOrderId() {
        return jcOrderId;
    }

    public JcPresco setJcOrderId(String jcOrderId) {
        this.jcOrderId = jcOrderId;
        return this;
    }

    @Override
    public String toString() {
        return "JcPresco{" +
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
            ", address=" + address +
            ", costomerTpye=" + costomerTpye +
            ", dateAccepted=" + dateAccepted +
            ", pickMileage=" + pickMileage +
            ", jcSingleId=" + jcSingleId +
            ", jcOrganizationId=" + jcOrganizationId +
            ", costomerNameLs=" + costomerNameLs +
            ", jcCostomerId=" + jcCostomerId +
            ", costomerName=" + costomerName +
            ", fhAddress=" + fhAddress +
            ", fhIphone=" + fhIphone +
            ", fhLtl=" + fhLtl +
            ", fhName=" + fhName +
            ", fhPerson=" + fhPerson +
            ", shAddress=" + shAddress +
            ", shIphone=" + shIphone +
            ", shLtl=" + shLtl +
            ", shName=" + shName +
            ", shPerson=" + shPerson +
            ", relatebill1=" + relatebill1 +
            ", jcServerZoneId=" + jcServerZoneId +
            ", contactperson=" + contactperson +
            ", iphone=" + iphone +
            ", fhDetaileaddress=" + fhDetaileaddress +
            ", shDetaileaddress=" + shDetaileaddress +
            ", jzWeight=" + jzWeight +
            ", number=" + number +
            ", value=" + value +
            ", volume=" + volume +
            ", weight=" + weight +
            ", jcOrderId=" + jcOrderId +
        "}";
    }
}
