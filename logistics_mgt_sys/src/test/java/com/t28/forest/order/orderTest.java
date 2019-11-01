/**
 * @description
 * @author lcy
 * @create 2019/10/31
 * @since 1.0.0
 */
package com.t28.forest.order;

import com.t28.forest.order.service.OrderService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class orderTest {

    @Autowired
    OrderService service;
    @Test
    public void test(){
        System.out.println(service.getPlan(null,null).get(0));
    }
}
