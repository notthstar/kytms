package com.t28.forest.operate.dao;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.WayBillTranckVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 运单跟踪DAO层接口
 * @create 2019/10/31
 * @since 1.0.0
 */
@Repository
public interface WaybillTrackDao {

    /**
     * 分页条件查询运单跟踪的信息
     * @param pageVO
     * @param condition
     * @return List<WayBillTranckVO>
     */
    public List<WayBillTranckVO> findWayBillByPage(@Param("page") PageVO pageVO, @Param("condition") Condition condition);

    /**
     * 根据条件查询运单跟踪数据条数信息
     * @param condition
     * @return Integer
     */
    public Integer findWayBillCount(@Param("condition") Condition condition);

}
