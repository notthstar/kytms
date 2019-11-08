package com.t28.forest.core.utils;


import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializerFeature;

import java.lang.reflect.Field;
import java.util.Objects;

/**
 * @author XiangYuFeng
 * @description Java简单工具类
 * @create 2019/11/3
 * @since 1.0.0
 */
public class SimpleUtils {

    private SimpleUtils() {}

    /**
     * 生成唯一订单号的工具
     * @param prefix 订单前缀
     * @return java.lang.String
     */
    public static synchronized String generateUniqueCode(String prefix) {
        Long timestamp = System.currentTimeMillis();
        return prefix + timestamp.toString();
    }

    /**
     * Object对象转JSON数据的方法
     * @param obj
     * @return String
     */
    @Deprecated
    public static final String ObjectToJson(Object obj) throws IllegalAccessException {
        if (Objects.isNull(obj)) {return null;}

        if (BasicTypeRecognizer.isBasicType(obj)) {
            return "{\"status\":" + "\"" + obj.toString() + "\"}";
        }
        // 用于拼接JSON串的对象
        StringBuffer appendJson = new StringBuffer().append("{");
        // 获得所有属性
        Field[] fields = obj.getClass().getDeclaredFields();
        // 遍历类中的所有属性
        for (Field field : fields) {
            // 开启私有属性访问权限
            field.setAccessible(true);
            appendJson.append("\"" + field.getName() + "\":\"" + field.get(obj) + "\",");
        }
        // 去掉最后一个逗号
        String json = appendJson.substring(0, appendJson.lastIndexOf(","));
        json += "}";
        return json;
    }

    /**
     * Object转JSON方法
     * @param object
     * @return String
     */
    public static String objectToJSON(Object object) {
        return JSONObject.toJSONString(object, SerializerFeature.DisableCircularReferenceDetect);
    }

}