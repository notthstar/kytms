package com.t28.forest.core.utils;

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

}