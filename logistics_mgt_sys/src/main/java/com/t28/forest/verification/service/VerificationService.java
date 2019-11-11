/**
 * @description
 * @author lcy
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.verification.service;

import com.t28.forest.verification.vo.VerificationVo;

import java.util.List;

public interface VerificationService {
    List<VerificationVo> getBill(int status);
}
