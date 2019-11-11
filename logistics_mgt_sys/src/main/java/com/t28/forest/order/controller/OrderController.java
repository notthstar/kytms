/**
 * @description
 * @author lcy
 * @create 2019/11/8
 * @since 1.0.0
 */
package com.t28.forest.order.controller;

import com.t28.forest.order.service.OrderDelService;
import com.t28.forest.order.service.OrderService;
import com.t28.forest.order.vo.Led;
import com.t28.forest.order.vo.Order;
import com.t28.forest.order.vo.Presco;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
public class OrderController {
    @Autowired
    OrderService service;

    @Autowired
    OrderDelService delService;

    @RequestMapping("/getOrder")
    public String OrderSelect(Model model){
        List<Order> Order = service.getOrder(null,null);
        model.addAttribute("Order",Order);
        return "Order/OrderVO";
    }

    @RequestMapping("/deleteOrder")
    public ModelAndView deleteOrder(Model model, HttpServletRequest request, HttpServletResponse response){
        String id = request.getParameter("id");
        delService.delOrder(id);
        return new ModelAndView("redirect:/getOrder");
    }
    @RequestMapping("/selectByOrder")
    public String selectByxx(Model model, HttpServletRequest request, HttpServletResponse response){
        String rc = request.getParameter("rc");
        String input = request.getParameter("input");
        List<Order> Order = service.getOrder(rc,input);
        model.addAttribute("Order",Order);
        return "Order/OrderVO";
    }
    @RequestMapping("/getYm")
    public String getOrder(Model model){
        return "Order/OrderAdd";
    }
}
