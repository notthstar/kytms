package com.t28.forest.operate.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.ShipmentVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 运单DAO层接口
 * @create 2019/10/30
 * @since 1.0.0
 */
@Repository
public interface ShipmentDao extends BaseMapper<ShipmentVO> {

    /**
     * 条件分页查询运单信息
     * @param pageVO
     * @param condition
     * @return IPage<ShipmentVO>
     */
    public List<ShipmentVO> findShipmentsByPage(@Param("page")PageVO pageVO, @Param("condition") Condition condition);

}
