package com.t28.forest.operate.controller;

import com.t28.forest.operate.service.ShipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author XiangYuFeng
 * @description 运单控制类
 * @create 2019/11/4
 * @since 1.0.0
 */
@Controller
@RequestMapping("/shipment")
public class ShipmentController {

    @Autowired
    ShipmentService shipmentService;

}