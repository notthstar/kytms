/**
 * @description
 * @author lcy
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.verification.service.impl;

import com.t28.forest.verification.dao.VerificationDao;
import com.t28.forest.verification.service.VerificationService;
import com.t28.forest.verification.vo.VerificationVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VerificationServiceImpl implements VerificationService {
    @Autowired
    VerificationDao dao;

    @Override
    public List<VerificationVo> getBill(int status) {
        return dao.selectBill(status);
    }
}
