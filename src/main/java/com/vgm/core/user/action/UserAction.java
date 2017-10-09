package com.vgm.core.user.action;

import com.vgm.common.Result;
import com.vgm.common.action.BaseAction;
import com.vgm.core.user.VO.UserVO;
import com.vgm.core.user.entity.User;
import com.vgm.core.user.query.UserDBParam;
import com.vgm.core.user.service.UserService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by VGM on 2017/5/16.
 */
@Controller
@RequestMapping("/user")
public class UserAction extends BaseAction {

    @Resource
    private UserService userService;

    @RequestMapping("/doQuery.action")
    @ResponseBody
    public Page<UserVO> doQuery(UserDBParam param, Pageable pageable){
        Page<User> page = userService.query(param, pageable);
        List<UserVO> content = new ArrayList<>();
        for(User user: page.getContent()){
            UserVO userVO = new UserVO(user);
            content.add(userVO);
        }
        return new PageImpl<UserVO>(content,pageable,page.getTotalElements());
    }

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public ModelAndView page(){
        return new ModelAndView("core/user/list");
    }

    @RequestMapping(value = "/add.action",method = RequestMethod.POST)
    @ResponseBody
    public Result add(User user){
        try {
            userService.createUser(user);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

    @RequestMapping(value = "/update.action",method = RequestMethod.POST)
    @ResponseBody
    public Result update(User user){
        try {
            userService.updateUser(user);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

//    @RequestMapping(value = "/delete.action",method = RequestMethod.POST)
//    @ResponseBody
//    public Result delete(@RequestParam(value = "id") Long id){
//        try {
//            userService.deleteUser(id);
//            return new Result(true);
//        } catch (Exception e) {
//            e.printStackTrace();
//            return new Result(false,e.getMessage());
//        }
//    }

    @RequestMapping(value = "/lock.action",method = RequestMethod.POST)
    @ResponseBody
    public Result lock(@RequestParam(value = "id") Long id){
        try {
            userService.lock(id);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

    @RequestMapping(value = "/unlock.action",method = RequestMethod.POST)
    @ResponseBody
    public Result unlock(@RequestParam(value = "id") Long id){
        try {
            userService.unlock(id);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

    @RequestMapping(value = "/resetPassword.action",method = RequestMethod.POST)
    @ResponseBody
    public Result resetPassword(@RequestParam(value = "id") Long id){
        try {
            userService.resetPassword(id);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }
}
