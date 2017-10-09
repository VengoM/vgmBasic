<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/5/16
  Time: 14:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <title></title>
  <%@ include file="/static/common/common.jsp"%>
  <%@ include file="/static/common/adminLTE-conf.jsp"%>
  <script src="${ctx}/static/module/jquery/jquery.form.js"></script>
  <script>
    var redirectUrl = '${redirectUrl}';

    $(function () {
      $('input').iCheck({
        checkboxClass: 'icheckbox_square-blue',
        radioClass: 'iradio_square-blue',
        increaseArea: '20%' // optional
      });
    });

    function login(callback){
      $('#loginBtn').attr('disable',true);
      $('#loginBox').openOverLay();
      $('#loginForm').ajaxSubmit({
        dataType : 'json',
        success : callback,
        error: function() {
          $('#loginTipText').text("请求失败！");
          $('#loginTip').show();
        },
        complete : function (){
          $('#loginBtn').attr('disable',false);
          $('#loginBox').closeOverLay();
        }
      })
    }

    function loginSuccess (data) {
      if (data.success) {
        window.location.href=redirectUrl;
      } else {
        $('#loginTipText').text(data.msg);
        $('#loginTip').show();
      }
    }

    function doLogin(){
      login(loginSuccess);
    }
  </script>
</head>
<body class="hold-transition login-page">



<div class="login-box">
  <div class="login-logo">
    <a href="${ctx}"><b>vgmBasic</b></a>
  </div>
  <!-- /.login-logo -->
  <div id="loginBox" class="box login-box-body">
    <p class="login-box-msg">用户登录</p>

    <div id="loginTip" class="callout callout-danger lead" style="display: none">
      <h5>提示</h5>
      <p id="loginTipText" style="font-size: small;">
      </p>
    </div>

    <form id="loginForm" action="${ctx}/login.do" method="post" >
      <div class="form-group has-feedback">
        <input type="text" class="form-control" name="username" placeholder="用户名">
        <span class="glyphicon glyphicon-envelope form-control-feedback"></span>
      </div>
      <div class="form-group has-feedback">
        <input type="password" class="form-control" name="password" placeholder="密码">
        <span class="glyphicon glyphicon-lock form-control-feedback"></span>
      </div>
      <div class="row">
        <div class="col-xs-8">
          <%--<div class="checkbox icheck">
            <label>
              <input type="checkbox" name="rememberMe"> Remember Me
            </label>
          </div>--%>
        </div>
        <!-- /.col -->
        <div class="col-xs-4">
          <button id="loginBtn" type="button" class="btn btn-primary btn-block btn-flat" onclick="doLogin();">登录</button>
        </div>
        <!-- /.col -->
      </div>
    </form>

    <%--<a href="#">I forgot my password</a><br>--%>
    <%--<a href="register.html" class="text-center">Register a new membership</a>--%>

  </div>
  <!-- /.login-box-body -->
</div>
<!-- /.login-box -->
</body>
</html>
