<%--
  Created by IntelliJ IDEA.
  User:  vengo_mo
  Date: 2017/8/9
  Time: 10:13
  To change this template use File | Settings | File Templates.

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    var roleSelect = {
        content: ''
        + '  <div class="col-sm-12">'
        + '    <table id="comp-roleSelect-table" class="table table-bordered table-hover" cellspacing="0" width="100%">'
        + '       <thead>'
        + '         <tr>'
        + '         <th>ID</th>'
        + '         <th>角色</th>'
        + '         <th>描述</th>'
        + '         <th>状态</th>'
        + '         </tr>'
        + '       </thead>'
        + '    </table>'
        + '  </div>',

        roleSelectTable: null,
        selections:[],

        open : function (defaultCheck, select) {
            $.confirm({
                title: '',
                content: this.content,
                type: 'blue',
                draggable: true,
                typeAnimated: true,
                columnClass: 'col-sm-12',
                onContentReady: function(){
                    roleSelect.selections = defaultCheck;
                    roleSelect.loadList(defaultCheck);
                },
                buttons: {
                    '确定': function () {
                        roleSelect.select(select);
                    },
                    '取消': function () {}
                }
            });
        },

        select: function (select) {
            var selections = this.getSelect();
            if (selections.length > 0) {
                select(selections);
            } else {
                $.alert({
                    title: '提示',
                    content: '请选择记录！',
                    type: 'orange'
                });
            }
        },

        getSelect: function () {
            return this.roleSelectTable.rows('.selected').data();
        },
        loadList: function (defaultCheck) {
            this.roleSelectTable = $('#comp-roleSelect-table').defaultDataTable( {
                url: ctx + '/role/doQuery.action',
                paramsSelector: '',
                mutliSelect: false,
                columns: [
                    { data: 'id', orderable:false },
                    { data: 'role' },
                    { data: 'description', orderable:false},
                    { data: "available",
                        orderable: false,
                        render: function (data, type, row, meta) {
                            if (data) {
                                return '<span class="label label-success">有效</span>';
                            } else {
                                return '<span class="label label-danger">无效</span>';
                            }
                        }
                    }
                ],
                createdRow: function( row, data, dataIndex ) {
                    var index = roleSelect.selections.indexOf(data.id);
                    if ( index > -1 ) {
                        $(row).addClass('selected');
                    }
                },
                initComplete : function(settings, json){

                    $('#comp-roleSelect-table').find('tbody').on( 'click', 'tr', function () {
                        $(this).toggleClass('selected');
                        var row = roleSelect.roleSelectTable.rows(this).data();
                        var index = roleSelect.selections.indexOf(row.id);
                        if (index > -1) {
                            roleSelect.selections.split(index,1);
                        } else {
                            roleSelect.selections.push(row.id);
                        }
                    } );
                }
            });
        }

    }
</script>

