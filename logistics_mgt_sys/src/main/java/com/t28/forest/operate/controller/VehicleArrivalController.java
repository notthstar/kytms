package com.t28.forest.operate.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.JgGridListModel;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.service.VehicleArrivalService;
import com.t28.forest.operate.vo.VehicleArrivalVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 车辆到站控制层
 * @create 2019/11/8
 * @since 1.0.0
 */
@Controller
@RequestMapping("/vehicle")
public class VehicleArrivalController {

    @Autowired
    VehicleArrivalService vehicleArrivalService;

    @RequestMapping("/show")
    @ResponseBody
    public String getVehicleArrivals(CommModel model) {
        List<VehicleArrivalVO> arrivals = vehicleArrivalService.getVehicleArrivalsByPage(new PageVO(1, 5), new Condition());
        JgGridListModel jgGridListModel = new JgGridListModel(arrivals);
        return jgGridListModel.toJSONString();
    }

}