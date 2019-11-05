package com.t28.forest.operate.service.impl;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.dao.CargoStationDao;
import com.t28.forest.operate.dao.CargoStationDetailedDao;
import com.t28.forest.operate.service.CargoStationService;
import com.t28.forest.operate.vo.CargoStationDetailedVO;
import com.t28.forest.operate.vo.CargoStationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 货物到站业务逻辑层实现
 * @create 2019/11/5
 * @since 1.0.0
 */
@Service
public class CargoStationServiceImpl implements CargoStationService {

    @Autowired
    CargoStationDao cargoStationDao;
    @Autowired
    CargoStationDetailedDao cargoStationDetailedDao;

    @Override
    public List<CargoStationVO> getCargoStationsByPage(PageVO page, Condition condition) {
        // 计算总页数
        page.calaTotalPage(cargoStationDao.findCargoStationCount(condition));
        // 返回查询到的数据
        return cargoStationDao.findCargoStatinoByPage(page, condition);
    }

    @Override
    public List<CargoStationDetailedVO> getStationDetailedsByPage(PageVO page, Condition condition) {
        page.calaTotalPage(cargoStationDetailedDao.findCargoStationDetailedCount(condition));
        return cargoStationDetailedDao.findCargoStationDetailedByPage(page, condition);
    }
}