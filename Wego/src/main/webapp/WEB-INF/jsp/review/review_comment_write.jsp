<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="google" content="notranslate" />
    <link rel="icon" href="favicon.png" />
    <link rel="stylesheet" href="css/common.css" />
    <link rel="stylesheet" href="css/review_comment_write.css" />
    <title>common</title>
  </head>
  <body>
    <div class="header"></div>
    <div class="contents">
      <div class="ContentsContainer">
        <div class="writeWrapper">
          <div class="writeTable">
            <div class="titleWrapper">
              <h3 class="title">제목 어쩌구저쩌구</h3>
              <div class="viewCountWrapper">
                <img src="/image/BsEye.png" />
                <dt class="letter">조회수 카운트 10</dt>
              </div>
            </div>
            <hr />
            <div class="contentsWrapper">
              <div class="contentsTitleWrapper">
                <h3 class="smallsmallLetter">2021-06-12</h3>
              </div>
              <div class="review_contents">
                <dd class="letter">저번주는 제주도에 갔어요^^*</dd>
                <div class="image">
                  <img src="/image/attachimg.png" />
                </div>
              </div>
            </div>
          </div>
          <div class="contentsBottomWrapper">
            <div class="thumbsWrapper">
              <div class="thumbs">
                <a href=""><img src="/image/thumbsup.png" /></a>
                <dd class="bigLetter">999</dd>
              </div>
            </div>
            <a href=""><img src="/image/report.png" /></a>
          </div>
        </div>
        <div class="com">
          <div class="commentWrapper">
            <div class="comment">
              <div class="nicknameWrapper">
                <h3 class="letter">[닉네임]</h3>
                <div class="menuWrapper">
                  <a href=""><img src="/image/menuWrapper.png" /></a>
                </div>
              </div>
              <div class="contentsWrapper2">
                <dd class="commentcontents">댓글 내용 어쩌구</dd>
              </div>
              <h3 class="commentdate">2023-06-14</h3>
            </div>
          </div>
        </div>

        <div class="bottomWrapper">
          <div class="btn blueBwhiteL">목록</div>
          </div>
          <!-- <button type="button" onclick="">목록</button> -->
        </div>
      </div>
    </div>
    <div class="footer"></div>
  </body>
</html>
