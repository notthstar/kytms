/**
 * @description
 * @author lcy
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.order.dao;

import com.t28.forest.order.vo.ServerZone;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Component;

import java.util.List;
@Mapper
@Component
public interface BillAdd {

    /**
     * 功能描述: 新增订单管理的查询运点
     * @param: No such property: code for class: Script1
     * @return:
     * @since: 1.0.0
     * @Author: lcy
     * @Date: 2019/11/7 10:47
     */
    List<ServerZone> selectZone();


}
