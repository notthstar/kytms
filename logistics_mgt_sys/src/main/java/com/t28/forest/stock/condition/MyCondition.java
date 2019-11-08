/**
 * @description 条件类
 * @author HF
 * @create 2019/10/30
 * @since 1.0.0
 */
package com.t28.forest.stock.condition;

public class MyCondition {
     private Integer type;
     private String  id;

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "MyCondition{" +
                "type=" + type +
                ", id='" + id + '\'' +
                '}';
    }
}
