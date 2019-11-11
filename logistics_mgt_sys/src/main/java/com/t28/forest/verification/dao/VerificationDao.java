/**
 * @description
 * @author lcy
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.verification.dao;

import com.t28.forest.verification.vo.VerificationVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import java.util.List;

@Mapper
@Component
public interface VerificationDao {
    /**
     * 功能描述: 查询干线成本核销，status=9999是未核销，=0是部分核销，=1是已核销
     * @param: No such property: code for class: Script1
     * @return: 
     * @since: 1.0.0
     * @Author: lcy
     * @Date: 2019/11/7 9:47
     */
    List<VerificationVo> selectBill(@Param("status") int status);
    

}
