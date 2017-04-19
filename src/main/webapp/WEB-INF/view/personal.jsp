<%@page import="com.entity.Job"%>
<%@page import="com.entity.Dept"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人管理</title>
<script
	src="http://cdn.static.runoob.com/libs/jquery/1.10.2/jquery.min.js"></script>
<!-- 最新版本的 Bootstrap 核心 CSS 文件 -->
<link rel="stylesheet"
	href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
<!-- 最新的 Bootstrap 核心 JavaScript 文件 -->
<script
	src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link href="${pageContext.servletContext.contextPath}/dashboard.css"
	rel="stylesheet">
<!-- Latest compiled and minified CSS -->
<!-- Latest compiled and minified CSS -->
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.css">

<link rel="stylesheet"
	href="//rawgit.com/wenzhixin/bootstrap-table/master/src/bootstrap-table.css">
<link rel="stylesheet"
	href="//rawgit.com/vitalets/x-editable/master/dist/bootstrap3-editable/css/bootstrap-editable.css">

<!-- Latest compiled and minified JavaScript -->
<script
	src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/bootstrap-table.min.js"></script>

<!-- Latest compiled and minified Locales -->
<script
	src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.11.1/locale/bootstrap-table-zh-CN.min.js"></script>

<script
	src="//rawgit.com/vitalets/x-editable/master/dist/bootstrap3-editable/js/bootstrap-editable.js"></script>
<script
	src="//rawgit.com/wenzhixin/bootstrap-table/master/src/extensions/editable/bootstrap-table-editable.js"></script>
<link rel="stylesheet"
	href="${pageContext.servletContext.contextPath}/bootstrap-datetimepicker.min.css">
<script
	src="${pageContext.servletContext.contextPath}/bootstrap-datetimepicker.min.js"></script>
<script
	src="${pageContext.servletContext.contextPath}/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript">
	$(function() {
		if ("${user.userLevel}" == 2) {
			$("#c").remove();
			$("#e").remove();
		} else if ("${user.userLevel}" == 3) {
			$("#b").remove();
			$("#c").remove();
			$("#e").remove();
		}
		$(".form_datetime").datetimepicker({
			startDate : "1980-01-01",
			minView : "month",
			language : "zh-CN",
			format : "yyyy-mm-dd",
			autoclose : true,
			todayBtn : true,
			pickerPosition : "bottom-right"
		});
		$('#table1')
		.bootstrapTable(
				{
					idField : 'taskId',
					url : '${pageContext.servletContext.contextPath}/person/tasks?randid='+<%=Math.random()%>,
					columns : [
							{
								field : 'taskId',
								title : 'ID'
							},
							{
								field : 'taskState',
								title : "<span class='text-danger'>状态</span>",
								editable : {
									type : 'select',
									title : '状态',
									source : [ {
										value : '已完成',
										text : '已完成'
									}, {
										value : '未完成',
										text : '未完成'
									} ]
								}
							}, {
								field : 'getTime',
								title : '时间'
							},

							{
								field : 'taskName',
								title : '名称'
							}, {
								field : 'taskInfo',
								title : '介绍'
							}, {
								field : 'action',
								title : '操作',
								formatter : 'actionFormatter',
								events : 'actionEvents'
							} ],
					onEditableSave : function(field, row, oldValue,
							$el) {
						var task = {};
						task['taskId'] = row.taskId;
						task['taskState'] = row.taskState;
						task['taskName'] = row.taskName;
						task['taskInfo'] = row.taskInfo;
						task['getTime'] = row.getTime;
						$
								.ajax({
									type : 'post',
									url : '${pageContext.servletContext.contextPath}/person/updateTask',
									data : JSON.stringify(task),
									contentType : 'application/json',
									success : function(data) {
										alert('修改成功');
									},
									error : function() {
										alert('修改失败');
									},
									complete : function() {

									}

								});
					}
				});
		$("#bt")
		.click(
				function() {
					var taskName = $("#taskName").val();
					var taskInfo = $("#taskInfo").val();
					var getTime = $("#getTime").val();
					var task = {};
					task['taskName'] = taskName;
					task['taskInfo'] = taskInfo;
					task['getTime'] = getTime;
					$
							.ajax({
								type : 'post',
								url : '${pageContext.servletContext.contextPath}/person/addTask',
								data : JSON.stringify(task),
								contentType : 'application/json',
								success : function(data) {
									$('#addTask').modal('hide');
									$("#table1")
											.bootstrapTable(
													"refresh",
													{
														url : '${pageContext.servletContext.contextPath}/person/tasks?randid'
																+
<%=Math.random()%>
});

								},
								error : function() {
									alert('添加失败');
								},
								complete : function() {

								}

							});
				})
});
function actionFormatter(value, row, index) {
		return [
				'<a class="remove ml10" href="javascript:void(0)" title="删除">',
				'<i class="glyphicon glyphicon-remove"></i>', '</a>' ].join('');
	}

	window.actionEvents = {
		'click .remove' : function(e, value, row, index) {
			$
					.post(
							"${pageContext.servletContext.contextPath}/person/deleteTask",
							{
								'taskId' : row.taskId

							}, function(data, status) {

								if (status == "success")
									$("#table1").bootstrapTable(
											'removeByUniqueId', row.taskId);

							});
		}
	};
	function sub() {
		$("#updateform").submit();
	}
	function updatepwd() {
		var npwd = $("#npwd").val();
		if ($("#opwd").val() == "${user.pwd}") {
			$
					.post(
							"${pageContext.servletContext.contextPath}/person/updatepwd",
							{
								"npwd" : npwd

							}, function(data, status) {
								$("#npwd").val("");
								$("#opwd").val("");
								alert("修改成功")
							});
		}

		else
			alert("密码错误");
	}
	function checkemail() {
		var email = $("#email1");
		if (email.val() != "" && $("#mag").text() != "改邮箱可以修改") {

			$.post("${pageContext.servletContext.contextPath}/check", {
				"email" : email.val()
			}, function(data, status) {
				if (data == "success")
					$("#msg").html("改邮箱可以修改");
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

				<div class="panel-group" id="accordion">
					<div class="panel panel-warning">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseOne"> 个人计划 </a>
							</h4>
						</div>
						<div id="toolbar" class="btn-group">
							<button type="button" class="btn  btn-info" data-toggle="modal"
								data-target="#addTask">添加任务</button>
						</div>
						<div id="collapseOne" class="panel-collapse collapse in">
							<div class="panel-body">
								<table data-card-view="true" data-pagination="true"
									data-cache="flase" id="table1" data-unique-id="taskId"
									data-toolbar="#toolbar">
								</table>
							</div>
						</div>
					</div>
					<div class="panel panel-info">
						<div class="panel-heading">
							<h4 class="panel-title">
								<a data-toggle="collapse" data-parent="#accordion"
									href="#collapseTwo"> 个人信息 </a>
							</h4>
						</div>
						<div id="collapseTwo" class="panel-collapse collapse in">
							<div class="panel-body">
								<table class="table table-bordered">
									<tr>
										<td class="text-right">身份证:</td>
										<td class="text-left">${user.nocode}</td>
										<td class="text-right">姓名:</td>
										<td class="text-left">${user.employeeName}</td>
										<td class="text-right">性别:</td>
										<td class="text-left">${user.sex}</td>
										<td class="text-right">生日:</td>
										<td class="text-left">${birthday}</td>
										<td class="text-left" rowspan="2" colspan="2"><img
											class="img-responsive" alt="Cinque Terre"
											src="${pageContext.servletContext.contextPath}${user.photo}"
											height="100px" width="60px"></td>
									</tr>
									<tr>
										<td class="text-right">手机号:</td>
										<td class="text-left">${user.mobile}</td>
										<td class="text-right">邮箱:</td>
										<td class="text-left">${user.email}</td>
										<td class="text-right">职位:</td>
										<td class="text-left">${user.job.jobName}</td>
										<td class="text-right">部门:</td>
										<td class="text-left">${user.dept.deptName}</td>
									</tr>
									<tr>
										<td class="text-right">地址:</td>
										<td class="text-left">${user.address}</td>
										<td class="text-right">学历:</td>
										<td class="text-left">${user.learn}</td>
										<td class="text-right">状态:</td>
										<td class="text-left">${user.workState}</td>
										<td class="text-right">就职协议:</td>
										<td class="text-left">${user.agreement}</td>
										<td class="text-right">用户级别:</td>
										<td class="text-left">${user.userLevel}</td>
									</tr>
								</table>
								<button type="button" class="btn  btn-info center-block"
									data-toggle="modal" data-target="#update">修改信息</button>

							</div>
						</div>
						<div class="panel panel panel-success">
							<div class="panel-heading">
								<h4 class="panel-title">
									<a data-toggle="collapse" data-parent="#accordion"
										href="#collapseThree"> 密码管理 </a>
								</h4>
							</div>
							<div id="collapseThree" class="panel-collapse collapse">
								<div class="panel-body">

									<form class="form-horizontal" role="form" id="pwdform"
										method="post">
										<div class="form-group">
											<label for="pwd" class="col-sm-2 control-label">旧密码</label>
											<div class="col-sm-10">
												<input type="password" class="form-control" id="opwd"
													name="opwd" placeholder="请输入旧密码">
											</div>
										</div>
										<div class="form-group">
											<label for="npwd" class="col-sm-2 control-label">新密码</label>
											<div class="col-sm-10">
												<input type="password" class="form-control" id="npwd"
													name="taskInfo" placeholder="请输入新密码">
											</div>
										</div>
										<div class="form-group">
											<div class="col-sm-offset-2 col-sm-10">
												<button type="button" class="btn btn-default"
													onclick="updatepwd()">修改</button>
											</div>
										</div>

									</form>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
		</div>

		<div class="modal fade" id="addTask" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">&times;</button>
						<h4 class="modal-title text-center" id="myModalLabel">添加任务</h4>
					</div>
					<div class="modal-body">

						<form class="form-horizontal" role="form" id="form1" method="post">
							<div class="form-group">
								<label for="taskName" class="col-sm-2 control-label">任务名</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="taskName"
										name="taskName" placeholder="请输入任务名">
								</div>
							</div>
							<div class="form-group">
								<label for="taskInfo" class="col-sm-2 control-label">任务信息</label>
								<div class="col-sm-10">
									<input type="text" class="form-control" id="taskInfo"
										name="taskInfo" placeholder="请输入任务信息">
								</div>
							</div>
						</form>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
						<button type="button" class="btn btn-primary" id="bt">提交</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
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

						<form class="form-horizontal" role="form" id="updateform"
							action="${pageContext.servletContext.contextPath}/person/updateUser"
							method="get">
							<input type="hidden" name="employeeId" value="${user.employeeId}">
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
										name="email" placeholder="同时为登陆账号" onblur="checkemail()">
									<span class="text-danger" id="msg"></span>
								</div>
							</div>

							<div class="form-group">
								<label for="sex1" class="col-sm-2 control-label">性别</label>
								<div class="col-sm-10">
									<select class="form-control" id="sex1" name="sex">
										<option value=""></option>
										<option value="男">男</option>
										<option value="女">女</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="birthday1" class="col-sm-2 control-label">生日</label>
								<div class="col-sm-10">
									<div class="input-append date form_datetime">
										<input type="date" value="" class="form-control"
											id="birthday1" name="birthday" readonly="readonly"> <span
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
						<button type="button" class="btn btn-primary" onclick="sub()">提交更改</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- /.modal -->
		</div>
	</div>
</body>
</html>