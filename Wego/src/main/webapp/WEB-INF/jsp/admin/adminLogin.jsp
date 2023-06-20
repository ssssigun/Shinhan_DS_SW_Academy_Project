<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="google" content="notranslate">
  <link rel="icon" href="../image/ShinhanLogo.png"/>
  <link rel="stylesheet" href="../css/common.css">
  <link rel="stylesheet" href="../css/footer.css">
  <link rel="stylesheet" href="../css/header.css">
  <link rel="stylesheet" href="../css/admin/adminLogin.css">
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

  <title>common</title>
</head>
<body>
<jsp:include page='/WEB-INF/jsp/include/headerAdmin.jsp'/>
  <div class="contents">
    <div class="login">
      <p class="title">관리자 로그인</p>
      <div class="loginInput">
        <div class="inputBox">
          <div class="idInput inputWrapper">
            <span class="letter inputText">아이디</span>
            <input class="input inputArea" type="text" name="id" id="id" placeholder="아이디를 입력해주세요.">
          </div>
          <div class="pwdInput inputWrapper">
            <span class="letter inputText">비밀번호</span>
            <input class="input inputArea" type="text" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요.">
          </div>
        </div>
        <input class="btn blueBwhiteL" type="submit"  value="로그인">
      </div>
    </div>
  </div>
<jsp:include page='/WEB-INF/jsp/include/footer.jsp'/>
</body>
</html>
