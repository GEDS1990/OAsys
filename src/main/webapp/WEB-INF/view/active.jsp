<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js"></script>
<title>活动管理</title>

<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
<link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<link href="${pageContext.servletContext.contextPath}/dashboard.css" rel="stylesheet">
<!-- Latest compiled and minified CSS -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">

<link rel="stylesheet" href="//rawgit.com/wenzhixin/bootstrap-table/master/src/bootstrap-table.css">
<link rel="stylesheet" href="//rawgit.com/vitalets/x-editable/master/dist/bootstrap3-editable/css/bootstrap-editable.css">

<!-- Latest compiled and minified JavaScript -->
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>

<!-- Latest compiled and minified Locales -->
<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>

<script src="//rawgit.com/vitalets/x-editable/master/dist/bootstrap3-editable/js/bootstrap-editable.js"></script>
<script src="//rawgit.com/wenzhixin/bootstrap-table/master/src/extensions/editable/bootstrap-table-editable.js"></script>

<script type="text/javascript">

$(function(){
	if("${user.userLevel}"==2){
		$("#c").remove();
		$("#e").remove();
	}else if("${user.userLevel}"==3){
		$("#b").remove();
		$("#c").remove();
		$("#e").remove();
	}

	$(function () {
		$('#table').bootstrapTable({
	        idField: 'activeId',
	        url: '${pageContext.servletContext.contextPath}/Active/getActives?randID='+<%=Math.random()%>,
	        columns: [{
	            field: 'activeName',
	            title: '活动名称'
	        }, {
	            field: 'activeInfo',
	            title: '活动介绍'
	        }, {
	            field: 'activeAgreeNum',
	            title: '当前票数'
	        }, {
	            field: 'action',
	            title: '操作',
	            formatter: 'actionFormatter',
	            events: 'actionEvents'
	        }]
	    });
	});
 	$("#bt").click(function(){
		$('#form').submit();
	
	})
		$("#bt1").click(function(){
		$("#form1").submit();	
	})
});
function actionFormatter(value, row, index) {
    return [
        '<a class="remove ml10" href="javascript:void(0)" title="删除">',
        '<i class="glyphicon glyphicon-remove"></i>',
        '</a>'
    ].join('');
}

window.actionEvents = {
    'click .remove': function (e, value, row, index) {
    	$.post("${pageContext.servletContext.contextPath}/Active/deleteActive",
    		    {
    		        activeId:row.activeId
    	
    		    },
    		        function(data,status){
    		        if(status=="success")
    		        	$("#table").bootstrapTable('removeByUniqueId',row.activeId);
    		       
    		    });
    }
};
function detailFormatter(index, row) {
    var html = [];
    $.each(row, function (key, value) {
    	if (key=="activeName") 
    		key = "活动名称";
    	if (key=="activeInfo") 
    		key = "活动介绍";
    	if (key=="activeAgreeNum") 
    		key = "当前票数";
    	html.push('<p><b>' + key + ':</b> ' + value + '</p>');
    });
    return html.join('');
}
</script>
</head>
<body>

   <jsp:include page="top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
     <jsp:include page="menu.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="main">
          <h3 class="text-left">活动管理</h3>
          <div id="toolbar" class="btn-group">
          <button type="button" class="btn  btn-info" data-toggle="modal" data-target="#addStaff">添加活动</button>
          </div>
          <table data-search="true"
          data-show-columns="true" data-show-toggle="true" data-show-refresh="true" data-pagination="true" data-detail-view="true"
          data-toolbar="#toolbar"  	data-detail-formatter="detailFormatter" data-cache="flase" id="table" data-unique-id="activeId">
          </table>

			
			</div>
         </div>
      </div>

  <div class="modal fade" id="addStaff" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel">活动信息</h4>
            </div>
            <div class="modal-body">

<form class="form-horizontal" role="form" id="form" action="${pageContext.servletContext.contextPath}/Active/addActive" method="post">
  <div class="form-group">
    <label for="employeeName" class="col-sm-2 control-label">活动名称</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="activeName" name="activeName" placeholder="请输入活动名称">
    </div>
  </div>
  <div class="form-group">
  <label for="address" class="col-sm-2 control-label">活动介绍</label>
  <div class="col-sm-10">
  <input type="text" class="form-control" id="activeInfo" name="activeInfo" placeholder="请输入活动介绍">
  </div>
  </div>
  <input type="hidden" class="form-control" id="activeAgreeNum" name="activeAgreeNum" value="0">
</form>
 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="bt">提交</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>