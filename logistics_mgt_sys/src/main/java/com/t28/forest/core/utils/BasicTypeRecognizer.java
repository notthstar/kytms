package com.t28.forest.core.utils;

/**
 * @author XiangYuFeng
 * @description 基本类型识别器
 * @create 2019/11/7
 * @since 1.0.0
 */
@Deprecated
public class BasicTypeRecognizer {

    private static final String STRING = "java.lang.String";
    private static final String DOUBLE = "java.lang.Double";
    private static final String INTEGER = "java.lang.Integer";
    private static final String DATE = "java.util.Date";
    private static final String BOOLEAN = "java.lang.Boolean";

    private BasicTypeRecognizer() {}

    /**
     * 是否是基本类型
     * @param object
     * @return boolean
     */
    public static boolean isBasicType(Object object) {
        String typeName = object.getClass().getTypeName();
        switch (typeName) {
            case STRING:
            case DOUBLE:
            case INTEGER:
            case DATE:
            case BOOLEAN:
                return true;
            default:
                return false;
        }
    }

}