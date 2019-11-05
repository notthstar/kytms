package com.t28.forest.operate.service;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.VehicleArrivalVO;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 车辆到站业务逻辑层接口
 * @create 2019/11/5
 * @since 1.0.0
 */
public interface VehicleArrivalService {

    /**
     * 根据条件分页获取车辆到站信息
     * @param page
     * @param condition
     * @return List<VehicleArrivalVO>
     */
    public List<VehicleArrivalVO> getVehicleArrivalsByPage(PageVO page, Condition condition);

}
