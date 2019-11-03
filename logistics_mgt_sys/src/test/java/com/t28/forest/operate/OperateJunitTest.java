package com.t28.forest.operate;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.dao.DispatchOrderDao;
import com.t28.forest.operate.dao.ShipmentDao;
import com.t28.forest.operate.dao.WaybillTrackDao;
import com.t28.forest.operate.vo.ShipmentVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 运营管理单元测试
 * @create 2019/10/30
 * @since 1.0.0
 */
@RunWith(SpringRunner.class)
@SpringBootTest
public class OperateJunitTest {

    @Test
    public void test() {
        Object[] objs = new Object[1];
        System.out.println(objs.length > 1);
    }

    @Autowired
    ShipmentDao shipmentDao;

    @Test
    public void findShipmentByPageTest() {
        Condition condition = new Condition("402881a36710579c016710c4e2fb0230");
//        condition.setName("shipment0_.TIME");
//        condition.setValues(new Object[]{"2019-01-11", "2019-12-12"});
        condition.setName("organizati2_.NAME");
        condition.setValues(new Object[]{"广州"});
        Integer count = shipmentDao.findShipmentCount(condition);
        System.out.println(count);
//        List<ShipmentVO> shipments = shipmentDao.findShipmentsByPage(new PageVO(1, 4), condition);
//        for (ShipmentVO shipment : shipments) {
//            System.out.println(shipment);
//        }
    }

    @Autowired
    DispatchOrderDao dispatchDao;

    @Test
    public void findDispatchTest() {
        Condition condition = new Condition("402881a36710579c016710c4e2fb0230");
        condition.setName("organizati2_.NAME");
        condition.setValues(new Object[]{"广州"});
        Integer count = dispatchDao.findDispatchCount(condition);
        System.out.println(count);
    }


    @Autowired
    WaybillTrackDao waybillTrackDao;

    @Test
    public void findWayBillTest() {
        Condition condition = new Condition("402881a36710579c016710c4e2fb0230");
//        condition.setName("time");
//        condition.setValues(new Object[]{"2019-01-11", "2019-12-12"});
        condition.setName("organizati2_.NAME");
        condition.setValues(new Object[]{"广州"});
        Integer count = waybillTrackDao.findWayBillCount(condition);
        System.out.println(count);
    }

}