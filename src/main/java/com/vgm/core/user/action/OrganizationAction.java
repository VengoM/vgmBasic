package com.vgm.core.user.action;

import com.vgm.common.Result;
import com.vgm.common.TreeVO;
import com.vgm.common.action.BaseAction;
import com.vgm.core.user.entity.Organization;
import com.vgm.core.user.service.OrganizationService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by VGM on 2017/5/16.
 */
@Controller
@RequestMapping("/organization")
public class OrganizationAction extends BaseAction {

    @Resource
    private OrganizationService organizationService;

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public ModelAndView page(){
        return new ModelAndView("core/organization/list");
    }

    @RequestMapping(value = "/tree.action",method = RequestMethod.GET)
    @ResponseBody
    public List<TreeVO> tree(){
        return organizationService.tree();
    }

    @RequestMapping(value = "/add.action",method = RequestMethod.POST)
    @ResponseBody
    public Result add(Organization organization){
        try {
            organizationService.createOrganization(organization);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

    @RequestMapping(value = "/update.action",method = RequestMethod.POST)
    @ResponseBody
    public Result update(Organization organization){
        try {
            organizationService.updateOrganization(organization);
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
            organizationService.available(id, true);
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
            organizationService.available(id, false);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

}
