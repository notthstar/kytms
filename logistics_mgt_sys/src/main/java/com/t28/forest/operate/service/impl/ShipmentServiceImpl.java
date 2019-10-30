package com.t28.forest.operate.service.impl;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.dao.ShipmentDao;
import com.t28.forest.operate.service.ShipmentService;
import com.t28.forest.operate.vo.ShipmentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * @author XiangYuFeng
 * @description 运单业务逻辑层实现类
 * @create 2019/10/30
 * @since 1.0.0
 */
@Service
public class ShipmentServiceImpl implements ShipmentService {

    @Autowired
    ShipmentDao shipmentDao;

    @Override
    public List<ShipmentVO> getShipmentsByPage(PageVO page, Condition condition) {
        return shipmentDao.findShipmentsByPage(page, condition);
    }
}