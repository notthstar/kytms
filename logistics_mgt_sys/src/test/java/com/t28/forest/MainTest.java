package com.t28.forest;

import com.t28.forest.core.entity.SysUser;
import com.t28.forest.core.model.ReturnInfoModel;
import com.t28.forest.core.utils.SimpleUtils;
import com.t28.forest.user.service.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class MainTest {

    public void contextLoads() {}

    @Test
    public void utilTest() throws IllegalAccessException {
//        String code = SimpleUtils.generateUniqueCode("XXX");
//        System.out.println(code);

        String jsonStr = SimpleUtils.ObjectToJson(new SysUser());
        System.out.println(jsonStr);
    }

    @Autowired
    UserService userService;

    @Test
    public void userTest() {
//        SysUser user = userService.login("test", DigestUtils.md5Hex("123456"));
//        System.out.println(user);

//        String fail = SimpleUtils.objectToJSON(new ReturnInfoModel(null, "ss", false));
//        System.out.println(fail);

        System.out.println(SimpleUtils.generateId());
        System.out.println(SimpleUtils.generateUniqueCode("GZFZX"));
    }

}
