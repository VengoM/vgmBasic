package com.vgm.core.main.action;

import com.vgm.common.Result;
import com.vgm.common.action.BaseAction;
import com.vgm.core.user.service.ResourcesService;
import com.vgm.shiro.realm.UserRealm;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Set;

/**
 * Created by VGM on 2017/5/16.
 */
@Controller
@RequestMapping("/")
public class LoginAction extends BaseAction {

    @Resource
    private ResourcesService resourcesService;

    @Resource
    private UserRealm userRealm;

    /**
     * 主页面
     * @return
     */
    @RequestMapping("/")
    public ModelAndView index(){
        ModelAndView mav = new ModelAndView("index");
        List menus = resources();
        mav.addObject("menus", menus);
        return mav;
    }

    /**
     * 登录页面
     * @return
     */
    @RequestMapping("/login/page")
    public ModelAndView loginPage(){
        ModelAndView mav = new ModelAndView("login");
        try {
            String url = WebUtils.getSavedRequest(request).getRequestUrl();
            mav.addObject("redirectUrl",url);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mav;
    }

    /**
     * 登录
     * @return
     */
    @RequestMapping("login.do")
    @ResponseBody
    public Result login(@RequestParam("username")String username, @RequestParam("password")String password){
        try
        {
            Subject subject = SecurityUtils.getSubject();
            if(!subject.isAuthenticated()){
                UsernamePasswordToken token= new UsernamePasswordToken(username,password);
                subject.login(token);
                HttpSession session = request.getSession();
                //将用户名保存在session中
                session.setAttribute("username", username);
            }
            return new Result(true);
        } catch (UnknownAccountException e) {
            return new Result(false,"账号/密码错误");
        } catch (IncorrectCredentialsException e) {
            return new Result(false,"账号/密码错误");
        } catch (LockedAccountException e) {
            return new Result(false,"账号锁定");
        } catch (AuthenticationException e) {
            return new Result(false,"未知错误");
        }
    }

    /**
     * 退出
     * @return
     */
    @RequestMapping("logout.do")
    @ResponseBody
    public Result logout(){
        try
        {
            Subject subject = SecurityUtils.getSubject();
            subject.logout();
            return new Result(true);
        } catch (Exception ex) {
            System.out.println(ex);
            return new Result(false,ex.getMessage());
        }
    }

    /**
     * 当前用户菜单
     * @return
     */
    @RequestMapping("/menus")
    @ResponseBody
    public List resources() {
        AuthorizationInfo authorizationInfo = userRealm.getAuthorizationInfo(SecurityUtils.getSubject().getPrincipals());
        Set<String> permission = (Set<String>) authorizationInfo.getStringPermissions();
        return resourcesService.treeMenus(permission);
    }
}
