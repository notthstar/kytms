/**
 * @description
 * @author lcy
 * @create 2019/11/8
 * @since 1.0.0
 */
package com.t28.forest.order.controller;

import com.t28.forest.order.service.OrderService;
import com.t28.forest.order.vo.Led;
import com.t28.forest.order.vo.OrderBack;
import com.t28.forest.order.vo.Presco;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class OrderBackController {
    @Autowired
    OrderService service;

    @RequestMapping("/getOrderBack")
    public String OrderSelect(Model model){
        List<OrderBack> OrderBack = service.getOrderBack(null,null);
        model.addAttribute("OrderBack",OrderBack);
        return "Order/OrderBack";
    }
    @RequestMapping("/selectByBack")
    public String selectByxx(Model model, HttpServletRequest request, HttpServletResponse response){
        String rc = request.getParameter("rc");
        String input = request.getParameter("input");
        List<OrderBack> OrderBack = service.getOrderBack(rc,input);
        model.addAttribute("OrderBack",OrderBack);
        return "Order/OrderBack";
    }
}
