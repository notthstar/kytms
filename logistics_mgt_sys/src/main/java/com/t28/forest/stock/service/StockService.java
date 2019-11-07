/**
 * 类名称:StockService
 *
 * @description 业务逻辑接口
 * @Author:HF
 * @Date: 2019/11/6$ 10:26$
 * @since: 1.0.0
 */
package com.t28.forest.stock.service;


import com.t28.forest.core.vo.PageVO;
import com.t28.forest.stock.condition.Condition;
import com.t28.forest.stock.vo.InOutRecordsVO;
import com.t28.forest.stock.vo.StockInquiryVO;

import java.util.List;

public interface StockService {
    /**
     * 功能描述: 在库操作的所有显示页面
     * @param:
     * @return:// STOPSHIP:
     * @since: 1.0.0
     * @Author:
     * @Date:   2019/10/29
     */
    public List<StockInquiryVO> getAllStuotkInquiry(PageVO page, Condition condition);
    /**
     * 功能描述:出入库查询
     * @param: condition
     * @return: List
     * @since: 1.0.0
     * @Author: HF
     * @Date:
     */
    public List<InOutRecordsVO> getAllInOutRecords(PageVO page, Condition condition);
}

