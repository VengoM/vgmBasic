<%--
  Created by IntelliJ IDEA.
  User: VGM
  Date: 2017/6/22
  Time: 14:01
  To change this template use File | Settings | File Templates.
--%>
<script src="${ctx}/static/module/layui/layui.js"></script>
<link rel="stylesheet" type="text/css" href="${ctx}/static/module/layui/css/layui.css" />
<link rel="stylesheet" type="text/css" href="${ctx}/static/css/global.css" />
<script>
  LayuiUtil = {
    layerMsg : function (text) {
      layui.use('layer', function(){
        var layer = layui.layer;
        layer.msg(text);
      });
    }
  }
</script>