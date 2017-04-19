<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js"></script>
<title>部门管理</title>

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
	        idField: 'deptId',
	        url: '${pageContext.servletContext.contextPath}/Dept/getDepts?randID='+<%=Math.random()%>,
	        columns: [{
	            field: 'deptId',
	            title: 'ID'
	        }, {
	            field: 'deptName',
	            title: '名称',
	            editable: {
	            	 type: 'text',
	                 title: '名称',
	                 validate: function (v) {
	                     if (!v) return '名称不能为空';
	                 }
	            }
	        }, {
	            field: 'deptText',
	            title: '介绍',
	            editable: {
	            	type: 'text',
	                title: '介绍'
	            }
	        }, {
	            field: 'action',
	            title: '操作',
	            formatter: 'actionFormatter',
	            events: 'actionEvents'
	        }],
	        onEditableSave: function (field, row, oldValue, $el) {
	        	var dept = {};
	            dept['deptId'] = row.deptId;
	            dept['deptName'] = row.deptName ;
	            dept['deptText'] = row.deptText;
                $.ajax({
                    type: 'post',
                    url: '${pageContext.servletContext.contextPath}/Dept/updateDept',
                    data: JSON.stringify(dept),
                    contentType: 'application/json',
                    success: function(data) {
                    	alert('修改成功');
                    },
                    error: function () {
                        alert('修改失败');
                    },
                    complete: function () {

                    }

                });
	        }
	    });
	});
	$('#table2').bootstrapTable({
        idField: 'jobId',
        url: '${pageContext.servletContext.contextPath}/job/getJobs?randID='+<%=Math.random()%>,
        columns: [{
            field: 'jobId',
            title: 'ID'
        }, {
            field: 'dept.deptId',
            title: '部门ID'
        },{
            field: 'dept.deptName',
            title: '部门名称'
        },{
            field: 'jobName',
            title: '名称',
            editable: {
            	 type: 'text',
                 title: '名称',
                 validate: function (v) {
                     if (!v) return '名称不能为空';
                 }
            }
        }, {
            field: 'jobText',
            title: '介绍',
            editable: {
            	type: 'text',
                title: '介绍'
            }
        }, {
            field: 'action',
            title: '操作',
            formatter: 'actionFormatter2',
            events: 'actionEvents2'
        }],
        onEditableSave: function (field, row, oldValue, $el) {
        	var job = {};
            job['jobId'] = row.jobId;
            job['jobName'] = row.jobName;
            job['jobText'] = row.jobText;
            $.ajax({
                type: 'post',
                url: '${pageContext.servletContext.contextPath}/job/update?deptId='+row.dept.deptId,
                data: JSON.stringify(job),
                contentType: 'application/json',
                success: function(data) {
                	alert('修改成功');
                },
                error: function () {
                    alert('修改失败');
                },
                complete: function () {

                }

            });
        }
   	 });
	$("#addJob").click(function(){
		$.ajax({
			url: '${pageContext.servletContext.contextPath}/Dept/getDepts?randID='+<%=Math.random()%>, //所需要的列表接口地址
			success : function(data,status) {
				if (status == "success") {
					var h = "";
					$.each(data, function(key, value) {
						$("#deptId2").append("<option value='" + value.deptId + "'>" + value.deptName + "</option>");
					})
				}
			}
		}); 
	})
 	$("#bt").click(function(){
 		if($("#deptId").val()=="")
 			$("#deptId").focus();
 			else
 			$("#form").submit();	
	
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
function actionFormatter2(value, row, index) {
    return [
        '<a class="remove ml10" href="javascript:void(0)" title="删除">',
        '<i class="glyphicon glyphicon-remove"></i>',
        '</a>'
    ].join('');
}

window.actionEvents = {
    'click .remove': function (e, value, row, index) {
    	$.post("${pageContext.servletContext.contextPath}/Dept/deleteDept",
    		    {
    		        deptId:row.deptId
    	
    		    },
    		        function(data,status){
    		        if(status=="success")
    		        	$("#table").bootstrapTable('removeByUniqueId',row.deptId);
    		       
    		    });
    }
};
window.actionEvents2 = {
	    'click .remove': function (e, value, row, index) {
	    	$.post("${pageContext.servletContext.contextPath}/job/delete",
	    		    {
	    		        jobId:row.jobId
	    	
	    		    },
	    		        function(data,status){
	    		        if(status=="success")
	    		        	$("#table2").bootstrapTable('removeByUniqueId',row.jobId);
	    		       
	    		    });
	    }
	};
function detailFormatter(index, row) {
    var html = [];
    $.each(row, function (key, value) {
    	if (key=="employeeses") 
    		return;
    	if (key=="jobs") 
    		return;
    	if (key=="deptId") 
    		key = "ID";
    	if (key=="deptName") 
    		key = "名称";
    	if (key=="deptText") 
    		key = "介绍";
    	html.push('<p><b>' + key + ':</b> ' + value + '</p>');
    });
    return html.join('');
}
function detailFormatter2(index, row) {
    var html = [];
    $.each(row, function (key, value) {
    	if (key=="employeeses") 
    		return;
    	if (key=="dept"){
    		key = "部门ID";
    		html.push('<p><b>' + key + ':</b> ' + value.deptId + '</p>');
    		key = "部门名称";
    		html.push('<p><b>' + key + ':</b> ' + value.deptName + '</p>');
    	}
    	if (key=="jobId") 
    		key = "ID";
    	if (key=="jobName") 
    		key = "名称";
    	if (key=="jobText") 
    		key = "介绍";
    	html.push('<p><b>' + key + ':</b> ' + value + '</p>');
    });
    return html.join('');
}
function checkDeptId() {
	var deptId = $("#deptId");
	if (deptId.val() != "") {

		$.post("${pageContext.servletContext.contextPath}/Dept/checkId", {
			"id" : deptId.val()
		}, function(data, status) {
			if (data == "success")
				$("#msg").html("该ID可用");
			else{
				$("#msg").html("该ID已存在");
				deptId.focus();
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
          
		<div class="panel-group" id="accordion">
					<div class="panel panel-warning">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseOne">部门管理 </a>
							</h4>
						</div>
          <div id="toolbar" class="btn-group">
          <button id="addJob" type="button" class="btn  btn-danger" data-toggle="modal" data-target="#addStaff2">添加职位</button>
          
          </div>
          <div id="collapseOne" class="panel-collapse collapse in ">
							<div class="panel-body">
			
          <table data-search="true"
          data-show-columns="true" data-show-toggle="true" data-show-refresh="true" data-pagination="true" data-detail-view="true"
          data-toolbar="#toolbar"  	data-detail-formatter="detailFormatter" data-cache="flase" id="table" data-unique-id="deptId">
          </table>
          
			</div>
			</div>
			
			</div>
			
			<div class="panel panel-danger">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseTwo">职位管理 </a>
							</h4>
						</div>
          <div id="toolbar" class="btn-group">
          <button type="button" class="btn  btn-warning" data-toggle="modal" data-target="#addStaff">添加部门</button>
          </div>
          <div id="collapseTwo" class="panel-collapse collapse ">
							<div class="panel-body">
			
          <table data-search="true"
          data-show-columns="true" data-show-toggle="true" data-show-refresh="true" data-pagination="true" data-detail-view="true"
          data-toolbar="#toolbar"  	data-detail-formatter="detailFormatter2" data-cache="flase" id="table2" data-unique-id="jobId">
          </table>
          
			</div>
			</div>
			
			</div>
			
         </div>
         
         
      </div>
      </div>     
		</div>

  <div class="modal fade" id="addStaff" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel">部门信息</h4>
            </div>
            <div class="modal-body">

<form class="form-horizontal" role="form" id="form" action="${pageContext.servletContext.contextPath}/Dept/addDept" method="post">
  <div class="form-group">
    <label for="employeeName" class="col-sm-2 control-label">ID</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="deptId" name="deptId" placeholder="请输入ID" onblur="checkDeptId()">
      <span class="text-danger" id="msg"></span>
    </div>
  </div>
  <div class="form-group">
  <label for="address" class="col-sm-2 control-label">名称</label>
  <div class="col-sm-10">
  <input type="text" class="form-control" id="deptName" name="deptName" placeholder="请输入名称">
  </div>
  </div>
  <div class="form-group">
  <label for="NOcode" class="col-sm-2 control-label">介绍</label>
  <div class="col-sm-10">
  <textarea class="form-control" rows="3" id="deptText" name="deptText"></textarea>
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

<div class="modal fade" id="addStaff2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title text-center" id="myModalLabel">职位信息</h4>
            </div>
            <div class="modal-body">

<form class="form-horizontal" role="form1" id="form1" action="${pageContext.servletContext.contextPath}/job/add" method="post">
  <div class="form-group">
    <label for="deptId" class="col-sm-2 control-label">部门ID</label>
    <div class="col-sm-10">
      <select id="deptId2" class="form-control" name="dept.deptId" onclick="deptIdSelect()">
  </select>
    </div>
  </div>
  <div class="form-group">
  <label for="address" class="col-sm-2 control-label">名称</label>
  <div class="col-sm-10">
  <input type="text" class="form-control" id="jobName" name="jobName" placeholder="请输入名称">
  </div>
  </div>
  <div class="form-group">
  <label for="NOcode" class="col-sm-2 control-label">介绍</label>
  <div class="col-sm-10">
  <textarea class="form-control" rows="3" id="jobText" name="jobText"></textarea>
  </div>
  </div>
</form>
 
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="bt1">提交</button>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal -->
</div>
</body>
</html>