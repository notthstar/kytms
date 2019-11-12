package com.t28.forest.operate.service.impl;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.ShipmentTrack;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.dao.WaybillTrackDao;
import com.t28.forest.operate.service.WaybillTrackService;
import com.t28.forest.operate.vo.WayBillTranckVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 运单跟踪业务逻辑层实现类
 * @create 2019/11/5
 * @since 1.0.0
 */
@Service
public class WaybillTrackServiceImpl implements WaybillTrackService {

    @Autowired
    WaybillTrackDao waybillTrackDao;

    @Override
    public List<WayBillTranckVO> getWayBillTrancksByPage(PageVO page, Condition condition) {
        page.calaTotalPage(waybillTrackDao.findWayBillCount(condition));
        return waybillTrackDao.findWayBillByPage(page, condition);
    }

    @Override
    public ShipmentTrack getShipmentTrackById(String id) {
        return waybillTrackDao.selectById(id);
    }
}