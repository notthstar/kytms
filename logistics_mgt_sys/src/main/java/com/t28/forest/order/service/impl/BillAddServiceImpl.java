/**
 * @description
 * @author lcy
 * @create 2019/11/7
 * @since 1.0.0
 */
package com.t28.forest.order.service.impl;

import com.t28.forest.order.dao.BillAdd;
import com.t28.forest.order.service.BillAddService;
import com.t28.forest.order.vo.ServerZone;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BillAddServiceImpl implements BillAddService {
    @Autowired
    BillAdd dao;

    @Override
    public List<ServerZone> getZone() {
        return dao.selectZone();
    }
}
