<%--
  Created by IntelliJ IDEA.
  User:  vengo_mo
  Date: 2017/8/9
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
  if(this.userEditor == undefined){
    this.userEditor={
      urlMap : {
        NEW : '/user/add.action'
      }
    };
  }

  userEditor.open = function(opt){
    var content = '<div class="col-sm-12">'
            +'            <form class="form-horizontal" id="comp-userEditor-form">'
            +'              <div class="form-group">'
            +'                <label for="inputUsername" class="col-sm-2 control-label">用户名</label>'
            +'                <div class="col-sm-10">'
            +'                  <input type="text" class="form-control" id="inputUsername" name="username" placeholder="用户名">'
            +'                </div>'
            +'              </div>'
            +'              <div class="form-group">'
            +'                <label for="inputPassword" class="col-sm-2 control-label">密码</label>'
            +'                <div class="col-sm-10">'
            +'                  <input type="text" class="form-control" id="inputPassword" name="password" placeholder="密码">'
            +'                </div>'
            +'              </div>'
            +'            </form>'
            +'          </div>';
    var buttoms = {
      '取消': function () {
      }
    };
    if(opt.operation=='NEW'||opt.operation=='UPDATE') {
      buttoms['确定']=function(){
        var url = userEditor.urlMap[opt.operation];
        ajaxResult(ctx + url,$('#comp-userEditor-form').serialize(),function(){
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
        if(opt.operation=='VIEW'||opt.operation=='UPDATE'){
          $('#comp-userEditor-form').loadForm(opt.data);
        }
      },
      buttons: buttoms
    });
  };


</script>

