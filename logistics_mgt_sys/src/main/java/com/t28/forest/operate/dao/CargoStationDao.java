package com.t28.forest.operate.dao;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.CargoStationVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 货物到站DAO层接口
 * @create 2019/10/31
 * @since 1.0.0
 */
@Repository
public interface CargoStationDao {

    /**
     * 分页条件查询货物到站信息
     * @param pageVO
     * @param condition
     * @return List<CargoStationVO>
     */
    public List<CargoStationVO> findCargoStatinoByPage(@Param("page") PageVO pageVO, @Param("condition") Condition condition);

    /**
     * 根据条件查询货物到站数据条数
     * @param condition
     * @return Integer
     */
    public Integer findCargoStationCount(@Param("condition") Condition condition);

}
