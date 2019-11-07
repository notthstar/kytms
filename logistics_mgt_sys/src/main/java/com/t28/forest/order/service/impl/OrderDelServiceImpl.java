/**
 * @description
 * @author lcy
 * @create 2019/11/5
 * @since 1.0.0
 */
package com.t28.forest.order.service.impl;

import com.t28.forest.order.dao.OrderDel;
import com.t28.forest.order.service.OrderDelService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OrderDelServiceImpl implements OrderDelService{
    @Autowired
    OrderDel del;

    @Override
    public void delPlan(String id) {
        del.deletePlan(id);
    }

    @Override
    public void delSFh(String id) {
        del.deleteSFh(id);
    }
}
