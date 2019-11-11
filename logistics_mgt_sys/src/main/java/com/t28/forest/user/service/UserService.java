package com.t28.forest.user.service;

import com.t28.forest.core.entity.SysUser;

/**
 * @author XiangYuFeng
 * @description 用户业务逻辑层接口
 * @create 2019/11/7
 * @since 1.0.0
 */
public interface UserService {

    /**
     * 用户登录的方法
     * @param userName
     * @param password
     * @return SysUser
     */
    public SysUser login(String userName, String password);

    /**
     * 用户注册的方法
     * @param sysUser
     * @return Integer
     */
    public Integer register(SysUser sysUser);

    /**
     * 根据用户ID修改用户信息
     * @return Integer
     */
    public Integer updateUserInfo(SysUser sysUser);

}
