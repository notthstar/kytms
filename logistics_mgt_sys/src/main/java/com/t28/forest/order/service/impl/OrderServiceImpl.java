/**
 * @description
 * @author lcy
 * @create 2019/10/30
 * @since 1.0.0
 */
package com.t28.forest.order.service.impl;

import com.t28.forest.order.dao.OrderDao;
import com.t28.forest.order.vo.*;
import com.t28.forest.order.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderDao dao;
    @Override
    public List<Presco> getPresco(String rc, Object input) {
        return dao.planned(rc,input);
    }

    @Override
    public List<Order> getOrder(String rc, Object input) {
        return dao.orders(rc,input);
    }

    @Override
    public List<Led> getLeds(String rc, Object input) {
        return dao.leds(rc,input);
    }

    @Override
    public List<OrderSign> getOrderSign(String rc, Object input) {
        return dao.ledSign(rc,input);
    }

    @Override
    public List<OrderBack> getOrderBack(String rc, Object input) {
        return dao.orderBack(rc,input);
    }
}
