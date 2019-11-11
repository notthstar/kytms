/**
 * @description
 * @author lcy
 * @create 2019/10/30
 * @since 1.0.0
 */
package com.t28.forest.order.service;

import com.t28.forest.order.vo.*;

import java.util.List;
public interface OrderService {

    List<Presco> getPresco(String rc, Object input);

    List<Order> getOrder(String rc, Object input);

    List<Led> getLeds(String rc, Object input);

    List<OrderSign> getOrderSign(String rc, Object input);

    List<OrderBack> getOrderBack(String rc, Object input);

}
