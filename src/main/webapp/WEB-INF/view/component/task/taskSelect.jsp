<%--
  Created by IntelliJ IDEA.
  User:  vengo_mo
  Date: 2017/8/9
  Time: 10:13
  To change this template use File | Settings | File Templates.

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
  function taskSelect(mutliSelect,select){
    var content = '<form id="comp-taskSel-params" class="form-horizontal">'
            /*+'          <div class="row" >'*/
            +'            <label for="inputEq_taskName" class="col-sm-2 control-label">任务名:</label>'
            +''
            +'            <div class="col-sm-8">'
            +'              <input type="text" class="form-control" name="eq_taskName" id="inputEq_taskName" placeholder="任务名">'
            +'            </div>'
            +''
            +'            <div>'
            +'              <button type="button" class="btn btn-primary btn-sm" onclick="taskSelModal.taskTableReload();"><i class="fa fa-search"></i> 查询</button>'
            +'            </div>'
            /*+'          </div>'*/
            +'        </form>'
            +''
            /*+'        <div class="row">'*/
            +'          <div class="col-sm-12">'
            +''
            +'            <table id="comp-taskSel-table" class="table table-bordered table-hover" cellspacing="0" width="100%">'
            +'              <thead>'
            +'              <tr>'
            +'                <th>任务ID</th>'
            +'                <th>任务名</th>'
            +'                <th>运行状态</th>'
            +'                <th>是否启用</th>'
            +'                <th>最新执行结果</th>'
            +'              </tr>'
            +'              </thead>'
            +'            </table>'
            +'          </div>'
            /*+'        </div>'*/;

    $.confirm({
      title: '',
      content: content,
      type: 'blue',
      draggable: true,
      typeAnimated: true,
      columnClass: 'col-sm-12',
      onContentReady: function () {
        $('#comp-taskSel-table').defaultDataTable({
          url: ctx + '/dc/task/doQuery.action',
          paramsSelector: '#comp-taskSel-params',
          mutliSelect: false,
          columns: [
            { data: 'taskId', orderable: false },
            { data: 'taskName', orderable: false },
            { data:'isRunning',
              render: function(data, type, row, meta){
                if (data){
                  return '正在运行';
                } else {
                  return '停止';
                }
              }
            },
            { data: 'isValid',
              render: function(data, type, row, meta){
                if (data){
                  return '<span class="label label-success">启用</span>';
                } else {
                  return '<span class="label label-danger">停用</span>';
                }
              }
            },
            { data: 'lastResult',
              render: function (data, type, row, meta) {
                if (data == '1') {
                  return '<span class="label label-success">成功</span>';
                } else {
                  return '<span class="label label-danger">失败</span>';
                }
              }
            }
          ]
        });
      },
      buttons: {
        '确定': function () {
          var selections = $('#comp-taskSel-table').DataTable().rows('.selected').data();
          if (selections.length > 0){
            if (mutliSelect) {
              select(selections);
            } else {
              select(selections[0]);
            }
          } else {
            $.alert({
              title: '提示',
              content: '请选择记录！',
              type: 'orange'
            });
          }
        },
        '取消': function () {

        }
      }
    });

  }

  function taskSelectReload () {
    $('#comp-taskSel-table').DataTable().ajax.reload();
  }

</script>