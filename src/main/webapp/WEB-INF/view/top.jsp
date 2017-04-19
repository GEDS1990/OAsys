<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <nav class="navbar navbar-default navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="#">在线办公系统</a>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
          	<li><img  class="img-responsive" alt="Cinque Terre" src="${pageContext.servletContext.contextPath}${user.photo}" height="20px" width="30px"></li>
          	<li><a href="#">${user.employeeName}</a></li>
            <li><a href="${pageContext.servletContext.contextPath}/out">退出登录</a></li>
          </ul>
        </div>
      </div>
    </nav>