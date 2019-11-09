package com.t28.forest.user.controller;

import com.alibaba.fastjson.JSONObject;
import com.t28.forest.core.entity.SysUser;
import com.t28.forest.core.model.ReturnInfoModel;
import com.t28.forest.core.utils.SimpleUtils;
import com.t28.forest.user.service.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Objects;

/**
 * @author XiangYuFeng
 * @description 用户控制层
 * @create 2019/11/7
 * @since 1.0.0
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    UserService userService;

    @RequestMapping("/login")
    @ResponseBody
    public String userLogin(SysUser sysUser) {
        SysUser user = userService.login(sysUser.getCode(), DigestUtils.md5Hex(sysUser.getPassword()));

        if (Objects.isNull(user) || Objects.isNull(user.getId())) {
            HashMap<String, Object> map = new HashMap<String, Object>(2);
            map.put("msg", "用户名或密码错误");
            return SimpleUtils.objectToJSON(map);
        }
        return SimpleUtils.objectToJSON(new ReturnInfoModel(user));
    }

}