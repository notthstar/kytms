package com.t28.forest.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.t28.forest.core.entity.SysUser;
import com.t28.forest.user.dao.UserDao;
import com.t28.forest.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author XiangYuFeng
 * @description 用户业务逻辑层实现类
 * @create 2019/11/7
 * @since 1.0.0
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;

    @Override
    public SysUser login(String userName, String password) {
        return userDao.selectOne(new QueryWrapper<SysUser>().eq("code", userName).eq("password", password));
    }

    @Override
    public Integer register(SysUser sysUser) {
        return userDao.insert(sysUser);
    }

    @Override
    public Integer updateUserInfo(SysUser sysUser) {
        return userDao.updateById(sysUser);
    }
}