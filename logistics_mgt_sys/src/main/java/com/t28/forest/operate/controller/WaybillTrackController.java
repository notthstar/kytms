package com.t28.forest.operate.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.JgGridListModel;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.service.WaybillTrackService;
import com.t28.forest.operate.vo.WayBillTranckVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    public String getWaybills(CommModel model) {
        List<WayBillTranckVO> waybillTracks = waybillTrackService.getWayBillTrancksByPage(new PageVO(1, 5), new Condition());
        JgGridListModel jgGridListModel = new JgGridListModel(waybillTracks);
        return jgGridListModel.toJSONString();
    }

}