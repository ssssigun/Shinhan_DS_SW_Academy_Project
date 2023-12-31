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
      <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
    <div class="contents">
      <div class="ContentsContainer">
        <h3 class="title">전체 후기 작성</h3>
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
 <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
  
  </body>
</html>
