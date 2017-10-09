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
  <title>角色管理</title>
  <%@ include file="/static/common/adminLTE-conf.jsp"%>
  <%@ include file="/static/common/dataTables-conf.jsp"%>
  <script src="${ctx}/static/module/jquery/jquery.form.js"></script>
  <link rel="stylesheet" href="${ctx}/static/module/bootstrap-treeview/css/bootstrap-treeview.css">
  <script type="text/javascript" src="${ctx}/static/module/bootstrap-treeview/js/bootstrap-treeview.js"></script>
  <script>
    //<![CDATA[
    var roleTable;
    $(document).ready(function() {
      roleTable = $('#table-role').defaultDataTable( {
        url: ctx + '/role/doQuery.action',
        paramsSelector: '#table-role-params',
        mutliSelect: false,
        columns: [
          { data: 'id', orderable:false },
          { data: 'role' },
          { data: 'description', orderable:false},
          { data: "available",
            orderable: false,
            render: function (data, type, row, meta) {
              if (data) {
                return '<span class="label label-success">有效</span>';
              } else {
                return '<span class="label label-danger">无效</span>';
              }
            }
          }
        ]
      });

    } );

    function reloadTable() {
      roleTable.ajax.reload();
    }

    function addRole() {
      roleEditor.open({
        operation: 'NEW',
        callback: reloadTable
      });
    }

    function enableRole(){
      var selects = roleTable.rows('.selected').data();
      if (selects.length>0) {
        if(!selects[0].available){
          ajaxResult(ctx + '/role/enable.action',{id:selects[0].id},reloadTable);
        } else {
          $.alert({
            title: '提示!',
            content: '角色已生效！',
            type: 'orange'
          });
        }
      } else {
        $.alert({
          title: '提示!',
          content: '未选择任何记录！',
          type: 'orange'
        });
      }
    }

    function disableRole(){
      var selects = roleTable.rows('.selected').data();
      if (selects.length>0) {
        if(selects[0].available){
          ajaxResult(ctx + '/role/disable.action',{id:selects[0].id},reloadTable);
        } else {
          $.alert({
            title: '提示!',
            content: '角色已失效！',
            type: 'orange'
          });
        }
      } else {
        $.alert({
          title: '提示!',
          content: '未选择任何记录！',
          type: 'orange'
        });
      }
    }

    function checkRecource(){
      var selects = roleTable.rows('.selected').data();
      if (selects.length>0) {
        var defaultCHeck = selects[0].resourceIds.split(',');
        resourceCheckTree.open(defaultCHeck,function (checks){
          var resourceIds = [];
          for (var i=0;i<checks.length;i++) {
            resourceIds.push(checks[i].id);
          }
          ajaxResult(ctx + '/role/update.action',{id:selects[0].id,resourceIds: resourceIds.join(',')},reloadTable);
        });
      } else {
        $.alert({
          title: '提示!',
          content: '未选择任何记录！',
          type: 'orange'
        });
      }
    }

    //]]>
  </script>
</head>
<body style="background: #ecf0f5;">

<section class="content-header">
  <h1>
    角色管理
  </h1>
</section>

<section class="content">
  <div class="row">

    <div class="col-xs-12">

      <div id="div-alert"></div>

      <div class="box">
        <%--<div class="box-header">
          <h3 class="box-title"></h3>
        </div>--%>
        <div class="box-body">
          <form id="table-role-params">
            <div class="row" >
              <div class="form-group col-sm-4">
                <label for="inputLike_role" class="col-sm-3 control-label">角色:</label>
                <div class="col-sm-9">
                  <input type="email" class="form-control" id="inputLike_role" name="like_role">
                </div>
              </div>
            </div>
          </form>

          <div class="row" >
            <div class="col-sm-12">
              <button type="button" class="btn btn-primary btn-sm" onclick="reloadTable();"><i class="fa fa-search"></i> 查询</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="addRole();"><i class="fa fa-plus"></i> 新增</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="disableRole();"><i class="fa fa-lock"></i> 锁定</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="enableRole();"><i class="fa fa-unlock"></i> 解锁</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="checkRecource();"><i class="fa fa-unlock"></i> 资源分配</button>
            </div>
          </div>

          <table id="table-role" class="table table-bordered table-hover" cellspacing="0" width="100%">
            <thead>
            <tr>
              <th>ID</th>
              <th>角色</th>
              <th>描述</th>
              <th>状态</th>
            </tr>
            </thead>
          </table>
        </div>

    </div>
  </div>
</section>

<%@ include file="/WEB-INF/view/component/role/roleEditor.jsp"%>
<%@ include file="/WEB-INF/view/component/resources/resourceCheckTree.jsp"%>

</body>
</html>
