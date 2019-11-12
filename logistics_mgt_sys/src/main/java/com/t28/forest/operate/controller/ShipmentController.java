package com.t28.forest.operate.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.Shipment;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.JgGridListModel;
import com.t28.forest.core.model.ReturnInfoModel;
import com.t28.forest.core.utils.SimpleUtils;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.service.ShipmentService;
import com.t28.forest.operate.vo.ShipmentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;
import java.util.Objects;

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

    @RequestMapping("/show")
    @ResponseBody
    public String showShipments(Condition condition) {
        List<ShipmentVO> shipments = shipmentService.getShipmentsByPage(new PageVO(1, 100), condition);

        return SimpleUtils.objectToJSON(new ReturnInfoModel(shipments));
    }

    @RequestMapping("/show/{id}")
    public String showShipmentById(@PathVariable String id) {
        Shipment shipment = shipmentService.getShipmentById(id);

        return SimpleUtils.objectToJSON(new ReturnInfoModel(shipment));
    }


    @RequestMapping("/add")
    @ResponseBody
    public String addShipment(Shipment shipment) {
        int result = shipmentService.addShipment(shipment);

        return resultReturn(result, "运单添加");
    }

    @RequestMapping("/update")
    @ResponseBody
    public String updateShipmentById(Shipment shipment) {
        int result = shipmentService.updateShipmentById(shipment);

        return resultReturn(result, "运单修改");
    }

    /**
     * 返回响应结果信息的方法
     * @param result
     * @param msg
     * @return String
     */
    private String resultReturn(int result, String msg) {
        if (result > 0) {
            return SimpleUtils.objectToJSON(new ReturnInfoModel(msg + "成功！", true));
        }
        return SimpleUtils.objectToJSON(new ReturnInfoModel(msg + "失败！", false));
    }

}