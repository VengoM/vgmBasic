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
    var userTable;
    $(document).ready(function() {
      userTable = $('#table-user').defaultDataTable( {
        url: ctx + '/user/doQuery.action',
        paramsSelector: '#table-user-params',
        mutliSelect: false,
        columns: [
          { data: 'id' },
          { data: 'username' },
          { data: 'locked',
            render: function (data, type, row, meta) {
              if (data) {
                return '<a class="fa fa-lock"></a>';
              } else {
                return '<a class="fa fa-unlock"></a>';
              }
            }
          }/*,
          { data: "id",
            orderable: false,
            render: function (data, type, row, meta) {
              var btn = '<div class="btn-group">';
              btn += '<a class="btn btn-primary btn-xs" href="'+ctx+'/dc/taskLog/toPage?eq_taskId='+row.taskId+'"><i class="fa fa-street-view"></i> 角色设置</a>';
              btn += '<a class="btn btn-primary btn-xs" href="'+ctx+'/dc/taskLog/toPage?eq_taskId='+row.taskId+'"><i class="fa fa-group"></i> 组织机构设置</a>';
              btn += '</div>';
              return btn;
            }
          }*/
        ]
      });

    } );

    function reloadTable() {
      userTable.ajax.reload();
    }

    function addUser() {
      userEditor.open({
        operation:'NEW',
        callback: reloadTable
      });
    }

    function lockUser(){
      var selects = userTable.rows('.selected').data();
      if (selects.length>0) {
        if(!selects[0].locked){
          ajaxResult(ctx + '/user/lock.action',{id:selects[0].id},reloadTable);
        } else {
          $.alert({
            title: '提示!',
            content: '账号已锁定！',
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

    function unlockUser(){
      var selects = userTable.rows('.selected').data();
      if (selects.length>0) {
        if(selects[0].locked){
          ajaxResult(ctx + '/user/unlock.action',{id:selects[0].id},reloadTable);
        } else {
          $.alert({
            title: '提示!',
            content: '账号未锁定！',
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

    function resetPassword() {
      var selects = userTable.rows('.selected').data();
      if (selects.length>0) {
        $.confirm({
          title: '提示!',
          content: '确定重置该用户密码？',
          type: 'blue',
          buttons: {
            '确定': function(){
              ajaxResult(ctx + '/user/resetPassword.action',{id:selects[0].id},reloadTable);
            },
            '取消':function(){}
          }
        });

      } else {
        $.alert({
          title: '提示!',
          content: '未选择任何记录！',
          type: 'orange'
        });
      }
    }

    function editUserRole() {
      var selects = userTable.rows('.selected').data();
      if (selects.length>0) {
        roleSelect.open(selects[0].roleIdsList,function (selections){
          var roleIds = [];
          for (var i=0;i<selections.length;i++) {
            roleIds.push(selections[i].id);
          }
          alert(roleIds);
          ajaxResult(ctx + '/user/update.action',{id:selects[0].id,roleIds: roleIds.join(',')},reloadTable);
        });
      } else {
        $.alert({
          title: '提示!',
          content: '未选择任何记录！',
          type: 'orange'
        });
      }
    }

    function editUserOrg() {
      var selects = userTable.rows('.selected').data();
      if (selects.length>0) {
        organizationCheckTree.open(selects[0].organizationIdsList,function (checks){
          var orgIds = [];
          for (var i=0;i<checks.length;i++) {
            orgIds.push(checks[i].id);
          }
          alert(orgIds);
          ajaxResult(ctx + '/user/update.action',{id:selects[0].id,organizationIds: orgIds.join(',')},reloadTable);
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
    用户管理
  </h1>
</section>

<section class="content">
  <div class="row">

    <div class="col-xs-12">

      <div id="div-alert"></div>

      <div class="box">
        <div class="box-header">
          <h3 class="box-title">用户列表</h3>
        </div>
        <div class="box-body">
          <form id="table-user-params">
            <div class="row" >
              <div class="form-group col-sm-4">
                <label for="inputEq_username" class="col-sm-3 control-label">用户名:</label>
                <div class="col-sm-9">
                  <input type="text" class="form-control" id="inputEq_username" name="eq_username">
                </div>
              </div>

            </div>
          </form>

          <div class="row" >
            <div class="col-sm-12">
              <button type="button" class="btn btn-primary btn-sm" onclick="reloadTable();"><i class="fa fa-search"></i> 查询</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="addUser();"><i class="fa fa-plus"></i> 新增</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="resetPassword();"><i class="fa fa-reflesh"></i> 密码重置</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="lockUser();"><i class="fa fa-lock"></i> 锁定</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="unlockUser();"><i class="fa fa-unlock"></i> 解锁</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="editUserRole();"><i class="fa fa-male"></i> 角色配置</button>
              <button type="button" class="btn btn-primary btn-sm" onclick="editUserOrg();"><i class="fa fa-group"></i> 组织配置</button>
            </div>
          </div>

          <table id="table-user" class="table table-bordered table-hover" cellspacing="0" width="100%">
            <thead>
            <tr>
              <th>ID</th>
              <th>用户名</th>
              <th>是否锁定</th>
              <%--<th>操作</th>--%>
            </tr>
            </thead>
          </table>
        </div>
      </div>

    </div>
  </div>
</section>

<%@ include file="/WEB-INF/view/component/user/userEditor.jsp"%>
<%@ include file="/WEB-INF/view/component/organization/organizationCheckTree.jsp"%>
<%@ include file="/WEB-INF/view/component/role/roleSelect.jsp"%>

</body>
</html>
