package com.t28.forest.operate.service;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.ShipmentTrack;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.WayBillTranckVO;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 运单跟踪业务逻辑层接口
 * @create 2019/11/5
 * @since 1.0.0
 */
public interface WaybillTrackService {

    /**
     * 根据条件分页获取运单跟踪信息
     * @param page
     * @param condition
     * @return List<WayBillTranckVO>
     */
    public List<WayBillTranckVO> getWayBillTrancksByPage(PageVO page, Condition condition);

    /**
     * 通过ID获取运单跟踪在途信息
     * @param id
     * @return ShipmentTrack
     */
    public ShipmentTrack getShipmentTrackById(String id);

}
