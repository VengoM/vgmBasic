<%--
  Created by IntelliJ IDEA.
  User: VGM
  Date: 2017-8-29
  Time: 14:28:09
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<link rel="stylesheet" href="${ctx}/static/module/adminLTE/bower_components/datatables.net-bs/css/dataTables.bootstrap.min.css">
<script type="text/javascript" src="${ctx}/static/module/adminLTE/bower_components/datatables.net/js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="${ctx}/static/module/adminLTE/bower_components/datatables.net-bs/js/dataTables.bootstrap.min.js"></script>
<script>
  /**
   *
   * @param id
   * @param mutliSelect
   */
  function dataTableSelectAble(selector,mutliSelect){
    if(mutliSelect) {
      $(selector).find('tbody').on( 'click', 'tr', function () {
        $(this).toggleClass('selected');
      } );
    } else {
      $(selector).find('tbody').on( 'click', 'tr', function () {
        if ($(this).hasClass('selected')) {
          $(this).removeClass('selected');
        } else {
          $(selector).find('tbody tr.selected').removeClass('selected');
          $(this).addClass('selected');
        }
      });
    }
  }

  (function($){
    $.fn.defaultDataTable = function (opt){

      var defaultOpt = {
        language: {
          url: ctx + '/static/module/adminLTE/bower_components/datatables.net-bs/cn.json'
        },
        serverSide: true,
        lengthMenu: [[5,10,25,50,-1],[5,10,25,50,"All"]],
        pageLength: 5,
        ajax: function(data, callback, settings) {
          // paga param
          data.size = data.length;
          data.page = data.start/data.length;
          //query params
          var params = $(opt.paramsSelector).serializeArray();
          for (var i=0;i<params.length;i++) {
            data[params[i].name] = params[i].value;
          }
          //sort params
          var columns = data.columns;
          var orders = data.order;
          var sort = '';
          for (var i=0;i<orders.length;i++) {
            var order = orders[i];
            sort += sort==''?'':'&';
            sort += 'sort='+columns[order.column].data+','+order.dir;
          }

          $.ajax({
            url : opt.url + '?' + sort,
            type: 'get',
            data : data,
            dataType:'json',
            success: function(data) {
              data.recordsTotal = data.totalElements;
              data.recordsFiltered = data.totalElements;
              data.data = data.content;
              callback(data);
            }
          });
        },
        columns: opt.colums,
        dom:
        'rt' +
        '<"row"<"col-sm-4"l><"col-sm-4"i><"col-sm-4"p>>',
        initComplete : function(settings, json){
          dataTableSelectAble(this,opt.mutliSelect==null?false:opt.mutliSelect);
        }
      };

      $.extend(true,defaultOpt,opt);

      return this.DataTable(defaultOpt);
    }
  })(jQuery)

</script>