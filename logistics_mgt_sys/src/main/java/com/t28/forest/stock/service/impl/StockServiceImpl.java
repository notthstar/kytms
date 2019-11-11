/**
 * @description 实现业务逻辑类
 * @author HF
 * @create 2019/11/6
 * @since 1.0.0
 */
package com.t28.forest.stock.service.impl;
import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.stock.dao.StuotkInquiryDao;
import com.t28.forest.stock.service.StockService;
import com.t28.forest.stock.vo.InOutRecordsVO;
import com.t28.forest.stock.vo.StockInquiryVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class StockServiceImpl  implements StockService {

    @Autowired
    private StuotkInquiryDao stuotkInquiryDao;
    @Override
    public List<StockInquiryVO> getAllStuotkInquiry(PageVO page, Condition condition) {
        page.calaTotalPage(stuotkInquiryDao.getAllCount());
        return stuotkInquiryDao.getAllStuotkInquiry(page,condition);
    }

    @Override
    public List<InOutRecordsVO> getAllInOutRecords(PageVO page,Condition condition) {
        page.calaTotalPage(stuotkInquiryDao.getCountInOutRecords());
        return stuotkInquiryDao.getAllInOutRecords(page,condition);
    }
}
