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
  <title>组织机构管理</title>
  <%@ include file="/static/common/adminLTE-conf.jsp"%>
  <%@ include file="/static/common/dataTables-conf.jsp"%>
  <script src="${ctx}/static/module/jquery/jquery.form.js"></script>
  <link rel="stylesheet" href="${ctx}/static/module/bootstrap-treeview/css/bootstrap-treeview.css">
  <script type="text/javascript" src="${ctx}/static/module/bootstrap-treeview/js/bootstrap-treeview.js"></script>
  <script>
    //<![CDATA[
    var organizationTree;
    $(document).ready(function() {
      loadTree();
    } );

    function loadTree(){
      $.ajax({
        url: ctx + '/organization/tree.action',
        type: 'get',
        dataType:'json',
        async: false,
        success: function(data) {

          setIcon(data);

          organizationTree = $('#tree-organization').treeview({
            expandIcon: "fa fa-plus",
            collapseIcon: "fa fa-minus",
            nodeIcon: "fa fa-bars",
            showTags: true,
            multiSelect: false,
            highlightSelected: true,
            data: data,
            onNodeSelected: function(event, node) {
              if (!node.attributes.rootNode) {
                $('#add-btn-org').hide();
                $('#update-btn-org').show();
                $('#form-organization').loadForm(node.attributes);
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
        } else {
          temp.icon = 'fa fa-group';
        }
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
      organizationTree.treeview('search', [ $('#inputLike_name').val(), { ignoreCase: true, exactMatch: false } ]);
    }

    function getSelectNode(callback){
      var nodes = organizationTree.treeview('getSelected');
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

    function toAddOrganization(){
      getSelectNode(function(nodes){
        $('#add-btn-org').show();
        $('#update-btn-org').hide();
        $('#form-organization').resetForm();
        $('#form-organization input[type=hidden]').val('');
        $('#form-organization input[name=parentId]').val(nodes[0].attributes.id);
        $('#form-organization input[name=parentIds]').val(nodes[0].attributes.parentIds+nodes[0].attributes.id+'/');
      });
    }

    function addOrganization(){
      ajaxResult(ctx+'/organization/add.action',$('#form-organization').serialize(),loadTree);
    }

    function updateOrganization(){
      ajaxResult(ctx+'/organization/update.action',$('#form-organization').serialize(),loadTree);
    }

    function disableOrganization(){
      getSelectNode(function(nodes){
        if (!nodes[0].attributes.rootNode) {
          ajaxResult(ctx+'/organization/disable.action',{id:nodes[0].id},loadTree);
        } else {
          $.alert({
            title: '提示',
            content: '不允许操作根节点！',
            type: 'orange'
          });
        }
      });

    }

    function enableOrganization(){
      getSelectNode(function(nodes){
        if (!nodes[0].attributes.rootNode) {
          ajaxResult(ctx+'/organization/enable.action',{id:nodes[0].id},loadTree);
        } else {
          $.alert({
            title: '提示',
            content: '不允许操作根节点！',
            type: 'orange'
          });
        }
      });
    }

    function searchOrganization(){
      organizationTree.treeview('search', [ $('#inputLike_name').val(), { ignoreCase: true, exactMatch: false } ]);
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
                  <h3 class="box-title">组织机构管理</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">

                  <form id="tree-organization-params">
                    <div class="row" >
                      <div class="form-group col-sm-12">
                        <label for="inputLike_name" class="col-sm-3 control-label">组织机构名:</label>
                        <div class="col-sm-9">
                          <input type="text" class="form-control" id="inputLike_name" name="eq_name">
                        </div>
                      </div>
                    </div>
                  </form>

                  <div class="col-sm-12">
                    <button type="button" class="btn btn-primary" onclick="searchOrganization();"><i class="fa fa-search"></i> 查询</button>
                    <button type="button" class="btn btn-primary" onclick="toAddOrganization();"><i class="fa fa-plus"></i> 新增</button>
                    <button type="button" class="btn btn-primary" onclick="disableOrganization();"><i class="fa fa-close"></i> 停用</button>
                    <button type="button" class="btn btn-primary" onclick="enableOrganization();"><i class="fa fa-check"></i> 启用</button>
                  </div>

                  <div class="col-sm-12">
                    <div id="tree-organization" style="padding-top: 5px;"></div>
                  </div>
                </div>
                <!-- /.box-body -->
              </div>
            </div>

            <div class="col-sm-6">
              <div class="box box-primary">
                <div class="box-header with-border">
                  <h3 class="box-title">组织机构信息</h3>
                </div>
                <!-- /.box-header -->
                <div class="box-body">

                  <form class="form-horizontal" id="form-organization" style="border-top: 5px;">

                    <div class="form-group">
                      <label for="inputName" class="col-sm-2 control-label">组织机构名</label>

                      <div class="col-sm-10">
                        <input type="hidden" name="id">
                        <input type="text" class="form-control" id="inputName" name="name">
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
                    <button id="update-btn-org" type="button" class="btn btn-primary" style="display: none;" onclick="updateOrganization();"><i class="fa fa-edit"></i> 保存修改</button>
                    <button id="add-btn-org" type="button" class="btn btn-primary" style="display: none;" onclick="addOrganization();"><i class="fa fa-edit"></i> 新增</button>
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
