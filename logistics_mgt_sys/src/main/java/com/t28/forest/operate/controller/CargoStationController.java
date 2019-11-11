package com.t28.forest.operate.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.JgGridListModel;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.service.CargoStationService;
import com.t28.forest.operate.vo.CargoStationDetailedVO;
import com.t28.forest.operate.vo.CargoStationVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 货物到站控制层
 * @create 2019/11/9
 * @since 1.0.0
 */
@Controller
@RequestMapping("/cargoStation")
public class CargoStationController {

    @Autowired
    CargoStationService cargoStationService;

    @RequestMapping("/left")
    @ResponseBody
    public String getCargoStation(CommModel model) {
        List<CargoStationVO> cargoStationVOS = cargoStationService.getCargoStationsByPage(new PageVO(1, 5), new Condition());
        JgGridListModel jgGridListModel = new JgGridListModel(cargoStationVOS);
        return jgGridListModel.toJSONString();
    }

    @RequestMapping("/right")
    @ResponseBody
    public String getCargoStationDetailed(CommModel model) {
        List<CargoStationDetailedVO> stationDetailedVOS = cargoStationService.getStationDetailedsByPage(new PageVO(1, 5), new Condition());
        JgGridListModel jgGridListModel = new JgGridListModel(stationDetailedVOS);
        return jgGridListModel.toJSONString();
    }

}