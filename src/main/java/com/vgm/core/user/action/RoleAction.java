package com.vgm.core.user.action;

import com.vgm.common.Result;
import com.vgm.common.action.BaseAction;
import com.vgm.core.user.entity.Role;
import com.vgm.core.user.query.RoleDBParam;
import com.vgm.core.user.service.RoleService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;

/**
 * Created by VGM on 2017/5/16.
 */
@Controller
@RequestMapping("/role")
public class RoleAction extends BaseAction {

    @Resource
    private RoleService roleService;

    @RequestMapping("doQuery.action")
    @ResponseBody
    public Page<Role> doQuery(RoleDBParam param, Pageable pageable){
        if (StringUtils.isNotBlank(param.getLike_role())) {
            param.setLike_role('%'+param.getLike_role()+'%');
        }
        return roleService.doQuery(param, pageable);
    }

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public ModelAndView page(){
        return new ModelAndView("core/role/list");
    }

    @RequestMapping(value = "/add.action",method = RequestMethod.POST)
    @ResponseBody
    public Result add(Role role){
        try {
            roleService.createRole(role);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

    @RequestMapping(value = "/update.action",method = RequestMethod.POST)
    @ResponseBody
    public Result update(Role role){
        try {
            roleService.updateRole(role);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

    @RequestMapping(value = "/delete.action",method = RequestMethod.POST)
    @ResponseBody
    public Result delete(@RequestParam(value = "id") Long id){
        try {
            roleService.deleteRole(id);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

    @RequestMapping(value = "/enable.action",method = RequestMethod.POST)
    @ResponseBody
    public Result enable(@RequestParam(value = "id") Long id){
        try {
            roleService.available(id,true);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

    @RequestMapping(value = "/disable.action",method = RequestMethod.POST)
    @ResponseBody
    public Result disable(@RequestParam(value = "id") Long id){
        try {
            roleService.available(id,false);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }
}
