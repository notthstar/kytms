/**
 * @description
 * @author lcy
 * @create 2019/11/8
 * @since 1.0.0
 */
package com.t28.forest.order.controller;

import com.t28.forest.order.service.OrderService;
import com.t28.forest.order.vo.OrderSign;
import com.t28.forest.order.vo.Presco;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
@Controller
public class OrderSignController {
    @Autowired
    OrderService service;

    @RequestMapping("/getOrderSign")
    public String OrderSelect(Model model){
        List<OrderSign> OrderSign = service.getOrderSign(null,null);
        model.addAttribute("OrderSign",OrderSign);
        return "Order/OrderSign";
    }

    @RequestMapping("/selectBySign")
    public String selectByxx(Model model, HttpServletRequest request, HttpServletResponse response){
        String rc = request.getParameter("rc");
        String input = request.getParameter("input");
        List<OrderSign> OrderSign = service.getOrderSign(rc,input);
        model.addAttribute("OrderSign",OrderSign);
        return "Order/OrderSign";
    }
}
