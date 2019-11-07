/**
 * @description
 * @author lcy
 * @create 2019/11/4
 * @since 1.0.0
 */
package com.t28.forest.order.service;

import com.t28.forest.core.entity.JcPresco;
import com.t28.forest.core.entity.JcReceivingparty;

public interface OrderAddService {

    void addOrder(JcPresco presco);

    void addSFh(JcReceivingparty receivingparty);
}
