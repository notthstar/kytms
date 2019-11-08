package com.t28.forest.operate.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.JgGridListModel;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.service.DispatchOrderService;
import com.t28.forest.operate.vo.DispatchVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author XiangYuFeng
 * @description 派车单控制层
 * @create 2019/11/8
 * @since 1.0.0
 */
@Controller
@RequestMapping("/dispatch")
public class DispatchController {

    @Autowired
    DispatchOrderService dispatchOrderService;

    @RequestMapping("/show")
    @ResponseBody
    public String getDispatchs(CommModel model) {
        List<DispatchVO> dispatchs = dispatchOrderService.getDispatchsByPage(new PageVO(1, 5), new Condition());
        JgGridListModel jgGridListModel = new JgGridListModel();
        jgGridListModel.setRows(dispatchs);
        return jgGridListModel.toJSONString();
    }

}