/**
 * @description
 * @author lcy
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.Verification;

import com.t28.forest.verification.service.VerificationService;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@SpringBootTest
@RunWith(SpringRunner.class)
public class VerificationTest {

    @Autowired
    VerificationService service;

    @Test
    public void test(){
        System.out.println("干线成本核销部分核销为"+service.getBill(0).get(0));

    }

}
