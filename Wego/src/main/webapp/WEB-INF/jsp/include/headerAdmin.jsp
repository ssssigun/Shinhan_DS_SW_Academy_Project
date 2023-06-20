<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%--사용할 곳에 붙여넣기! <jsp:include page="/WEB-INF/jsp/include/headerAdmin.jsp"/> --%> 

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
  <div class="header">
    <div class="headerTop">
      <div class="topText">
        <p><a href="/main/admin/login.do">로그아웃</a></p>
      </div>
    </div>
    <div class="headerBottom">
      <div class="picBottom">
        <a href=""><img src="/main/image/logoMain.png" alt=""></a>
        <img class="admin" src="/main/image/logo_admin.png" alt="" style="display: inline-block;">
      </div>
      <ul>
        <li class="menu"><p><a href="/main/admin/boardManagement.do">신고 게시물</a></p></li>
        <li class="menu"><p><a href="/main/admin/userManagement.do">신고 유저</a></p></li>
      </ul>
    </div>
  </div>
</body>
</html>