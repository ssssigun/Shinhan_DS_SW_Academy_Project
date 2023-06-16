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
    <link rel="stylesheet" href="css/common.css" />
    <link rel="stylesheet" href="css/review_update.css" />
    <title>common</title>
  </head>
  <body>
    <div class="header"></div>
    <div class="contents">
      <div class="ContentsContainer">
        <h3 class="titleUpdate">전체 후기 수정</h3>
      </div>
      <div class="writeWrapper">
        <div class="writeTable">
          <div class="titleWrapper">
            <h3 class="title">제목</h3>
            <div class="preFrame">
              <h3 class="pretitle">[기존 제목]</h3>
            </div>
          </div>
          <hr />
          <div class="contentsWrapper">
            <h3 class="content">내용</h3>
            <div class="FrameCon">
              <h3 class="precontent">[기존 내용]</h3>
            </div>
          </div>
          <div class="attachmentWrapper">
            <div class="Frame63">
              <h3 class="imgattach">사진 첨부</h3>
              <h3 class="imgattachExplain">
                가장 앞의 사진이 목록에서 대표사진으로 보여집니다.
              </h3>
            </div>
            <div class="photoWrapper">
              <img src="/image/attachimg.png" />
            </div>
            <div class="Frame62">
              <img src="/image/BsFillPlusCircleFill.png" />
            </div>
          </div>
        </div>
      </div>
      <div class="bottomWrapper">
        <button type="button1" onclick="">나가기</button>
        <button type="button2" onclick="">저장</button>
      </div>
    </div>
    <div class="footer"></div>
  </body>
</html>
