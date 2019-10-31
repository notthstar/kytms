package com.t28.forest.operate.service;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.t28.forest.core.cond.Condition;
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
     * 保存运单信息
     * @return integer
     */
    public Integer addShipment();

    /**
     * 通过ID修改运单信息
     * @return Integer
     */
    public Integer updateShipmentById();

}
