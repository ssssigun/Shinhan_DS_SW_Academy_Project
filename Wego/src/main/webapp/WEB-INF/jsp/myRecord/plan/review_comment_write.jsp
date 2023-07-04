<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix ="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
  
  
  <link rel="stylesheet" href="/main/css/myRecord/reviews.css"> 

  <title>장소별 한줄 평 작성</title>
</head>
<body>
  <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>

  <div class="contents">
    <div class="ContentsContainer">
        <h3 class="title">장소 별 한줄평 작성</h3>
      <div class="writeWrapper">
      <div class="oneLocation">
      	<div class="info">
      		<div class="day">
      			일차
      		</div>
      		<div class="firstLine">
      		장소명 : []-[]
	      		<div class="scoring">
	      			별점
		      		<form action="#">
		      			<select name="scores" id="score">
		      				<option value:"1">☆☆☆☆★</option>
		      				<option value:"2">☆☆☆★★</option>
		      				<option value:"3">☆☆★★★</option>
		      				<option value:"4">☆★★★★</option>
		      				<option value:"5">★★★★★</option>
		      			</select>
		      		</form>
	      		</div>
	      	</div>
	      	<div class="secondLine">
	      	    한줄평
	      	    <input type:"text" id="oneLineReview"/>
	      	</div>
      	</div>
      	
      </div>
    </div>
   </div>
   <div class="bottomWrapper">
	      <button class="btn lightskyBblackL">전체 후기</button>
	      <button class="btn blueBwhiteL">저장</button>
	      <button class="btn lightskyBblackL">나가기</button>
	</div>
  </div>
  
  
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>
</html>