package com.t28.forest.operate.service.impl;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.Single;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.dao.DispatchOrderDao;
import com.t28.forest.operate.service.DispatchOrderService;
import com.t28.forest.operate.vo.DispatchVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 派车单service层实现类
 * @create 2019/11/4
 * @since 1.0.0
 */
@Service
public class DispatchOrderServiceImpl implements DispatchOrderService {

    @Autowired
    DispatchOrderDao dispatchOrderDao;

    @Override
    public List<DispatchVO> getDispatchsByPage(PageVO page, Condition condition) {
        // 获得当前数据总条数
        int count = dispatchOrderDao.findDispatchCount(condition);
        // 通过数据总条数计算总页数
        int totalPage = count % page.getSize() == 0 ? count / page.getSize() : count / page.getSize() + 1;
        page.setTotal(totalPage);
        return dispatchOrderDao.findDispatchByPage(page, condition);
    }

    @Override
    public Integer addDispatch(Single single) {
        return dispatchOrderDao.insert(single);
    }

    @Override
    public Integer updateDispatchById(Single single) {
        return dispatchOrderDao.updateById(single);
    }
}