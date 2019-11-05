package com.t28.forest.operate.service;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.CargoStationDetailedVO;
import com.t28.forest.operate.vo.CargoStationVO;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 货物到站service层接口
 * @create 2019/11/5
 * @since 1.0.0
 */
public interface CargoStationService {

    /**
     * 根据条件分页获取货物到站的左侧数据信息
     * @param page
     * @param condition
     * @return List<CargoStationVO>
     */
    public List<CargoStationVO> getCargoStationsByPage(PageVO page, Condition condition);

    /**
     * 根据条件分页获取货物到站的右侧数据信息
     * @param page
     * @param condition
     * @return List<CargoStationDetailedVO>
     */
    public List<CargoStationDetailedVO> getStationDetailedsByPage(PageVO page, Condition condition);

}
