package com.t28.forest.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author XiangYuFeng
 * @description 测试控制层&测试控制类
 * @create 2019/10/27
 * @since 1.0.0
 */
@Controller
public class HelloController {

    @RequestMapping("/hello")
    public String hello(Model model) {
        model.addAttribute("msg", "管理员");
        return "hello";
    }

}