package com.t28.forest.operate.dao;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.VehicleArrivalVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 车辆到站DAO层接口
 * @create 2019/10/31
 * @since 1.0.0
 */
@Repository
public interface VehicleArrivalDao {

    /**
     * 分页条件查询到站车辆信息
     * @param pageVO
     * @param condition
     * @return List<VehicleArrivalVO>
     */
    public List<VehicleArrivalVO> findVehicleArrivalByPage(@Param("page") PageVO pageVO, @Param("condition") Condition condition);

    /**
     * 通过条件查询数据条数
     * @param condition
     * @return Integer
     */
    public Integer findVehicleArrivalCount(@Param("condition") Condition condition);
}
