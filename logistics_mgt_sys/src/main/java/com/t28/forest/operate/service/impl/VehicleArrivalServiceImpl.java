package com.t28.forest.operate.service.impl;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.dao.VehicleArrivalDao;
import com.t28.forest.operate.service.VehicleArrivalService;
import com.t28.forest.operate.vo.VehicleArrivalVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 车辆到站业务逻辑层实现
 * @create 2019/11/5
 * @since 1.0.0
 */
@Service
public class VehicleArrivalServiceImpl implements VehicleArrivalService {

    @Autowired
    VehicleArrivalDao vehicleArrivalDao;

    @Override
    public List<VehicleArrivalVO> getVehicleArrivalsByPage(PageVO page, Condition condition) {
        page.calaTotalPage(vehicleArrivalDao.findVehicleArrivalCount(condition));
        return vehicleArrivalDao.findVehicleArrivalByPage(page, condition);
    }
}