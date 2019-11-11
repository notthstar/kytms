/**
 * @description 实现业务逻辑类
 * @author HF
 * @create 2019/11/6
 * @since 1.0.0
 */
package com.t28.forest.stock.service.impl;



import com.t28.forest.core.vo.PageVO;
import com.t28.forest.stock.condition.MyCondition;
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
    public List<StockInquiryVO> getAllStuotkInquiry(PageVO page, MyCondition myCondition) {
        MyCondition myCondition1=new MyCondition();
        myCondition1.setId("402881a36710579c016710c4e2fb0230");
        myCondition1.setType(1);
        page.calaTotalPage(stuotkInquiryDao.getAllCount(myCondition1));
        return stuotkInquiryDao.getAllStuotkInquiry(page,myCondition);
    }

    @Override
    public List<InOutRecordsVO> getAllInOutRecords(PageVO page) {
        MyCondition myCondition=new MyCondition();
        myCondition.setId("402881a36710579c016710c4e2fb0230");
        page.calaTotalPage(stuotkInquiryDao.getCountInOutRecords(myCondition));
        return stuotkInquiryDao.getAllInOutRecords(page);
    }
}
