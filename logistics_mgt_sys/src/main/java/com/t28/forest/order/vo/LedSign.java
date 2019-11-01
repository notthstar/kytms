/**
 * @description 订单签收
 * @author lcy
 * @create 2019/11/1
 * @since 1.0.0
 */
package com.t28.forest.order.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;

import java.sql.Date;

public class LedSign {

    @TableId(value = "ID", type = IdType.AUTO)
    private String id;

    private String organizationName;

    @TableField("CODE")
    private String code;

    @TableField("TIME")
    private Date time;

    @TableField("RELATEBILL1")
    private String relatebill1;

    @TableField("COSTOMER_TYPE")
    private Integer costomerType;

    private String ledreceiviName;

    @TableField("STATUS")
    private Integer status;

    @TableField("COSTOMER_IS_EXCEED")
    private Integer costomerIsExceed;

    @TableField("TRANSPORT_PRO")
    private Integer transportPro;

    @TableField("IS_BACK")
    private Integer isBack;

    @TableField("BACK_NUMBER")
    private Integer backNumber;

    @TableField("NUMBER")
    private Integer number;

    @TableField("WEIGHT")
    private Double weight;

    @TableField("VOLUME")
    private Double volume;

    @TableField("SALE_PERSION")
    private String salePersion;

    @TableField("DESCRIPTION")
    private String description;

    @TableField("CREATE_NAME")
    private String createName;

    @TableField("CREATE_TIME")
    private Date createTime;

    @TableField("MODIFY_NAME")
    private String modifyName;

    @TableField("MODIFY_TIME")
    private Date modifyTime;


}
