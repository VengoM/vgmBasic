<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017/6/28
  Time: 18:15
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
  <%@ include file="/static/common/common.jsp"%>
  <title>首页</title>
  <%@ include file="/static/common/adminLTE-conf.jsp"%>
  <script>
    //<![CDATA[

    function openTab(e) {
      var menuId = $(e).attr("id");
      var id = menuId.replace('menu-','');
      var tabId = 'tab_'+id;
      var href = $(e).attr("href");
      var tabText = $(e).find('span').text();
      addTap(tabId,tabText,href);
      activeTap(tabId);
      return false;
    }

    function addTap(tabId,tabText,href) {
      var tabExists = $('#'+tabId).length > 0;
      if (!tabExists) {
        var tabHead = '<li class="">' +
                '<a href="#'+tabId+'" data-toggle="tab" aria-expanded="false">'+tabText+'  ' +
                '<button type="button" class="close" onclick="closeTap(\''+tabId+'\')"> × </button>' +
                '</a>' +
                '</li>';
        $('#tab-head').append(tabHead);
        var tabContent = '<div class="tab-pane" id="'+tabId+'" style="width: 100%;" >' +
                '<iframe style="/*height: 550px;*/width: 100%;border: none;overflow: hidden;" src="'+href+'" />' +
                '</div>';
        $('#tab-content').append(tabContent);
      }
    }

    function activeTap(tabId) {
      $('#tab-head a[href="#'+tabId+'"]').tab('show');
    }

    function closeTap(tabId) {
      $('#tab-head a[href="#'+tabId+'"]').remove();
      $('#'+tabId).remove();
      $('#tab-head a:last').tab('show');
    }

    function closeAllTap() {

    }

    function resizeAllIframe(){
      var iframes = $('iframe');
      for (var i=0;i<iframes.length;i++) {
        resizeIframe(iframes[i]);
      }
    }

    function resizeIframe(e){
      var iframe = e;
      try{
//        var bHeight = iframe.contentWindow.document.body.scrollHeight;
//        var dHeight = iframe.contentWindow.document.documentElement.scrollHeight;
//        var sHeight = iframe.contentWindow.document.body.style.height;
        var oHeight = iframe.contentWindow.document.body.offsetHeight;
        var height = Math.max(oHeight, minHeight);
        iframe.height = height;
        console.log(height+'+'+minHeight);
      }catch (ex){}
    }

    var minHeight;
    $(function (){
      minHeight = window.document.body.offsetHeight - 140;
      setInterval("resizeAllIframe()", 1000);
    });

    //]]>
  </script>
</head>
<body class="skin-black sidebar-mini">
<div class="wrapper">

  <%@ include file="/WEB-INF/view/index-header.jsp"%>
  <%@ include file="/WEB-INF/view/index-sidebar.jsp"%>

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper" mini>
    <div class="nav-tabs-custom" style="margin: 0;">
      <ul id="tab-head" class="nav nav-tabs">
        <li class="dropdown pull-right">
          <a href="#" class="dropdown-toggle text-muted" data-toggle="dropdown" aria-expanded="true" >
            <i class="fa fa-gear"></i>
          </a>
          <ul class="dropdown-menu pull-right">
            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Action</a></li>
            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Another action</a></li>
            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Something else here</a></li>
            <li role="presentation" class="divider"></li>
            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Separated link</a></li>
          </ul>
        </li>
        <li class="active"><a href="#tab_0" data-toggle="tab" aria-expanded="false">首页</a></li>

      </ul>
      <div id="tab-content" class="tab-content" style="background: #ecf0f5;padding: 0">
        <div class="tab-pane active" id="tab_0">
          <b>How to use:</b>

          <p>Exactly like the original bootstrap tabs except you should use
            the custom wrapper <code>.nav-tabs-custom</code> to achieve this style.</p>
        </div>
        <!-- /.tab-pane -->
      </div>
      <!-- /.tab-content -->
    </div>
  </div>
  <!-- /.content-wrapper -->





  <%@ include file="/WEB-INF/view/index-footer.jsp"%>

  <%@ include file="/WEB-INF/view/index-control-sidebar.jsp"%>
</div>
<!-- ./wrapper -->

</body>
</html>
