/**
 * @description 控制库存
 * @author HF
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.stock.controller;

import com.t28.forest.core.vo.PageVO;
import com.t28.forest.stock.condition.JgGridListModel;
import com.t28.forest.stock.condition.MyCondition;
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
    public String showSctock(Integer id) {
        MyCondition myCondition=new MyCondition();
        myCondition.setStatus(5);
        if(id!=null){
            myCondition.setStatus(id);
        }
        List<StockInquiryVO> allStuotkInquiry = stockService.getAllStuotkInquiry(new PageVO(1,4),myCondition);
        JgGridListModel jgGridListModel = new JgGridListModel();
        jgGridListModel.setRows(allStuotkInquiry);
        return jgGridListModel.toJSONString();
    }

    @RequestMapping("/showInoutRecords")
    @ResponseBody
    public String showInOutRecords() {
        List<InOutRecordsVO> allInOutRecords = stockService.getAllInOutRecords(new PageVO(1, 4));
        JgGridListModel jgGridListModel = new JgGridListModel();
        jgGridListModel.setRows(allInOutRecords);
        return jgGridListModel.toJSONString();
    }
}
