package com.vgm.common.action;

import com.vgm.core.user.entity.User;
import com.vgm.shiro.Constants;
import org.springframework.web.bind.annotation.ModelAttribute;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * baseAction
 * Created by VGM on 2017/5/18.
 */
public class BaseAction {
    protected HttpServletRequest request;

    protected HttpServletResponse response;

    protected HttpSession session;

    @ModelAttribute
    public void setReqAndRes(HttpServletRequest request, HttpServletResponse response){
        this.request = request;
        this.response = response;
        this.session = request.getSession();
    }

    public User getLoginUser() {
        return (User) session.getAttribute(Constants.CURRENT_USER);
    }

    ;
}
