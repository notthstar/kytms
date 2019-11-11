/**
 * @description 控制库存
 * @author HF
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.stock.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.ReturnInfoModel;
import com.t28.forest.core.utils.SimpleUtils;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.stock.service.StockService;
import com.t28.forest.stock.vo.InOutRecordsVO;
import com.t28.forest.stock.vo.StockInquiryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class ControllerStock {

    @Autowired
    StockService stockService;

    @RequestMapping("/showSctock")
    @ResponseBody
    public String showSctock(CommModel commModel) {
        List<StockInquiryVO> allStuotkInquiry = stockService.getAllStuotkInquiry(new PageVO(1,4),new Condition());
        return SimpleUtils.objectToJSON(new ReturnInfoModel(allStuotkInquiry));
    }

    @RequestMapping("/showInoutRecords")
    @ResponseBody
    public String showInOutRecords(CommModel commModel){
        List<InOutRecordsVO> allInOutRecords = stockService.getAllInOutRecords(new PageVO(1, 4),new Condition());
        return SimpleUtils.objectToJSON(new ReturnInfoModel(allInOutRecords));
    }
}
