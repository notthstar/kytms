package com.t28.forest.operate.controller;

import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.model.CommModel;
import com.t28.forest.core.model.JgGridListModel;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.operate.service.ShipmentService;
import com.t28.forest.operate.vo.ShipmentVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
    public String getShipments(CommModel model) {
        Condition condition = new Condition();
        if (!Objects.isNull(model.getWhereValue()) && !"".equals(model.getWhereValue())) {
            String nameUpd = model.getWhereName();
            switch (model.getWhereName()) {
                case "code":
                case "time":
                case "status":
                case "isInoutCome":
                case "liens":
                case "orderCode":
                case "relateBill":
                case "operationPattern":
                case "carrierType":
                case "carriageIsExceed":
                case "tan":
                case "number":
                case "weight":
                case "volume":
                case "value":
                case "createName":
                case "createTime":
                case "modifyName":
                case "modifyTime":
                case "isAbnormal":
                    nameUpd = "shipment0_." + model.getWhereName();
                    break;
                case "name":
                    nameUpd = "organizati2_." + model.getWhereName();
                    break;
                case "organName1":
                    nameUpd = "organizati4_." + model.getWhereName();
                    break;
                case "organName2":
                    nameUpd = "organizati6_." + model.getWhereName();
                    break;
                case "organName3":
                    nameUpd = "organizati7_." + model.getWhereName();
                    break;
                case "organName4":
                    nameUpd = "organizati5_." + model.getWhereName();
                    break;
                case "amount":
                    nameUpd = "ledgerdeta8_." + model.getWhereName();
                    break;
                case "carName":
                    nameUpd = "carrier3_." + model.getWhereName();
                    break;
            }
            model.setWhereName(nameUpd);
            condition.setName(model.getWhereName());
            condition.setValues(new Object[]{model.getWhereValue()});
        }
        List<ShipmentVO> shipments = shipmentService.getShipmentsByPage(new PageVO(1, 5), condition);
        JgGridListModel jgGridListModel = new JgGridListModel(shipments);
        return jgGridListModel.toJSONString();
    }

}