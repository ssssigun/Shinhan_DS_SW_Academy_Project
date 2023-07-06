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
    <link rel="icon" href="../image/ShinhanLogo.png" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/header.css" />
    <link rel="stylesheet" href="../css/footer.css" />
    <link rel="stylesheet" href="../css/review/review_comment_write.css"/>
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
        <div class="writeWrapper">
          <div class="writeTable">
            <div class="titleWrapper">
              <h3 class="title">${data.title }</h3>
              <div class="viewCountWrapper">
                 <img src="../image/review/BsEye.png" />
                <dt class="letter">${data.review_watch_pk }</dt>
              </div>
            </div>
            <hr />
            <div class="contentsWrapper">
              <div class="contentsTitleWrapper">
                <h3 class="smallsmallLetter">${data.regdate }</h3>
              </div>
              <div class="review_contents">
                <dd class="letter">${data.content }</dd>
                <div class="image">
                  <img src="../image/review/attachimg.png" />
                </div>
              </div>
            </div>
          </div>
          <div class="contentsBottomWrapper">
            <div class="thumbsWrapper">
              <div class="thumbs">
                 <a href=""><img src="../image/review/thumbsup.png" /></a>
                <dd class="bigLetter">${data.review_recommend_pk }</dd>
              </div>
            </div>
            <a href=""><img src="../image/review/report.png" /></a>
          </div>
        </div>
        
        <div class="com">
         <div class="c">
        <c:forEach var="vo" items="${comments}">
          <div class="commentWrapper">
            <div class="comment">
              <div class="nicknameWrapper">
                <h3 class="letter">${vo.nickname}</h3>
                <div class="menuWrapper">
				  <a href="#"><img src="../image/review/menuWrapper.png" /></a>
				  <div class="buttonContainer">
				    <button class="editButton">수정</button>
				    <button class="deleteButton">삭제</button>
				  </div>
				</div>

              </div>
              <div class="contentsWrapper2">
                <div class="commentcontents">${vo.comment_content}</div>
              </div>
              <h3 class="commentdate">${vo.regdate_comment}</h3>
            </div>
          </div>
          </c:forEach>
          </div>
          <div class = "cominsert">
          	<h3 class="letter">${data.nickname}</h3>
          	<textarea name="content" id="content" class="FrameCon letter text">${data.content }</textarea>
          	<button class="commentButton">등록</button>
          	
          </div>
        </div>
        

        <div class="bottomWrapper">
          <div class="btn blueBwhiteL"><a href="/main/review/index.do">목록</a></div>
          </div>
          <!-- <button type="button" onclick="">목록</button> -->
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
