package com.t28.forest.core.cond;


/**
 * @author XiangYuFeng
 * @description 查询条件封装
 * @create 2019/10/30
 * @since 1.0.0
 */
public class Condition {
    /**
     * 条件名称
     */
    private String name;
    /**
     * 条件值
     */
    private Object[] values;
    /**
     * 主键ID
     */
    private String id;

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

    public Object[] getValues() {
        return values;
    }

    public void setValues(Object[] values) {
        this.values = values;
    }
}