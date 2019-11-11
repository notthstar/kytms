/**
 * @description
 * @author lcy
 * @create 2019/11/5
 * @since 1.0.0
 */
package com.t28.forest.order.controller;

import com.t28.forest.core.entity.JcPresco;
import com.t28.forest.core.utils.SimpleUtils;
import com.t28.forest.order.service.OrderAddService;
import com.t28.forest.order.service.OrderDelService;
import com.t28.forest.order.service.OrderService;
import com.t28.forest.order.vo.Presco;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
public class PrescoController {

    @Autowired
    OrderService service;

    @Autowired
    OrderDelService delService;

    @Autowired
    OrderAddService orderAddService;

    @RequestMapping("/getPresco")
    public String OrderSelect(Model model){
        List<Presco> Presco = service.getPresco(null,null);
        model.addAttribute("Presco",Presco);
       return "Order/PrescoVo";
    }
    @RequestMapping("/deletePersco")
    public ModelAndView deleteOrder(Model model, HttpServletRequest request, HttpServletResponse response){
        String id = request.getParameter("id");
        delService.delPersco(id);
        return new ModelAndView("redirect:/getPresco");
    }
    @RequestMapping("/selectByxx")
    public String selectByxx(Model model, HttpServletRequest request, HttpServletResponse response){
        String rc = request.getParameter("rc");
        String input = request.getParameter("input");
        List<Presco> Presco = service.getPresco(rc,input);
        model.addAttribute("Presco",Presco);
        return "Order/PrescoVo";
    }
    @RequestMapping("/getYY")
    public String getOrder(Model model){

        return "Order/PrescoAdd";
    }
    @RequestMapping("/addOrder")
    public ModelAndView addOrder(Model model,HttpServletRequest request, HttpServletResponse response){
        JcPresco presco = new JcPresco();
        presco.setCode(request.getParameter("code"));
        presco.setDescription("测试信息");
        presco.setFhAddress(request.getParameter("fhAddress"));
        presco.setFhDetaileaddress(request.getParameter("fhDetaileaddress"));
        presco.setFhIphone(request.getParameter("fhIphone"));
        presco.setFhName(request.getParameter("fhName"));
        presco.setFhPerson(request.getParameter("fhPerson"));
        presco.setShAddress(request.getParameter("shAddress"));
        presco.setShDetaileaddress(request.getParameter("shDetaileaddress"));
        presco.setShIphone(request.getParameter("shIphone"));
        presco.setShPerson(request.getParameter("shPerson"));
        presco.setShName(request.getParameter("shName"));
        presco.setCostomerTpye(1);
        presco.setJzWeight(12.1);
        presco.setWeight(12.0);
        presco.setStatus(1);
        presco.setPickMileage(1.1);
        presco.setRelatebill1("1212");
        presco.setValue(22.1);
        presco.setVolume(21.1);
        presco.setWeight(1.1);
        presco.setId(SimpleUtils.generateUniqueCode("GX"));
        orderAddService.addOrder(presco);
        return new ModelAndView("redirect:/getPresco");
    }

}
