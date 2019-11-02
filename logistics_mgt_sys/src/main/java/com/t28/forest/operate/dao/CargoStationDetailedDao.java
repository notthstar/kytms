package com.t28.forest.operate.dao;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.CargoStationDetailedVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 货物到站右侧详情DAO层接口
 * @create 2019/11/2
 * @since 1.0.0
 */
@Repository
public interface CargoStationDetailedDao {

    /**
     * 分页条件查询货物到站右侧详情信息
     * @param pageVO
     * @param condition
     * @return List<CargoStationDetailedVO>
     */
    public List<CargoStationDetailedVO> findCargoStationDetailedByPage(@Param("page") PageVO pageVO, @Param("condition") Condition condition);

    /**
     * 根据条件查询货物到站信息右侧数据条数
     * @param condition
     * @return Integer
     */
    public Integer findCargoStationDetailedCount(@Param("condition") Condition condition);

}
