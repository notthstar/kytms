/**
 * @description
 * @author lcy
 * @create 2019/10/31
 * @since 1.0.0
 */
package com.t28.forest;

import com.t28.forest.order.service.orderService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class orderTest {

    @Autowired
    orderService service;
    @Test
    public void testPlan(){
        System.out.println(service.getPlan(null,null).get(0));
    }

    @Test
    public void testOrder(){
        System.out.println(service.getOrder(null,null).get(0));
    }
}
