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
  
  
  <link rel="stylesheet" href="/main/css/myRecord/plan.css"> 

  <title>활동 내역 확인</title>
</head>
<body>
  <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>

  <div class="contents">
    <!-- 이 부분에 헤더 푸터 사이에 들어가는 것들 넣어주세요. -->
    <!-- 정렬이 페이지마다 조금씩 달라서 wrapper 역할을 할 div(width: 100%, height: 100% + 원하는 정렬 등) 넣고 그 안에 요소들 넣으면 될 것 같습니다. -->
    <!-- common.css 파일은 수정하지 않고 새로운 css 파일을 추가 후 스타일 작성 -->
    
    	<div class="recordAndAccountBook">
	    	<a href="" class="record bigbigLetter selectLetter" >여행 기록</a>
	    	<!-- 아래 href에 정은이 가계부 메인화면 링크 집어넣으면 됨 -->
	    	<a href="" class="accountBook bigbigLetter">가계부</a>
    	</div>

    		<div class="planAndReviewAndTempSave">
	    		<button type="button" class="plan btn blueBwhiteL" onClick="location.href='index.do'">계획</button>
	    		<button class="review btn blueBwhiteL" onClick="location.href='reviewing.do'">후기</button>
	    		<button class="tempSave btn blueBwhiteL" onClick="location.href='tempSaved.do'">임시저장</button>
    		</div>
    	
    	
    	<div class="postsWrapper">
    	<c:if test="${flag eq  '1'}">
	    	<c:forEach var="vo" items="${result.list }">
	    		<div class="postWrapper">
	              <div class="photoWrapper">
		              <span class="btn yellowBblackL willdo">예정된 계획</span>
	              </div>
	              <div class="postInfoWrapper">
	                <div class="titleWrapper">
	                 	${vo.title}
	                </div>
	                <div class="subWrapper">${vo.number_of_people }인 | ${vo.budget }원</div>
	                <div class="subsubWrapper">${vo.start_date } ~ ${(vo.end_date) }</div>
	                <div class="buttonsWrapper">
	                	<button class="smallBtn redBwhiteL">삭제하기</button>
	                	<button class="smallBtn blueBwhiteL">수정하기</button>
	                </div>
	              </div>
	            </div>
	    	</c:forEach>
	    	</c:if>
	    	<c:if test="${flag eq  '2'}">
	    	<c:forEach var="vo" items="${result.list }">
	    		<div class="postWrapper">
	              <div class="photoWrapper">
		    		  <span class="btn greenBblackL alldone">종료된 계획</span>
	              </div>
	              <div class="postInfoWrapper">
	                <div class="titleWrapper">
	                 	${vo.title}
	                </div>
	                <div class="subWrapper">${vo.number_of_people }인 | ${vo.budget }원</div>
	                <div class="subsubWrapper">${vo.start_date } ~ ${(vo.end_date) }</div>
	                <div class="buttonsWrapper">
	                	<button class="smallBtn blueBwhiteL">후기 쓰기</button>
	                </div>
	              </div>
	            </div>
	    	</c:forEach>
	    	</c:if>
	    	<c:if test="${flag eq  '3'}">
	    	<c:forEach var="vo" items="${result.list }">
	    		<div class="postWrapper">
	              <div class="photoWrapper">
		    		  <span class="btn lightblueBblackL tempSaved">임시저장된 계획</span>
	              </div>
	              <div class="postInfoWrapper">
	                <div class="titleWrapper">
	                 	${vo.title}
	                </div>
	                <div class="subWrapper">${vo.number_of_people }인 | ${vo.budget }원</div>
	                <div class="subsubWrapper">${vo.start_date } ~ ${(vo.end_date) }</div>
	                <div class="buttonsWrapper">
	                	<button class="smallBtn redBwhiteL">삭제하기</button>
	                	<button class="smallBtn blueBwhiteL">수정하기</button>
	                </div>
	              </div>
	            </div>
	    	</c:forEach>
	    	</c:if>   
        </div>
        

    
  </div>
  
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>
</html>