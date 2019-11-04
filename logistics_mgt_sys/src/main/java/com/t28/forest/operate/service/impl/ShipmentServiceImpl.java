package com.t28.forest.operate.service.impl;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.Shipment;
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
        // 获得当前数据总条数
        int count = shipmentDao.findShipmentCount(condition);
        // 通过数据总条数计算总页数
        int totalPage = count % page.getSize() == 0 ? count / page.getSize() : count / page.getSize() + 1;
        page.setTotal(totalPage);
        return shipmentDao.findShipmentsByPage(page, condition);
    }

    @Override
    public Integer addShipment(Shipment shipment) {
        return shipmentDao.insert(shipment);
    }

    @Override
    public Integer updateShipmentById(Shipment shipment) {
        return shipmentDao.updateById(shipment);
    }
}