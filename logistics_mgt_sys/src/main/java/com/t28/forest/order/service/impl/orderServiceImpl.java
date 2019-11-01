/**
 * @description
 * @author lcy
 * @create 2019/10/30
 * @since 1.0.0
 */
package com.t28.forest.order.service.impl;

import com.t28.forest.order.dao.OrderDao;
import com.t28.forest.order.entity.vo.presco;
import com.t28.forest.order.service.orderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class orderServiceImpl implements orderService {

    @Autowired
    OrderDao dao;
    @Override
    public List<presco> getPlan(String rc,Object input) {
        return dao.planned(rc,input);
    }
}
