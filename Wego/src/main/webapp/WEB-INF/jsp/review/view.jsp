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
     <script>
    	function goSave() {
    		//유효성처리했다치고
    		$("#frm").submit();
    		
    	}
    </script>
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
                <dt class="letter">${watch.review_watch_count }</dt>
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
                <dd class="bigLetter">${recommend.review_recommend_count }</dd>
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
				    <form method="get" name="frm" id="frm" action="commentDelete.do" enctype="multipart/form-data" >
				    <button class="deleteButton" type="submit">삭제</button>
				    </form>
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
         <form method="post" name="frm" id="frm" action="insertReviewComment.do" enctype="multipart/form-data" >
         	 <input type="hidden" name="user_pk" value="3"> <!-- user_pk 값을 여기에 설정 -->
         	 <input type="hidden" name="review_pk" value="${review_pk }"> <!-- user_pk 값을 여기에 설정 -->
	          <div class = "commentWrapper">
		          <div class="comment">
			          <div class="nicknameWrapper">
			          	<h3 class="letter">${nickname}</h3>
			          	<div class="contentsWrapper2">
				          	<textarea rows="3" cols="55" name="comment_content" id="content" class="FrameCon letter text">${insertReviewComment.content }</textarea>
				          	<button class="commentButton" type="submit">등록</button>
				       </div>
			          </div>
			      </div>    
	          </div>
         </form>
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
