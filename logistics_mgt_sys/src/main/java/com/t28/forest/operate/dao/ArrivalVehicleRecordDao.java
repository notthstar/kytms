package com.t28.forest.operate.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.VehicleArrive;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.ArrivalVehicleRecordVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 到货车辆记录DAO层接口
 * @create 2019/10/31
 * @since 1.0.0
 */
@Repository
public interface ArrivalVehicleRecordDao extends BaseMapper<VehicleArrive> {

    /**
     * 分页条件查询到货车辆记录信息
     * @param pageVO
     * @param condition
     * @return List<ArrivalVehicleRecordVO>
     */
    public List<ArrivalVehicleRecordVO> findArrivalVehicleByPage(@Param("page") PageVO pageVO, @Param("condition") Condition condition);

    /**
     * 条件查询到货车辆记录数据条数
     * @param condition
     * @return Integer
     */
    public Integer findArrivalVehicleCount(@Param("condition") Condition condition);

}
