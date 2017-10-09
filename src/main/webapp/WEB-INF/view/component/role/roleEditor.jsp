<%--
  Created by IntelliJ IDEA.
  User:  vengo_mo
  Date: 2017/8/9
  Time: 10:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
  if(this.roleEditor == undefined){
    this.roleEditor={
      urlMap : {
        NEW : '/role/add.action',
        UPDATE : '/role/update.action'
      }
    };
  }

  roleEditor.open = function(opt){
    var content = '<div class="col-sm-12">'
            +'            <form class="form-horizontal" id="comp-roleEditor-form">'
            +'              <div class="form-group">'
            +'                <label for="inputRole" class="col-sm-2 control-label">角色</label>'
            +'                <div class="col-sm-10">'
            +'                  <input type="hidden"  name="id">'
            +'                  <input type="text" class="form-control" id="inputRole" name="role" placeholder="角色">'
            +'                </div>'
            +'              </div>'
            +'              <div class="form-group">'
            +'                <label for="inputDescription" class="col-sm-2 control-label">描述</label>'
            +'                <div class="col-sm-10">'
            +'                  <textarea type="text" class="form-control" id="inputDescription" name="description" placeholder="描述"></textarea>'
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
        var url = roleEditor.urlMap[opt.operation];
        ajaxResult(ctx + url,$('#comp-roleEditor-form').serialize(),function(){
          opt.callback();
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

