package com.vgm.shiro.filter;

import com.vgm.core.user.service.UserService;
import com.vgm.shiro.Constants;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.web.filter.PathMatchingFilter;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/*
 * 用于根据当前登录用户身份获取 User信息放入 request； 然后就可以通过 request获取 User
 */
public class SysUserFilter extends PathMatchingFilter {

    @Autowired
    private UserService userService;

    @Override
    protected boolean onPreHandle(ServletRequest request, ServletResponse response, Object mappedValue) throws Exception {

    	if(SecurityUtils.getSubject().isAuthenticated()) {
            String username = (String)SecurityUtils.getSubject().getPrincipal();
//            request.setAttribute(Constants.CURRENT_USER, userService.findByUsername(username));
            SecurityUtils.getSubject().getSession().setAttribute(Constants.CURRENT_USER, userService.findByUsername(username));
    	}
        return true;
    }
}
