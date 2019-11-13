package com.t28.forest.operate.service.impl;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.Single;
import com.t28.forest.core.utils.SimpleUtils;
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
        page.calaTotalPage(count);
        return dispatchOrderDao.findDispatchByPage(page, condition);
    }

    @Override
    public Single getDispatchById(String id) {
        return dispatchOrderDao.selectById(id);
    }

    @Override
    public Integer addDispatch(Single single) {
        // 生成唯一ID
        single.setId(SimpleUtils.generateId());
        // 生成订单号
        single.setCode(SimpleUtils.generateUniqueCode("GZFZX"));
        return dispatchOrderDao.insert(single);
    }

    @Override
    public Integer updateDispatchById(Single single) {
        return dispatchOrderDao.updateById(single);
    }
}