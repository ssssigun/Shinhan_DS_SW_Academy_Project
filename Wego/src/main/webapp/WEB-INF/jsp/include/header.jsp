<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

    <%--사용할 곳에 붙여넣기! <jsp:include page="/WEB-INF/jsp/include/header.jsp"/> --%> 

<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/main/css/header.css">
<title>Insert title here</title>
</head>
<body>
  <div class="header">
    <div class="headerTop">
      <div class="topText">
        <p><a href="">로그아웃</a></p>
        <p><a href="/main/myPage/check.do">마이 페이지</a></p>
      </div>
    </div>
    <div class="headerBottom">
      <div class="picBottom">
        <a href="/main/main.do"><img src="/main/image/logoMain.png" alt=""></a>
        <img class="admin" src="/main/image/logo_admin.png" alt="">
      </div>
      <ul>
        <li class="menu"><p><a href="/main/plan/index.do">여행 계획</a></p></li>
        <li class="menu"><p><a href="/main/review/index.do">여행 후기</a></p></li>
        <li class="menu"><p><a href="/main/myRecord/plan/index.do">나의 기록</a></p></li>
      </ul>

    </div>
  </div>
</body>
</html>