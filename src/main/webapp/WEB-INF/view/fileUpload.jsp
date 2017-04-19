<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js"></script>
<title>文件管理</title>

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
	$('#table').bootstrapTable({
        idField: 'fileId',
        url: '${pageContext.servletContext.contextPath}/file/getFiles?randID='+<%=Math.random()%>,
        columns: [{
        	field: 'fileTime',
            title: '发送时间'
        }, {
        	field: 'fileText',
            title: '文件介绍'
        }, {
        	field: 'employeesByFileFrom.employeeId',
            title: '发送人ID'
        }, {
        	field: 'fileName',
            title: '文件名称'
        }, {
            field: 'action',
            title: '操作',
            formatter: 'actionFormatter',
            events: 'actionEvents'
        }]
    });
 	$("#bt").click(function(){
 		if($("#fileTo").val()==0)
 			$("#fileTo").focus();
 		else
		$('#form').submit();
	
	})
	
});
function actionFormatter(value, row, index) {
    return [
		'<a class="download ml10" href="javascript:void(0)" title="下载">',
				'<i class="glyphicon glyphicon-download"></i>',
				'</a>',
        '<a class="remove ml10" href="javascript:void(0)" title="删除">',
        '<i class="glyphicon glyphicon-remove"></i>',
        '</a>'
    ].join('');
}

window.actionEvents = {
		'click .download': function (e, value, row, index) {
			window.location.href="${pageContext.servletContext.contextPath}/file/download?fileName="+encodeURI(encodeURI(row.fileName));
	    },
    'click .remove': function (e, value, row, index) {
    	$.post("${pageContext.servletContext.contextPath}/file/delete",
    		    {
    		        fileId:row.fileId,
    		        fileName:row.fileName
    	
    		    },
    		        function(data,status){
    		        if(status=="success")
    		        	window.location.reload();
    		       
    		    });
    }
};
function detailFormatter(index, row) {
    var html = [];
    $.each(row, function (key, value) {
    	if (key=="fileId") 
    		return;
    	if (key=="employeesByFileTo") 
    		return;
    	if (key=="employeesByFileFrom"){
    		key = "发送人ID";
    		html.push('<p><b>' + key + ':</b> ' + value.employeeId + '</p>');
    		return;
    	}
    	if (key=="fileTime") 
    		key = "发送时间";
    	if (key=="fileName") 
    		key = "文件名称";
    	if (key=="fileText") 
    		key = "文件介绍";
    	html.push('<p><b>' + key + ':</b> ' + value + '</p>');
    });
    return html.join('');
}

function checkId(){
	var fileTo = $("#fileTo");
	if (fileTo.val() != "") {

		$.post("${pageContext.servletContext.contextPath}/Staff/checkId", {
			"id" : fileTo.val()
		}, function(data, status) {
			if (data == "success")
				$("#msg").html("该ID可用");
			else{
				$("#msg").html("该ID不存在");
				fileTo.focus();
			}

		})
	}
}
</script>
</head>
<body>

   <jsp:include page="top.jsp"></jsp:include>

    <div class="container-fluid">
      <div class="row">
     <jsp:include page="menu.jsp"></jsp:include>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main" id="main">
          <h3 class="text-left">文件管理</h3>
          <div id="toolbar" class="btn-group">
          <button type="button" class="btn  btn-info" data-toggle="modal" data-target="#addStaff">发送文件</button>
          </div>
          <table data-search="true"
          data-show-columns="true" data-show-toggle="true" data-show-refresh="true" data-pagination="true" data-detail-view="true"
          data-toolbar="#toolbar"  	data-detail-formatter="detailFormatter" data-cache="flase" id="table" data-unique-id="fileId">
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

<form class="form-horizontal" role="form" id="form" action="${pageContext.servletContext.contextPath}/file/fileUpload" method="post" enctype="multipart/form-data">
  <div class="form-group">
    <label for="fileTo" class="col-sm-2 control-label">接收人ID</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="fileTo" name="fileTo" placeholder="请输入接收人ID" onblur="checkId()">
      <span class="text-danger" id="msg"></span>
    </div>
  </div>
  <div class="form-group">
  <label for="fileText" class="col-sm-2 control-label">文件介绍</label>
  <div class="col-sm-10">
  <input type="text" class="form-control" id="fileText" name="fileText" placeholder="请输入文件介绍">
  </div>
  </div>
   <div class="form-group">
    <label for="file" class="col-sm-2 control-label">选择文件</label>
    <div class="col-sm-10">
    <input class="form-control" type="file" id="file" name="file">
    </div>
  </div>
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