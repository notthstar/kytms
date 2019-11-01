/**
 * @description
 * @author lcy
 * @create 2019/10/30
 * @since 1.0.0
 */
package com.t28.forest.order.dao;

import com.t28.forest.order.vo.order;
import com.t28.forest.order.vo.presco;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Mapper
@Component
public interface OrderDao {

       /**
        *获取计划单
        */
       List<presco> planned(@Param("rc")String rc,@Param("input")Object input);

      /**
       *获取订单管理
       */
      List<order> orders(@Param("rc")String rc, @Param("input")Object input);

}
