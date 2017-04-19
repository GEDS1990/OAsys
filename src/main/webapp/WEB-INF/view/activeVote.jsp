<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js"></script>
<title>活动投票</title>

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
				'<a class="like" href="javascript:void(0)" title="投票">',
				'<i class="glyphicon glyphicon-heart"></i>',
				'</a>'
    ].join('');
}

window.actionEvents = {
    'click .like': function (e, value, row, index) {
    	$.post("${pageContext.servletContext.contextPath}/Active/activeVote",
    		    {
    		        activeId:row.activeId,
    		        activeAgreeNum:row.activeAgreeNum
    	
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
    	if (key=="activeId") 
    		return;
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
          <h3 class="text-left">活动投票<small style="color: red;">(重复投票不记票数)</small></h3>
          <div id="toolbar" class="btn-group">
          </div>
          <table data-search="true"
          data-show-columns="true" data-show-toggle="true" data-show-refresh="true" data-pagination="true" data-detail-view="true"
          data-toolbar="#toolbar"  	data-detail-formatter="detailFormatter" data-cache="flase" id="table" data-unique-id="activeId">
          </table>

			
			</div>
         </div>
      </div>
</body>
</html>