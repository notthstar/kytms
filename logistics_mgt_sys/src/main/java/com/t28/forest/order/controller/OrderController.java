/**
 * @description
 * @author lcy
 * @create 2019/11/5
 * @since 1.0.0
 */
package com.t28.forest.order.controller;

import com.t28.forest.order.service.OrderService;
import com.t28.forest.order.vo.Presco;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class OrderController {

    @Autowired
    OrderService service;

    @RequestMapping("getPlan")
    public String OrderSelect(Model model){
        List<Presco> plan = service.getPlan(null,null);
        model.addAttribute("plan",plan);
       return "retailmanagement/storage";
    }


}
