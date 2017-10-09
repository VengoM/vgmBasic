package com.vgm.core.user.action;

import com.vgm.common.Result;
import com.vgm.common.TreeVO;
import com.vgm.common.action.BaseAction;
import com.vgm.core.user.entity.Resources;
import com.vgm.core.user.query.ResourcesDBParam;
import com.vgm.core.user.service.ResourcesService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
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
@RequestMapping("/resources")
public class ResourcesAction extends BaseAction {

    @Resource
    private ResourcesService resourcesService;

    @RequestMapping("")
    @ResponseBody
    public Page<Resources> resources(Pageable pageable){
        return resourcesService.findAll(pageable);
    }

    @RequestMapping("/tree.action")
    @ResponseBody
    public List<TreeVO> tree(ResourcesDBParam param){
        return resourcesService.tree(param);
    }

    @RequestMapping(value = "/list",method = RequestMethod.GET)
    public ModelAndView page(){
        return new ModelAndView("core/resources/list");
    }

    @RequestMapping(value = "/add.action",method = RequestMethod.POST)
    @ResponseBody
    public Result add(Resources resources){
        try {
            resourcesService.createResource(resources);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }

    @RequestMapping(value = "/update.action",method = RequestMethod.POST)
    @ResponseBody
    public Result update(Resources resources){
        try {
            resourcesService.updateResource(resources);
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
            resourcesService.deleteResource(id);
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
            resourcesService.available(id,false);
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
            resourcesService.available(id,true);
            return new Result(true);
        } catch (Exception e) {
            e.printStackTrace();
            return new Result(false,e.getMessage());
        }
    }
}
