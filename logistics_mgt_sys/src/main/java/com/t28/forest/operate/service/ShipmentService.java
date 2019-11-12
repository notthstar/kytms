package com.t28.forest.operate.service;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.Shipment;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.ShipmentVO;

import java.util.List;


/**
 * @author XiangYuFeng
 * @description 运单业务逻辑层接口
 * @create 2019/10/30
 * @since 1.0.0
 */
public interface ShipmentService {

    /**
     * 通过分页OR条件获取运单信息
     * @param page
     * @param condition 条件对象
     * @return List<ShipmentVO>
     */
    public List<ShipmentVO> getShipmentsByPage(PageVO page, Condition condition);

    /**
     * 通过ID获取运单信息
     * @param id
     * @return Shipment
     */
    public Shipment getShipmentById(String id);

    /**
     * 保存运单信息
     * @param shipment
     * @return integer
     */
    public Integer addShipment(Shipment shipment);

    /**
     * 通过ID修改运单信息
     * @param shipment
     * @return Integer
     */
    public Integer updateShipmentById(Shipment shipment);

}
