<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="google" content="notranslate">
  <link rel="icon" href="/main/image/ShinhanLogo.png"/>
  <link rel="stylesheet" href="/main/css/common.css">
  <link rel="stylesheet" href="/main/css/footer.css">
  <link rel="stylesheet" href="/main/css/header.css">
  <link rel="stylesheet" href="/main/css/myPage/mypageInfo.css">
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

  <title>common</title>
</head>
<body>
<jsp:include page='/WEB-INF/jsp/include/header.jsp'/>
  <div class="contents">
    <div class="contentTop">
      <p class="title">마이페이지</p>
    </div>
    <div class="contentBottom">
      <div class="infoUser">
        <p class="bigLetter">정보 수정</p>
        <div class="inputWrapper inputBox">
          <span class="letter">닉네임</span>
          <input class="input" type="text" name="pwd" id="pwd" placeholder="[원래 닉네임]">
          <input class="btnCommon btn blueBwhiteL" type="submit" name="btn" id="btn" value="중복확인" >
          <input class="btnCommon btn lightblueBblackL" type="submit" name="btn2" id="btn2" value="수정" >
        </div>
        <p class="bigLetter cardTitle">카드 정보</p>
      </div>
      <div class="infoCard">
        <div class="card">
          <div class="cardImg">
            <img src="/main/image/CardImg.png" alt="">
          </div>
          <div class="cardText">
            <ul>
              <li><p class="bigLetter bold">신한카드 We go</p></li>
              <li><img src="/main/image/PointImg.png" alt=""> <span class="letter">여행 총 경비 2.5% 포인트 적립</span></li>
              <li><img src="/main/image/PointImg.png" alt=""> <span class="letter">무이자 할부 6개월</span></li>
              <li><img src="/main/image/PointImg.png" alt=""> <span class="letter">계획 이행시 0.5% 포인트 추가 적립</span></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
<jsp:include page='/WEB-INF/jsp/include/footer.jsp'/>
</body>
</html>
