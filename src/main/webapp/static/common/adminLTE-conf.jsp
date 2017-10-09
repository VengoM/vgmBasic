<%--
  Created by IntelliJ IDEA.
  User: VGM
  Date: 2017-8-25 11:16:25
  Time: 18:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Tell the browser to be responsive to screen width -->
<meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">

<link rel="stylesheet" href="${ctx}/static/module/adminLTE/bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- Font Awesome -->
<link rel="stylesheet" href="${ctx}/static/module/adminLTE/bower_components/font-awesome/css/font-awesome.min.css">
<!-- Ionicons -->
<link rel="stylesheet" href="${ctx}/static/module/adminLTE/bower_components/Ionicons/css/ionicons.min.css">
<!-- Theme style -->
<link rel="stylesheet" href="${ctx}/static/module/adminLTE/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. We have chosen the skin-blue for this starter
page. However, you can choose any other skin. Make sure you
apply the skin class to the body tag so the changes take effect. -->
<link rel="stylesheet" href="${ctx}/static/module/adminLTE/dist/css/skins/_all-skins.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="${ctx}/static/module/adminLTE/plugins/iCheck/square/blue.css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
<![endif]-->

<!-- Google Font -->
<%--<link rel="stylesheet"--%>
      <%--href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,600,700,300italic,400italic,600italic">--%>
<link rel="stylesheet"
      href="${ctx}/static/module/adminLTE/bower_components/googleapis/style.css">

<!-- REQUIRED JS SCRIPTS -->

<!-- jQuery 3 -->
<script src="${ctx}/static/module/adminLTE/bower_components/jquery/dist/jquery.min.js"></script>
<!-- Bootstrap 3.3.7 -->
<script src="${ctx}/static/module/adminLTE/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- AdminLTE App -->
<script src="${ctx}/static/module/adminLTE/dist/js/adminlte.min.js"></script>
<!-- Optionally, you can add Slimscroll and FastClick plugins.
Both of these plugins are recommended to enhance the
user experience. -->

<!-- jquery comfirm -->
<link rel="stylesheet" href="${ctx}/static/module/jquery-confirm/dist/jquery-confirm.min.css">
<script src="${ctx}/static/module/jquery-confirm/dist/jquery-confirm.min.js"></script>

<script>
  (function($){
    $.fn.openOverLay = function(){
      var overlay = this.find('.overlay');
      if (overlay.length>0) {
        $(overlay).show();
      } else {
        overlayElement = '<div class="overlay"><i class="fa fa-refresh fa-spin"></i></div>';
        this.append(overlayElement);
      }
    }
    $.fn.closeOverLay = function(){
      var overlay = this.find('.overlay');
      if (overlay.length>0) {
        $(overlay).remove();
      }
    }
    $.fn.loadForm = function (data) {
      for(var f in data){
        var v = data[f];
        var c = this.find('[name='+f+']:input');
        if(c.attr('type') == 'radio'
                || c.attr('type') == 'checkbox'){
          $('[name='+f+']:input').each(function(){
            if($(this).val()==v){
              $(this).attr('checked',true);
            }
          });
        } else if(c.is('select')&&typeof v =='boolean'){
          c.val(v?'1':'0');
        } else{
          c.val(v);
        }
      }
    }
  })(jQuery)

  function ajaxResult(url,data,success) {
    $.ajax({
      url: url,
      type: 'post',
      data : data,
      dataType:'json',
      success: function(data){
        if (data.success) {
          $.alert({
            title:'提示',
            content: '操作成功！',
            type:'green'
          });
          success(data);
        } else {
          $.alert({
            title:'警告',
            content: '操作失败！'+data.msg,
            type:'red'
          });
        }
      },
      error: function(){
        $.alert({
          title:'警告',
          content: '操作请求失败！',
          type:'orange'
        });
      }
    });
  }
</script>