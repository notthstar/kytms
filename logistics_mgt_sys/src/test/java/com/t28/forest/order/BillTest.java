/**
 * @description
 * @author lcy
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.order;

import com.t28.forest.order.service.BillAddService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class BillTest {
    @Autowired
    BillAddService service;

    @Test
    public void zoneTest(){
        System.out.println("第一个运点为"+service.getZone().get(0));
    }
}
