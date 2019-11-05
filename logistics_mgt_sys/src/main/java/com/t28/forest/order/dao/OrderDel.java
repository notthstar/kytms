/**
 * @description
 * @author lcy
 * @create 2019/11/5
 * @since 1.0.0
 */
package com.t28.forest.order.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

@Mapper
@Component
public interface OrderDel {
     /**
      * 功能描述: 逻辑删除计划单
      * @param: No such property: code for class: Script1
      * @return: 
      * @since: 1.0.0
      * @Author: lcy
      * @Date: 2019/11/5 9:37
      */
     void deletePlan(@Param("id") String id);

    /**
     * 功能描述: 逻辑删除收发货方
     * @param: No such property: code for class: Script1
     * @return:
     * @since: 1.0.0
     * @Author: lcy
     * @Date: 2019/11/5 9:37
     */
    void deleteSFh(@Param("id") String id);


}
