package com.t28.forest.user.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.t28.forest.core.entity.SysUser;
import org.springframework.stereotype.Repository;

/**
 * @author XiangYuFeng
 * @description 用户DAO层接口
 * @create 2019/11/7
 * @since 1.0.0
 */
@Repository
public interface UserDao extends BaseMapper<SysUser> {
}