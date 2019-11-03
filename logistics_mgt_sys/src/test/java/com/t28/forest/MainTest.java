package com.t28.forest;

import com.t28.forest.core.utils.SimpleUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class MainTest {

    public void contextLoads() {}

    @Test
    public void utilTest() {
        String code = SimpleUtils.generateUniqueCode("XXX");
        System.out.println(code);
    }

}
