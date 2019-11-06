/**
 * @description 测试方法
 * @author HF
 * @create 2019/10/30
 * @since 1.0.0
 */
package com.t28.forest.stock;

import com.t28.forest.stock.condition.Condition;
import com.t28.forest.stock.dao.StuotkInquiryDao;
import com.t28.forest.stock.vo.InOutRecordsVO;
import com.t28.forest.stock.vo.StockInquiryVO;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.List;

@RunWith(SpringRunner.class)
@SpringBootTest
public class StockJuintTest {

    @Autowired
    private StuotkInquiryDao stuotkInquiryDao;


    /**
     * 测试查询页面通用显示方法
     */
    @Test
    public void select(){
        Condition condition=new Condition();
        condition.setId("402881a36710579c016710c4e2fb0230");
        condition.setType(0);
        List<StockInquiryVO> allStuotkInquiry = stuotkInquiryDao.getAllStuotkInquiry(condition);
        for (StockInquiryVO stockInquiryDTO : allStuotkInquiry) {
            System.out.println(stockInquiryDTO);
        }
    }
    /**
     * 功能描述:测试查询总条数方法
     * @param:
     * @return:
     * @since: 1.0.0
     * @Author:
     * @Date:
     */
    @Test
    public void selectcount(){
        Condition condition=new Condition();
        condition.setId("402881a36710579c016710c4e2fb0230");
        condition.setType(0);
        Integer allCount = stuotkInquiryDao.getAllCount(condition);
        System.out.println(allCount);
    }

    @Test
    public void  selectInout(){
        Condition condition=new Condition();
        condition.setId("402881a36710579c016710c4e2fb0230");
        List<InOutRecordsVO> allInOutRecords = stuotkInquiryDao.getAllInOutRecords(condition);
        for (InOutRecordsVO allInOutRecord : allInOutRecords) {
            System.out.println(allInOutRecord);
        }
    }
    @Test
    public void selectCount(){
        Condition condition=new Condition();
        condition.setId("402881a36710579c016710c4e2fb0230");
        Integer countInOutRecords = stuotkInquiryDao.getCountInOutRecords(condition);
        System.out.println(countInOutRecords);
    }
}
