<%--
  Created by IntelliJ IDEA.
  User:  vengo_mo
  Date: 2017/6/28
  Time: 18:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
  <%@ include file="/static/common/common.jsp"%>
  <title>日志管理</title>
  <%@ include file="/static/common/adminLTE-conf.jsp"%>
  <%@ include file="/static/common/dataTables-conf.jsp"%>
  <script src="${ctx}/static/module/jquery/jquery.form.js"></script>
  <link rel="stylesheet" href="${ctx}/static/module/bootstrap-treeview/css/bootstrap-treeview.css">
  <script type="text/javascript" src="${ctx}/static/module/bootstrap-treeview/js/bootstrap-treeview.js"></script>
  <script>
    //<![CDATA[
    var resourceTree;
    $(document).ready(function() {
      loadTree();
    });

    function loadTree(){
      $.ajax({
        url: ctx + '/resources/tree.action',
        type: 'get',
        dataType:'json',
        async: false,
        success: function(data) {

          setIcon(data);

          resourceTree = $('#tree-resource').treeview({
            expandIcon: "fa fa-plus",
            collapseIcon: "fa fa-minus",
//            nodeIcon: "fa fa-bars",
            showTags: true,
            multiSelect: false,
            highlightSelected: true,
            data: data,
            onNodeSelected: function(event, node) {
              if (!node.attributes.rootNode) {
                $('#add-btn-res').hide();
                $('#update-btn-res').show();
                $('#form-resources').loadForm(node.attributes);
              }
            }
          });
        },
        error: function(){
          $.alert({
            title:'提示',
            content: '请求服务器失败！',
            type: 'red'
          });
        }
      });
    }

    //设置对应图标
    function setIcon(data){
      for(var i=0;i<data.length;i++){
        var temp = data[i];
        if(temp.attributes.rootNode) {
          temp.icon = 'fa fa-list';
        } else if (temp.attributes.type=='menu') {
          temp.icon = temp.attributes.icon;
        } else if (temp.attributes.type=='button') {
          temp.icon = 'fa fa-pencil';
        }

        if(!temp.attributes.available) {
          temp.text = '<s>'+temp.text+'</s>';
        }
        temp.text = temp.text + '  <span class="icon node-icon '+temp.icon+'"></span>';
        temp.icon = '';

        if (temp.nodes.length>0) {
          setIcon(temp.nodes);
        } else {
          //tree view展开图标依照数据中是否含有nodes来判断的
          //空也会判断为可展开删除
          delete temp.nodes;
        }
      }
    }

    function searchResources(){
      resourceTree.treeview('search', [ $('#inputLike_name').val(), { ignoreCase: true, exactMatch: false } ]);
    }

    function getSelectNode(callback){
      var nodes = resourceTree.treeview('getSelected');
      if (nodes.length < 1){
        $.alert({
          title: '提示',
          content: '请先从右边选择父节点！',
          type: 'orange'
        });
      } else {
        callback(nodes);
      }
    }

    function toAddResources(){
      getSelectNode(function(nodes){
        $('#add-btn-res').show();
        $('#update-btn-res').hide();
        $('#form-resources').resetForm();
        $('#form-resources input[type=hidden]').val('');
        $('#form-resources input[name=parentId]').val(nodes[0].attributes.id);
        $('#form-resources input[name=parentIds]').val(nodes[0].attributes.parentIds+nodes[0].attributes.id+'/');
      });
    }

    function addResources(){
      ajaxResult(ctx+'/resources/add.action',$('#form-resources').serialize(),loadTree);
    }

    function updateResources(){
      ajaxResult(ctx+'/resources/update.action',$('#form-resources').serialize(),loadTree);
    }

    function disableResources(){
      getSelectNode(function(nodes){
        ajaxResult(ctx+'/resources/disable.action',{id:nodes[0].id},loadTree);
      });

    }

    function enableResources(){
      getSelectNode(function(nodes){
        ajaxResult(ctx+'/resources/enable.action',{id:nodes[0].id},loadTree);
      });
    }

    //]]>
  </script>
</head>
<body style="background: #ecf0f5;">

<section class="content-header">
  <h1>
    资源管理
  </h1>
</section>

<section class="content">
  <div class="row">

    <div class="col-xs-12">

      <div class="box">
        <div class="box-body">
          <div class="row">

            <div class="col-sm-6">
              <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">资源列表</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">

                  <form id="tree-resources-params">
                    <div class="row" >
                      <div class="form-group col-sm-12">
                        <label for="inputLike_name" class="col-sm-3 control-label">资源名:</label>
                        <div class="col-sm-9">
                          <input type="text" class="form-control" id="inputLike_name" name="eq_name">
                        </div>
                      </div>
                    </div>
                  </form>

                  <div class="col-sm-12">
                    <button type="button" class="btn btn-primary" onclick="searchResources();"><i class="fa fa-search"></i> 查询</button>
                    <button type="button" class="btn btn-primary" onclick="toAddResources();"><i class="fa fa-plus"></i> 新增</button>
                    <button type="button" class="btn btn-primary" onclick="disableResources();"><i class="fa fa-close"></i> 停用</button>
                    <button type="button" class="btn btn-primary" onclick="enableResources();"><i class="fa fa-check"></i> 启用</button>
                  </div>

                  <div class="col-sm-12">
                    <div id="tree-resource" style="padding-top: 5px;"></div>
                  </div>
                </div>
                <!-- /.box-body -->
              </div>
            </div>

            <div class="col-sm-6">
              <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">资源信息</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">

                  <form class="form-horizontal" id="form-resources" style="border-top: 5px;">

                    <div class="form-group">
                      <label for="inputName" class="col-sm-2 control-label">资源名称</label>

                      <div class="col-sm-10">
                        <input type="hidden" name="id">
                        <input type="text" class="form-control" id="inputName" name="name">
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="inputType" class="col-sm-2 control-label">类型</label>

                      <div class="col-sm-10">
                        <select class="form-control select2" id="inputType" name="type" style="width: 100%;">
                          <option value="menu" selected="selected">菜单</option>
                          <option value="button">按钮</option>
                        </select>
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="inputUrl" class="col-sm-2 control-label">url</label>

                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputUrl" name="url">
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="inputPermission" class="col-sm-2 control-label">权限标识</label>

                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputPermission" name="permission">
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="inputParentId" class="col-sm-2 control-label">parentId</label>

                      <div class="col-sm-10">
                        <input type="hidden" name="parentIds">
                        <input type="text" class="form-control" id="inputParentId" name="parentId">
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="inputIcon" class="col-sm-2 control-label">icon</label>

                      <div class="col-sm-10">
                        <input type="text" class="form-control" id="inputIcon" name="icon">
                      </div>
                    </div>

                    <div class="form-group">
                      <label for="inputAvailable" class="col-sm-2 control-label">是否有效</label>

                      <div class="col-sm-10">
                        <select class="form-control select2" id="inputAvailable" name="available" style="width: 100%;">
                          <option value='1' selected="selected">有效</option>
                          <option value='0' >无效</option>
                        </select>
                      </div>
                    </div>

                  </form>

                  <div class="pull-right">
                    <button id="update-btn-res" type="button" class="btn btn-primary" style="display: none;" onclick="updateResources();"><i class="fa fa-edit"></i> 保存修改</button>
                    <button id="add-btn-res" type="button" class="btn btn-primary" style="display: none;" onclick="addResources();"><i class="fa fa-edit"></i> 新增</button>
                  </div>
                </div>
                <!-- /.box-body -->
              </div>
            </div>

          </div>

        </div>
      </div>

    </div>
  </div>
</section>
</body>
</html>
