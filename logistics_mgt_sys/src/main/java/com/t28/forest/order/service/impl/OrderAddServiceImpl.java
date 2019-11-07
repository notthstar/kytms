/**
 * @description
 * @author lcy
 * @create 2019/11/4
 * @since 1.0.0
 */
package com.t28.forest.order.service.impl;

import com.t28.forest.core.entity.JcPresco;
import com.t28.forest.core.entity.JcReceivingparty;
import com.t28.forest.order.dao.OrderAdd;
import com.t28.forest.order.service.OrderAddService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderAddServiceImpl implements OrderAddService {



    @Autowired
    OrderAdd dao;
    @Override
    public void addOrder(JcPresco presco) {
          dao.insertOrder(presco);
    }

    @Override
    public void addSFh(JcReceivingparty receivingparty) {
        dao.insertReceiving(receivingparty);
    }
}
