package com.t28.forest.operate.service;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.ArrivalVehicleRecordVO;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 到货车辆记录service层接口
 * @create 2019/11/5
 * @since 1.0.0
 */
public interface ArrivalVehicleRecordService {

    /**
     * 根据条件分页查询到货车辆记录信息
     * @param page
     * @param condition
     * @return List<ArrivalVehicleRecordVO>
     */
    public List<ArrivalVehicleRecordVO> getArrivalVehicleRecordsByPage(PageVO page, Condition condition);

}
