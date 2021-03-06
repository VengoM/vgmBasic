<%--
  Created by IntelliJ IDEA.
  User:  vengo_mo
  Date: 2017/8/9
  Time: 10:13
  To change this template use File | Settings | File Templates.

--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<script type="text/javascript">
    var organizationCheckTree = {
        content: ''
        + '  <div class="col-sm-12">'
        + '    <div id="comp-organization-tree"></div>'
        + '  </div>',

        resourceTree: null,

        open : function (defaultCheck, check) {
            $.confirm({
                title: '',
                content: this.content,
                type: 'blue',
                draggable: true,
                typeAnimated: true,
                columnClass: 'col-sm-12',
                onContentReady: function(){
                    organizationCheckTree.loadTree(defaultCheck);
                },
                buttons: {
                    '确定': function () {
                        organizationCheckTree.check(check);
                    },
                    '取消': function () {}
                }
            });
        },

        check: function (check) {
            var selections = this.getCheck();
            if (selections.length > 0) {
                check(selections);
            } else {
                $.alert({
                    title: '提示',
                    content: '请选择记录！',
                    type: 'orange'
                });
            }
        },

        getCheck: function () {
            return this.resourceTree.treeview('getChecked');
        },


        loadTree: function (defaultCheck) {
            $.ajax({
                url: ctx + '/organization/tree.action',
                type: 'get',
                dataType: 'json',
                async: false,
                success: function(data){
                    organizationCheckTree.setIconAndCheck(data,defaultCheck);
                    organizationCheckTree.resourceTree = $('#comp-organization-tree').treeview({
                        expandIcon: "fa fa-plus",
                        collapseIcon: "fa fa-minus",
//                        nodeIcon: "fa fa-bars",
//                        showTags: true,
                        showCheckbox: true,
                        multiSelect: false,
                        highlightSelected: true,
                        data: data
                    });
                },
                error: function () {
                    $.alert({
                        title: '提示',
                        content: '请求服务器失败！',
                        type: 'red'
                    });
                }
            });

        },

        //设置对应图标
        setIconAndCheck: function (data,defaultCheck) {
            for (var i = 0; i < data.length; i++) {
                var temp = data[i];
                temp.state = {};
                if(temp.attributes.rootNode) {
                    temp.selectable = false;
                }
                if (defaultCheck.indexOf(temp.id)>-1){
                    temp.state.checked = true;
                }
                if (temp.attributes.rootNode) {
                    temp.icon = 'fa fa-list';
                } else if (temp.attributes.type == 'menu') {
                    temp.icon = temp.attributes.icon;
                } else if (temp.attributes.type == 'button') {
                    temp.icon = 'fa fa-pencil';
                }
                if(!temp.attributes.available) {
                    temp.text = '<s>'+temp.text+'</s>';
                }
                temp.text = temp.text + '  <span class="icon node-icon '+temp.icon+'"></span>';
                temp.icon = '';
                if (temp.nodes.length > 0) {
                    this.setIconAndCheck(temp.nodes,defaultCheck);
                } else {
                    //tree view展开图标依照数据中是否含有nodes来判断的
                    //空也会判断为可展开删除
                    delete temp.nodes;
                }
            }
        }
    }
</script>

