<%@page import="com.entity.Job"%>
<%@page import="com.entity.Dept"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script
	src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js"></script>
<title>员工管理</title>

<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">

<!-- 可选的 Bootstrap 主题文件（一般不用引入） -->
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap-theme.min.css">

<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script
	src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="${pageContext.servletContext.contextPath}/dashboard.css"
	rel="stylesheet">
<!-- Latest compiled and minified CSS -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">

<!-- Latest compiled and minified JavaScript -->
<script
	src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>

<!-- Latest compiled and minified Locales -->
<script
	src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/bootstrap-datetimepicker.min.css">
<script
	src="${pageContext.servletContext.contextPath}/bootstrap-datetimepicker.min.js"></script>
<script src="${pageContext.servletContext.contextPath}/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript">
	$(function() {
		if("${user.userLevel}"==2){
			$("#c").remove();
			$("#e").remove();
		}else if("${user.userLevel}"==3){
			$("#b").remove();
			$("#c").remove();
			$("#e").remove();
		}
	
		$(".form_datetime").datetimepicker({
			startDate:"1980-01-01",
			minView: "month",
			language: "zh-CN",
			format : "yyyy-mm-dd",
			autoclose : true,
			todayBtn : true,
			pickerPosition : "bottom-right"
		});
		$("#table")
				.bootstrapTable(
						"refresh",
						{
							url : "${pageContext.servletContext.contextPath}/Staff/search?randID="
									+
<%=Math.random()%>
	});
		$("#bt").click(function() {
			if($("#email").val()=="")
				$("#email").focus();
			else
			$('#form').submit();

		});
		$("#bt1").click(function() {
			$("#form1").submit();
		});

	});

	function actionFormatter(value, row, index) {
		return [ '<a class="edit ml10" href="javascript:void(0)" title="编辑">',
				'<i class="glyphicon glyphicon-edit"></i>', '</a>',
				'<a class="remove ml10" href="javascript:void(0)" title="删除">',
				'<i class="glyphicon glyphicon-remove"></i>', '</a>' ].join('');
	}

	window.actionEvents = {
		'click .edit' : function(e, value, row, index) {
			$("#form1")
					.append(
							"<input type='hidden' name='employeeId' value="+row.employeeId+">");
			$("#update").modal('show');

		},
		'click .remove' : function(e, value, row, index) {
			$.post("${pageContext.servletContext.contextPath}/Staff/delete", {
				id : row.employeeId

			}, function(data, status) {
				if (status == "success")
					$("#table").bootstrapTable('removeByUniqueId',
							row.employeeId);

			});
		}
	};
	function detailFormatter(index, row) {
		var html = [];
		$.each(row, function(key, value) {
			if (key == "job")
				html.push('<p><b>' + key + ':</b> ' + value.jobName + '</p>');
			else if (key == "dept")
				html.push('<p><b>' + key + ':</b> ' + value.deptName + '</p>');
			else
				html.push('<p><b>' + key + ':</b> ' + value + '</p>');
		});
		return html.join('');
	}
	function checkemail1() {
		var email = $("#email1");
		if (email.val() != "") {

			$.post("${pageContext.servletContext.contextPath}/check", {
				"email" : email.val()
			}, function(data, status) {
				if (data == "success")
					$("#msg1").html("该邮箱可以修改");
				else{
					$("#msg1").html("该邮箱已存在");
					email.focus();
				}

			})
		}
	}
	function checkemail() {
		var email = $("#email");
		if (email.val() != "") {

			$.post("${pageContext.servletContext.contextPath}/check", {
				"email" : email.val()
			}, function(data, status) {
				if (data == "success")
					$("#msg").html("该邮箱可以修改");
				else{
					$("#msg").html("该邮箱已存在");
					email.focus();
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

			<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main"
				id="main">
				<h3>员工管理</h3>
				<div id="toolbar" class="btn-group">
					<button type="button" class="btn  btn-info" data-toggle="modal"
						data-target="#addStaff">添加员工</button>
				</div>
				<table data-toggle="table" data-search="true"
					data-show-columns="true" data-show-toggle="true"
					data-show-refresh="true" data-pagination="true"
					data-detail-view="true" data-toolbar="#toolbar"
					data-detail-formatter="detailFormatter" data-cache="flase"
					id="table" data-unique-id="employeeId">
					<thead>
						<tr>
							<th data-field="employeeId">ID</th>
							<th data-field="employeeName">名字</th>
							<th data-field="sex">性别</th>
							<th data-field="job.jobName">职位</th>
							<th data-field="dept.deptName">部门</th>
							<th data-field="workState">状态</th>
							<th data-field="action" data-formatter="actionFormatter"
								data-events="actionEvents">操作</th>
						</tr>
					</thead>
				</table>


			</div>
		</div>
	</div>
	<div class="modal fade" id="update" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title text-center" id="myModalLabel">请填写要修改的信息</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" role="form" id="form1"
						action="${pageContext.servletContext.contextPath}/Staff/update"
						method="get">
						<div class="form-group">
							<label for="employeeName1" class="col-sm-2 control-label">名字</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="employeeName1"
									name="employeeName" placeholder="请输入名字">
							</div>
						</div>
						
							<div class="form-group">
							<label for="email1" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="email1"
									name="email" required="required" onblur="checkemail1()">
									<span id="msg1" class="text-danger"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="sex1" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<select class="form-control" id="sex1" name="sex">
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="birthday1" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10">
								<div class="input-append date form_datetime">
									<input type="date" value="" class="form-control" id="birthday1"
										name="birthday" readonly="readonly" > <span
										class="add-on"><i class="icon-th"></i></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="address1" class="col-sm-2 control-label">地址</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="address1"
									name="address">
							</div>
						</div>
						<div class="form-group">
							<label for="NOcode1" class="col-sm-2 control-label">身份证号</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="NOcode1"
									name="nocode">
							</div>
						</div>
						<div class="form-group">
							<label for="learn1" class="col-sm-2 control-label">学历</label>
							<div class="col-sm-10">
								<select id="learn1" class="form-control" name="learn">
									<option value=""></option>
									<option value="高中">高中</option>
									<option value="专科">专科</option>
									<option value="本科">本科</option>
									<option value="硕士">硕士</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="mobile1" class="col-sm-2 control-label">手机号</label>
							<div class="col-sm-10">
								<input type="tel" class="form-control" id="mobile1"
									name="mobile">
							</div>
						</div>
					
						<div class="form-group">
							<label for="jobID1" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10">
								<select id="jobID1" class="form-control" name="job.jobId">
									<option value="0"></option>
									<%
										List<Job> jobs = (List<Job>) session.getAttribute("jobs");
										for (int i = 0; i < jobs.size(); i++) {
											out.println("<option value='" + jobs.get(i).getJobId() + "'>" + jobs.get(i).getJobName() + "</option>");
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="deptID1" class="col-sm-2 control-label">部门</label>
							<div class="col-sm-10">
								<select id="deptID1" class="form-control" name="dept.deptId">
									<option value="0"></option>
									<%
										List<Dept> depts = (List<Dept>) session.getAttribute("depts");
										for (int i = 0; i < depts.size(); i++) {
											out.println(
													"<option value='" + depts.get(i).getDeptId() + "'>" + depts.get(i).getDeptName() + "</option>");
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="workState1" class="col-sm-2 control-label">状态</label>
							<div class="col-sm-10">
								<select id="workState1" class="form-control" name="workState">
									<option value=""></option>
									<option value="在职">在职</option>
									<option value="离职">离职</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="agreement1" class="col-sm-2 control-label">就职协议</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="agreement1"
									name="agreement">
							</div>
						</div>
						<div class="form-group">
							<label for="pwd1" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="pwd1" name="pwd">
							</div>
						</div>
						<div class="form-group">
							<label for="userLevel1" class="col-sm-2 control-label">用户级别</label>
							<div class="col-sm-10">
								<select id="userLevel1" class="form-control" name="userLevel">
									<option value="0"></option>
									<option value="1">高级用户</option>
									<option value="2">中级用户</option>
									<option value="3">普通用户</option>
								</select>
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="bt1">提交更改</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>

	<div class="modal fade" id="addStaff" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<h4 class="modal-title text-center" id="myModalLabel">员工信息</h4>
				</div>
				<div class="modal-body">

					<form class="form-horizontal" role="form" id="form"
						action="${pageContext.servletContext.contextPath}/Staff/add"
						method="get">
						<div class="form-group">
							<label for="employeeName" class="col-sm-2 control-label">名字</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="employeeName"
									name="employeeName" placeholder="请输入名字">
							</div>
						</div>
						
						<div class="form-group">
							<label for="email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10">
								<input type="email" class="form-control" id="email" name="email" onblur="checkemail()">
								<span class="text-danger" id="msg"></span>
							</div>
						</div>
						
						<div class="form-group">
							<label for="sex" class="col-sm-2 control-label">性别</label>
							<div class="col-sm-10">
								<select class="form-control" id="sex" name="sex">
									<option value="男">男</option>
									<option value="女">女</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="birthday" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10">
								<div class="input-append date form_datetime">
									<input type="date" value="" class="form-control" id="birthday"
										name="birthday" readonly="readonly" > <span
										class="add-on"><i class="icon-th"></i></span>
								</div>
							</div>
						</div>
						<div class="form-group">
							<label for="address" class="col-sm-2 control-label">地址</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="address"
									name="address">
							</div>
						</div>
						<div class="form-group">
							<label for="NOcode" class="col-sm-2 control-label">身份证号</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="NOcode"
									name="NOcode">
							</div>
						</div>
						<div class="form-group">
							<label for="learn" class="col-sm-2 control-label">学历</label>
							<div class="col-sm-10">
								<select id="learn" class="form-control" name="learn">
									<option value="高中">高中</option>
									<option value="专科">专科</option>
									<option value="本科">本科</option>
									<option value="硕士">硕士</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="mobile" class="col-sm-2 control-label">手机号</label>
							<div class="col-sm-10">
								<input type="tel" class="form-control" id="mobile" name="mobile">
							</div>
						</div>
						
						<div class="form-group">
							<label for="jobID" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10">
								<select id="jobID" class="form-control" name="job.jobId">
									<%
										for (int i = 0; i < jobs.size(); i++) {
											out.println("<option value='" + jobs.get(i).getJobId() + "'>" + jobs.get(i).getJobName() + "</option>");
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="deptID" class="col-sm-2 control-label">部门</label>
							<div class="col-sm-10">
								<select id="deptID" class="form-control" name="dept.deptId">
									<%
										for (int i = 0; i < depts.size(); i++) {
											out.println(
													"<option value='" + depts.get(i).getDeptId() + "'>" + depts.get(i).getDeptName() + "</option>");
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="workState" class="col-sm-2 control-label">状态</label>
							<div class="col-sm-10">
								<select id="workState" class="form-control" name="workState">
									<option value="在职">在职</option>
									<option value="离职">离职</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="agreement" class="col-sm-2 control-label">就职协议</label>
							<div class="col-sm-10">
								<input type="text" class="form-control" id="agreement"
									name="agreement">
							</div>
						</div>
						<div class="form-group">
							<label for="pwd" class="col-sm-2 control-label">密码</label>
							<div class="col-sm-10">
								<input type="password" class="form-control" id="pwd" name="pwd">
							</div>
						</div>
						<div class="form-group">
							<label for="userLevel" class="col-sm-2 control-label">用户级别</label>
							<div class="col-sm-10">
								<select id="userLevel" class="form-control" name="userLevel">
									<option value="1">高级用户</option>
									<option value="2">中级用户</option>
									<option value="3">普通用户</option>
								</select>
							</div>
						</div>
					</form>

				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="bt">提交更改</button>
				</div>
			</div>
			<!-- /.modal-content -->
		</div>
		<!-- /.modal -->
	</div>
</body>
</html>