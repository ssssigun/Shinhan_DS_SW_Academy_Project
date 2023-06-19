<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="google" content="notranslate">
  <link rel="icon" href="../../../image/ShinhanLogo.png"/>
  <link rel="stylesheet" href="../../../css/common.css">
  <link rel="stylesheet" href="../../../css/footer.css">
  <link rel="stylesheet" href="../../../css/header.css">
  <link rel="stylesheet" href="../../../css/myPage/mypagePwd.css">
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

  <title>common</title>
</head>
<body>
  <div class="header">
    <div class="headerTop">
      <div class="topText">
        <p><a href="">로그아웃</a></p>
        <p><a href="">마이 페이지</a></p>
      </div>
    </div>
    <div class="headerBottom">
      <div class="picBottom">
        <a href=""><img src="../../../image/logoMain.png" alt=""></a>
        <img class="admin" src="../../../image/logo_admin.png" alt="">
      </div>
      <ul>
        <li class="menu"><p><a href="">여행 계획</a></p></li>
        <li class="menu"><p><a href="">여행 후기</a></p></li>
        <li class="menu"><p><a href="">나의 기록</a></p></li>
      </ul>

    </div>
  </div>
  <div class="contents">
    <div class="contentTop">
      <p class="title">마이페이지</p>
    </div>
    <div class="contentBottom">
      <div class="info">
        <div class="infoText">
          <p class="letter">마이페이지에 접속하려면</p>
          <p class="letter">비밀번호를 입력하셔야 합니다.</p>
        </div>
        <div class="inputWrapper inputBox">
          <input class="input" type="text" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요.">
        </div>
        <div class="btnArea">
          <input class="inputBtn btn blueBwhiteL" type="submit" name="btn" id="btn" value="입력" >
        </div>
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
      <img src="../../../image/pic1.png" alt="">
      <img src="../../../image/pic2.png" alt="">
    </div>
  </div>
</body>
</html>
