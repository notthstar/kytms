package com.t28.forest.operate;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

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

}