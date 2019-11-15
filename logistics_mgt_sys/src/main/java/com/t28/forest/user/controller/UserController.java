package com.t28.forest.user.controller;

import com.t28.forest.core.entity.SysUser;
import com.t28.forest.core.model.ReturnInfoModel;
import com.t28.forest.core.utils.SimpleUtils;
import com.t28.forest.user.service.UserService;
import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;
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
    public String userLogin(SysUser sysUser, HttpSession session) {
        SysUser user = userService.login(sysUser.getCode(), DigestUtils.md5Hex(sysUser.getPassword()));

        if (Objects.isNull(user) || Objects.isNull(user.getId())) {
            return SimpleUtils.objectToJSON(new ReturnInfoModel("用户名或密码错误！", false));
        }
        session.setAttribute("loginUser", user);
        return SimpleUtils.objectToJSON(new ReturnInfoModel(user));
    }

    @RequestMapping("/register")
    @ResponseBody
    public String userRegister(SysUser sysUser) {
        // 设置用户表主键
        sysUser.setId(SimpleUtils.generateId());
        // 设置用户密码为MD5加密
        sysUser.setPassword(DigestUtils.md5Hex(sysUser.getPassword()));
        // 设置用户创建时间为当前时间
        sysUser.setCreateTime(new Date());
        int result = userService.register(sysUser);
        if (result > 0) {
            return SimpleUtils.objectToJSON(new ReturnInfoModel(sysUser, "用户注册成功！", true));
        }
        return SimpleUtils.objectToJSON(new ReturnInfoModel(sysUser, "用户注册失败！", false));
    }

    @RequestMapping("/out")
    @ResponseBody
    public String userOut(HttpSession session) {
        // 清除session中的数据
        session.invalidate();
        return SimpleUtils.objectToJSON(new ReturnInfoModel("用户退出完成！", true));
    }

}