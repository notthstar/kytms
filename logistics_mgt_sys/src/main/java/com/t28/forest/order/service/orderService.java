/**
 * @description
 * @author lcy
 * @create 2019/10/30
 * @since 1.0.0
 */
package com.t28.forest.order.service;

import com.t28.forest.order.entity.vo.presco;
import org.springframework.stereotype.Service;

import java.util.List;
public interface orderService {

    List<presco> getPlan(String rc,Object input);
}
