package com.t28.forest.operate.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.entity.Single;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.JgGridListModel;
import com.t28.forest.core.model.ReturnInfoModel;
import com.t28.forest.core.utils.SimpleUtils;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.service.DispatchOrderService;
import com.t28.forest.operate.vo.DispatchVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.websocket.server.PathParam;
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
    public String showDispatchList(Condition condition) {
        List<DispatchVO> dispatchList = dispatchOrderService.getDispatchsByPage(new PageVO(1, 100), condition);

        return SimpleUtils.objectToJSON(new ReturnInfoModel(dispatchList));
    }

    @RequestMapping("/add")
    @ResponseBody
    public String addDispatch(Single single) {
        int result = dispatchOrderService.addDispatch(single);

        return resultReturn(result, "派车单添加");
    }

    @RequestMapping("/update")
    @ResponseBody
    public String updateDispatchById(Single single) {
        int result = dispatchOrderService.updateDispatchById(single);

        return resultReturn(result, "派车单修改");
    }

    @RequestMapping("/show/${id}")
    @ResponseBody
    public String showDispatchById(@PathVariable String id) {
        Single single = dispatchOrderService.getDispatchById(id);

        return SimpleUtils.objectToJSON(new ReturnInfoModel(single));
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