package com.t28.forest.operate.service;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.Single;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.vo.DispatchVO;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 派车单Service层接口
 * @create 2019/11/4
 * @since 1.0.0
 */
public interface DispatchOrderService {

    /**
     * 分页条件获取派车单信息
     * @param page
     * @param condition
     * @return List<DispatchVO>
     */
    public List<DispatchVO> getDispatchsByPage(PageVO page, Condition condition);

    /**
     * 通过ID获取派车单信息
     * @param id
     * @return DispatchVO
     */
    public Single getDispatchById(String id);

    /**
     * 添加派车单信息
     * @param single
     * @return Integer
     */
    public Integer addDispatch(Single single);

    /**
     * 通过ID修改派车单信息
     * @param single
     * @return Integer
     */
    public Integer updateDispatchById(Single single);

}
