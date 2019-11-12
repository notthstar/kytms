package com.t28.forest.operate.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.ShipmentTrack;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.JgGridListModel;
import com.t28.forest.core.model.ReturnInfoModel;
import com.t28.forest.core.utils.SimpleUtils;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.service.WaybillTrackService;
import com.t28.forest.operate.vo.WayBillTranckVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 运单跟踪控制类
 * @create 2019/11/8
 * @since 1.0.0
 */
@Controller
@RequestMapping("/waybill")
public class WaybillTrackController {

    @Autowired
    WaybillTrackService waybillTrackService;

    @RequestMapping("/show")
    @ResponseBody
    public String getWaybills(Condition condition) {
        List<WayBillTranckVO> waybillTracks = waybillTrackService.getWayBillTrancksByPage(new PageVO(1, 100), condition);

        return SimpleUtils.objectToJSON(new ReturnInfoModel(waybillTracks));
    }

    @RequestMapping("/show/{id}")
    @ResponseBody
    public String showShipmentTrackById(@PathVariable String id) {
        ShipmentTrack track = waybillTrackService.getShipmentTrackById(id);

        return SimpleUtils.objectToJSON(new ReturnInfoModel(track));
    }

}