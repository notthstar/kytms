package com.t28.forest.operate.service.impl;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.Shipment;
import com.t28.forest.core.utils.SimpleUtils;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.dao.ArrivalVehicleRecordDao;
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
    @Autowired
    ArrivalVehicleRecordDao arrivalVehicleRecordDao;

    @Override
    public List<ShipmentVO> getShipmentsByPage(PageVO page, Condition condition) {
        // 获得当前数据总条数
        int count = shipmentDao.findShipmentCount(condition);
        // 调用PageVO类的计算总页数的方法
        page.calaTotalPage(count);
        return shipmentDao.findShipmentsByPage(page, condition);
    }

    @Override
    public Shipment getShipmentById(String id) {
        return shipmentDao.selectById(id);
    }

    @Override
    public Integer addShipment(Shipment shipment) {
        // 生成唯一ID
        shipment.setId(SimpleUtils.generateId());
        // 生成订单号
        shipment.setCode(SimpleUtils.generateUniqueCode("GZFZX"));
        return shipmentDao.insert(shipment);
    }

    @Override
    public Integer updateShipmentById(Shipment shipment) {
        return shipmentDao.updateById(shipment);
    }
}