<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="google" content="notranslate" />
    <link rel="icon" href="../image/ShinhanLogo.png" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/header.css" />
    <link rel="stylesheet" href="../css/footer.css" />
    <link rel="stylesheet" href="../css/review/review_update.css" />
    <title>common</title>
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
        <li class="menu"><p><a href="">여행 후기</a></p></li>
        <li class="menu"><p><a href="">나의 기록</a></p></li>
      </ul>

    </div>
  </div>
    <div class="contents">
      <div class="ContentsContainer">
        <h3 class="title">전체 후기 수정</h3>
      </div>
      <div class="writeWrapper">
        <div class="writeTable">
          <div class="titleWrapper">
            <h3 class="title">제목</h3>
            <div class="preFrame">
              <h3 class="bigbitLetter">[기존 제목]</h3>
            </div>
          </div>
          <hr />
          <div class="contentsWrapper">
            <h3 class="title">내용</h3>
            <div class="FrameCon">
              <h3 class="letter">[기존 내용]</h3>
            </div>
          </div>
          <div class="attachmentWrapper">
            <div class="Frame63">
              <h3 class="imgattach">사진 첨부</h3>
              <h3 class="imgattachExplain">
                가장 앞의 사진이 목록에서 대표사진으로 보여집니다.
              </h3>
            </div>
             <div class="photo">
              <div class="photoWrapper">
                <img src="../image/review/attachimg.png" />
              </div>
              <div class="Frame62">
                <img src="../image/review/BsFillPlusCircleFill.png" />
              </div>
          </div>
        </div>
      </div>
      <div class="bottomWrapper">
        <div class="btn lightskyBblackL">나가기</div>
        <div class="btn blueBwhiteL">저장</div>
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
      <img src="/main/image/pic1.png" alt="">
      <img src="/main/image/pic2.png" alt="">
    </div>
  </div>
  
  </body>
</html>