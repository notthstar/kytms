package com.t28.forest.operate.dao;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.DispatchVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 派车单DAO层接口
 * @create 2019/10/31
 * @since 1.0.0
 */
@Repository
public interface DispatchOrderDao {

    /**
     * 分页条件查询派车单信息
     * @param pageVO
     * @param condition
     * @return List<DispatchVO>
     */
    public List<DispatchVO> findDispatchByPage(@Param("page") PageVO pageVO, @Param("condition") Condition condition);

    /**
     * 通过条件查询派车单数据条数
     * @param condition
     * @return Integer
     */
    public Integer findDispatchCount(@Param("condition") Condition condition);
}
