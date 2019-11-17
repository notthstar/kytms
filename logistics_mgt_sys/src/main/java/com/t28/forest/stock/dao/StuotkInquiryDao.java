/**
 * @description 库存查询
 * @author HF
 * @create 2019/10/29
 * @since 1.0.0
 */
package com.t28.forest.stock.dao;


import com.t28.forest.core.cond.Condition;
import com.t28.forest.core.vo.PageVO;
import com.t28.forest.stock.vo.InOutRecordsVO;
import com.t28.forest.stock.vo.StockInquiryVO;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface StuotkInquiryDao {
   /**
    * 功能描述: 所有在线查询显示页面
    * @param:
    * @return:// STOPSHIP:
    * @since: 1.0.0
    * @Author:
    * @Date:   2019/10/29
    */
    public List<StockInquiryVO> getAllStuotkInquiry(@Param("pageVO")PageVO pageVO,@Param("condition")Condition condition);
    /**
     * 功能描述: 查询总条数
     * @param:stockInquiryDTO
     * @return:integer
     * @since: 1.0.0
     * @Author:
     * @Date:
     */
    public Integer getAllCount();
    /**
     * 功能描述:查询出入库
     * @param: condition
     * @return: List
     * @since: 1.0.0
     * @Author: HF
     * @Date:
     */
    public  List<InOutRecordsVO> getAllInOutRecords(@Param("pageVO")PageVO pageVO,@Param("condition")Condition condition);
    /**
     * 功能描述: 查询出入库总条数
     * @param: condition
     * @return: Integer
     * @since: 1.0.0
     * @Author: HF
     * @Date:
     */
    public  Integer getCountInOutRecords();
}
