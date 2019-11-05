/**
 * @description
 * @author lcy
 * @create 2019/10/31
 * @since 1.0.0
 */
package com.t28.forest.order;

import com.t28.forest.core.entity.JcPresco;
import com.t28.forest.core.entity.JcReceivingparty;
import com.t28.forest.order.service.OrderAddService;
import com.t28.forest.order.service.OrderService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

@SpringBootTest
@RunWith(SpringRunner.class)
public class OrderAddTest {

    @Autowired
    OrderAddService service;
    /**
     * 功能描述: 测试添加计划单
     * @param: No such property: code for class: Script1
     * @return:
     * @since: 1.0.0
     * @Author: lcy
     * @Date: 2019/11/5 9:11
     */
    @Test
    public void test() throws ParseException {
        JcPresco presco = new JcPresco();
        presco.setCode("cs");
        String strDate = "2019-01-01";
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        ParsePosition pos = new ParsePosition(0);
        Date date = formatter.parse(strDate, pos);
        presco.setCreateTime(date);
        presco.setDescription("测试信息");
        presco.setFhAddress("发货地址");
        presco.setFhDetaileaddress("发货详细地址");
        presco.setIphone("122132");
        presco.setFhLtl("2131");
        presco.setFhName("黑夜");
        presco.setFhPerson("使者");
        presco.setShAddress("湖南");
        presco.setShDetaileaddress("雨花区");
        presco.setShIphone("1211");
        presco.setShLtl("1212");
        presco.setShPerson("傲娇地啊");
        presco.setShName("名字");
        presco.setCostomerTpye(1);
        presco.setJzWeight(12.1);
        presco.setWeight(12.0);
        presco.setStatus(1);
        presco.setPickMileage(1.1);
        presco.setRelatebill1("1212");
        presco.setValue(22.1);
        presco.setVolume(21.1);
        presco.setWeight(1.1);
        presco.setId("1232543");
        service.addOrder(presco);
    }
    /**
     * 功能描述: 测试添加收发货方
     * @param: No such property: code for class: Script1
     * @return:
     * @since: 1.0.0
     * @Author: lcy
     * @Date: 2019/11/5 9:11
     */
     @Test
     public void testSFh(){
         JcReceivingparty receivingparty = new  JcReceivingparty();
         String strDate = "2019-01-01";
         SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
         ParsePosition pos = new ParsePosition(0);
         Date date = formatter.parse(strDate, pos);
         receivingparty.setCreateTime(date);
         receivingparty.setDescription("备注");
         receivingparty.setName("名字");
         receivingparty.setAddress("地址");
         receivingparty.setDetaileAddress("详细地址");
         receivingparty.setIphone("13345532");
         receivingparty.setLtl("经纬度");
         receivingparty.setId("id");
         service.addSFh(receivingparty);
     }

}
