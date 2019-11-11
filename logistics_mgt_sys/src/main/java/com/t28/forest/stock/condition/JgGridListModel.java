package com.t28.forest.stock.condition;


import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;
import org.apache.log4j.Logger;

import java.util.List;

/**
 * 辽宁捷畅物流有限公司 -信息技术中心
 * JgGrid的返回参数
 * @author 臧英明
 * @create 2017-11-18
 */
public class JgGridListModel {
    /**对象数据*/
    private List rows;
    /**总页数*/
    private long total;
    /**当前在第几页*/
    private int page;
    /**总数据行数*/
    private long records;
    /**查询耗时*/
    private long costtime;

    private final Logger log = Logger.getLogger(JgGridListModel.class);//输出Log日志


    public List getRows() {
        return rows;
    }

    public void setRows(List rows) {
        this.rows = rows;
    }

    public long getTotal() {
        return total;
    }

    public void setTotal(long total) {
        this.total = total;
    }

    public int getPage() {
        return page;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public long getRecords() {
        return records;
    }

    public void setRecords(long records) {
        this.records = records;
    }

    public long getCosttime() {
        return costtime;
    }

    public void setCosttime(long costtime) {
        this.costtime = costtime;
    }

    /**
     * 序列化程JSON，并过滤掉循环引用
     * @return
     */
    public String toJSONString(){
        return JSONObject.toJSONString(this, SerializerFeature.DisableCircularReferenceDetect);
    }

}
