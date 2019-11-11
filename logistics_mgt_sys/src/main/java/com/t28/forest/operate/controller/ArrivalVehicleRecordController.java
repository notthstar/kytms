package com.t28.forest.operate.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.JgGridListModel;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.service.ArrivalVehicleRecordService;
import com.t28.forest.operate.vo.ArrivalVehicleRecordVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 到货车辆记录控制层
 * @create 2019/11/9
 * @since 1.0.0
 */
@Controller
@RequestMapping("/vehicleRecord")
public class ArrivalVehicleRecordController {

    @Autowired
    ArrivalVehicleRecordService arrivalVehicleRecordService;

    @RequestMapping("/show")
    @ResponseBody
    public String getVehicleRecordList(CommModel model) {
        List<ArrivalVehicleRecordVO> vehicleRecordVOS = arrivalVehicleRecordService.getArrivalVehicleRecordsByPage(new PageVO(1, 5), new Condition());
        JgGridListModel jgGridListModel = new JgGridListModel(vehicleRecordVOS);
        return jgGridListModel.toJSONString();
    }


}