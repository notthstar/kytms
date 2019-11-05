package com.t28.forest.operate.service.impl;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.dao.ArrivalVehicleRecordDao;
import com.t28.forest.operate.service.ArrivalVehicleRecordService;
import com.t28.forest.operate.vo.ArrivalVehicleRecordVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 到货车辆记录service层实现类
 * @create 2019/11/5
 * @since 1.0.0
 */
@Service
public class ArrivalVehicleRecordServiceImpl implements ArrivalVehicleRecordService {

    @Autowired
    ArrivalVehicleRecordDao arrivalVehicleRecordDao;

    @Override
    public List<ArrivalVehicleRecordVO> getArrivalVehicleRecordsByPage(PageVO page, Condition condition) {
        page.calaTotalPage(arrivalVehicleRecordDao.findArrivalVehicleCount(condition));
        return arrivalVehicleRecordDao.findArrivalVehicleByPage(page, condition);
    }
}