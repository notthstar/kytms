package com.t28.forest.interceptor;

import com.t28.forest.core.entity.SysUser;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Objects;

/**
 * @author XiangYuFeng
 * @description 登录拦截器
 * @create 2019/11/13
 * @since 1.0.0
 */
public class LoginInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        SysUser user = (SysUser) request.getSession().getAttribute("loginUser");
        if (!Objects.isNull(user)) {
            // 用户已经登陆，放行
            return true;
        }
        // 用户未登录，不放行
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
}