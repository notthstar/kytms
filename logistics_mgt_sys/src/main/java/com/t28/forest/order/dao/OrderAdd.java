/**
 * @description 增加
 * @author lcy
 * @create 2019/11/1
 * @since 1.0.0
 */
package com.t28.forest.order.dao;

import com.t28.forest.core.entity.JcPresco;
import com.t28.forest.core.entity.JcReceivingparty;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

@Mapper
@Component
public interface OrderAdd {
     /**
      * 功能描述: 新增计划单
      * @param: No such property: code for class: Script1
      * @return:
      * @since: 1.0.0
      * @Author: lcy
      * @Date: 2019/11/5 9:00
      */
    void insertOrder(@Param("presco") JcPresco presco);

    /**
     * 功能描述: 新增里的收货方and发货方的增加收发货方
     * @param: No such property: code for class: Script1
     * @return: 
     * @since: 1.0.0
     * @Author: lcy
     * @Date: 2019/11/5 9:00
     */
    void insertReceiving(@Param("receivingparty") JcReceivingparty receivingparty);
}
