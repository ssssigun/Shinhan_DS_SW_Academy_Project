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
  <div class="header">
    <div class="headerTop">
      <div class="topText">
        <p><a href="">로그아웃</a></p>
      </div>
    </div>
    <div class="headerBottom">
      <div class="picBottom">
        <a href=""><img src="/image/logoMain.png" alt=""></a>
        <img class="admin" src="/image/logo_admin.png" alt="" style="display: inline-block;">
      </div>
      <ul>
        <li class="menu"><p><a href="">신고 게시물</a></p></li>
        <li class="menu"><p><a href="">신고 유저</a></p></li>
      </ul>

    </div>
  </div>
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
  <div class="footer">
    <div class="textFooter">
      <p>고객센터 대표번호 1588-0000</p>
      <p>이용약관 | 개인정보처리방침</p>  
      <p>사업자등록번호 : 222-222-2222</p>
      <p> 우) 03993 서울 마포구 월드컵북로 4길 77</p>
    </div>
    <div class="picFooter">
      <img src="../image/pic1.png" alt="">
      <img src="../image/pic2.png" alt="">
    </div>
  </div>
</body>
</html>
