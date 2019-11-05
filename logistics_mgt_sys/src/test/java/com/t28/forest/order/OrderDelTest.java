/**
 * @description
 * @author lcy
 * @create 2019/11/5
 * @since 1.0.0
 */
package com.t28.forest.order;

import com.t28.forest.order.service.OrderDelService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class OrderDelTest {

    @Autowired
    OrderDelService service;

    @Test
    public void testDelPlan(){
        String id = "1";
        service.delPlan(id);
    }

    @Test
    public void testDelSFh(){
        String id = "id";
        service.delSFh(id);
    }
}
