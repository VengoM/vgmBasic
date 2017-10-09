<%--
  Created by IntelliJ IDEA.
  User:  vengo_mo
  Date: 2017/8/9
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
  function taskEditor(operation,row,callback){
    var content = /*'<div class="row">'
            +*/'  <div class="col-sm-12">'
            +'    <form class="form-horizontal" id="comp-taskEditor-form">'
            +'      <input type="hidden" name="taskId">'
            +'      <div class="form-group">'
            +'        <label for="inputTaskName" class="col-sm-2 control-label">任务名</label>'
            +'        <div class="col-sm-10">'
            +'          <input type="text" class="form-control" id="inputTaskName" name="taskName" placeholder="任务名">'
            +'        </div>'
            +'      </div>'
            +'      <div class="form-group">'
            +'        <label for="inputTaskDescription" class="col-sm-2 control-label">描述</label>'
            +'        <div class="col-sm-10">'
            +'          <textarea type="text" class="form-control" id="inputTaskDescription" name="taskDescription" rows="3" placeholder="描述"></textarea>'
            +'        </div>'
            +'      </div>'
            +'      <div class="form-group">'
            +'        <label for="inputNameJob" class="col-sm-2 control-label">作业</label>'
            +'        <div class="col-sm-10">'
            +'          <div class="input-group input-group-sm">'
            +'            <input type="hidden" name="idJob">'
            +'            <input type="text" class="form-control" id="inputNameJob" name="nameJob" placeholder="作业" readonly="readonly">'
            +'            <span class="input-group-btn">'
            +'              <button type="button" class="btn btn-primary btn-flat" onclick="selectJob();">选择</button>'
            +'            </span>'
            +'          </div>'
            +'        </div>'
            +'      </div>'
            +'      <div class="form-group">'
            +'        <label for="inputCronExpression" class="col-sm-2 control-label">周期</label>'
            +'        <div class="col-sm-10">'
            +'          <input type="text" class="form-control" id="inputCronExpression" name="cronExpression" placeholder="周期">'
            +'        </div>'
            +'      </div>'
            +'    </form>'
            +'  </div>'
           /* +'</div>'*/;

    var buttoms = {
      '取消': function () {
      }
    };
    if(operation=='NEW'||operation=='UPDATE') {
      buttoms['确定']=function(){
        var url = '';
        if (operation=='NEW') {
          url = '/dc/task/add.action';
        } else if (operation=='UPDATE') {
          url = '/dc/task/update.action';
        }
        ajaxResult(ctx + url,$('#comp-taskEditor-form').serialize(),function(){
          callback();
        });
      }
    }

    $.confirm({
      title: '',
      content: content,
      type: 'blue',
      draggable: true,
      typeAnimated: true,
      columnClass: 'col-sm-6 col-sm-offset-3',
      onContentReady: function () {
        if(operation=='VIEW'||operation=='UPDATE'){
          $('#comp-taskEditor-form').loadForm(row);
        }
      },
      buttons: buttoms
    });

  }
  function selectJob(){
    jobAndTransSel('JOB',false,function(row){
      $('#comp-taskEditor-form input[name=idJob]').val(row.id);
      $('#comp-taskEditor-form input[name=nameJob]').val(row.name);
    });
  }



</script>

<%@ include file="/WEB-INF/view/component/kettle/JobAndTransSelect.jsp"%>