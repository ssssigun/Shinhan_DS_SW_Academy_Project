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
  
  <script>
  	function CallingAdeletion(flag, planID){
  		var confirmed = confirm("이 계획을 삭제하시겠습니까?");
  		if(confirmed){
  			var url = "deleting.do?flag="+flag+"&plan_pk="+planID;
  	  		location.href=url;
  	  		history(1);
  		}
  		
  	}
  	
  	function callingWritingReview(plan_pk){
  		var confirming = confirm("장소 별 후기를 작성하시겠습니까?");
  		if(confirming){
  			var url = "writingReviews.do?plan_pk="+plan_pk;
  	  		location.href=url;
  		}
  	}
  	
  	function moveTOTotalReview(plan_pk){
		  var goOrnot = confirm("전체 후기를 작성하시겠습니까?");
		  if(goOrnot){
			  var url = "reviewUpdating.do?plan_pk="+plan_pk;
	  	  	  location.href=url;
		  }
	  }
  	
  	function editing(plan_pk){
  		var f = confirm("계획을 수정하시겠습니까?");
		  if(f){
			  var url = "/main/plan/plan.do?plan_pk="+plan_pk;
	  	  	  location.href=url;
		  }
  	}
  	
  	function viewingOLR(plan_pk){
  		var url = "viewingOLR.do?plan_pk="+plan_pk;
  		location.href=url;
  	}
  	
  	function viewingTR(plan_pk){
  		var url = "viewingTR.do?plan_pk="+plan_pk;
  		location.href=url;
  	}
  </script>
</head>
<body>
  <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>

  <div class="contents">
    <!-- 이 부분에 헤더 푸터 사이에 들어가는 것들 넣어주세요. -->
    <!-- 정렬이 페이지마다 조금씩 달라서 wrapper 역할을 할 div(width: 100%, height: 100% + 원하는 정렬 등) 넣고 그 안에 요소들 넣으면 될 것 같습니다. -->
    <!-- common.css 파일은 수정하지 않고 새로운 css 파일을 추가 후 스타일 작성 -->
    
    	<div class="recordAndAccountBook">
	    	<a href="" class="record bigbigLetter selectLetter" >여행 기록</a>
	    	<a href="/main/myRecord/accountBook/index.do" class="accountBook bigbigLetter">가계부</a>
    	</div>

    		<div class="planAndReviewAndTempSave">
	    		<button id="plan" class="plan btn softblueBwhiteL" onClick="location.href='index.do'">계획</button>
	    		<button id="review" class="review btn softblueBwhiteL" onClick="location.href='reviewing.do'">후기</button>
	    		<button id="tempSave" class="tempSave btn softblueBwhiteL" onClick="location.href='tempSaved.do'">임시저장</button>
    		</div>
    	
    	
    	<div class="postsWrapper">
    	<c:if test="${flag eq  '1'}">
    		<c:if test="${result.totalCount gt 0 }">
		    	<c:forEach var="vo" items="${result.list }">
		    		<div class="postWrapper">
	            <div class="photoWrapper" style="background-color: transparent; position:relative;">
	            	<img src="/main/image/logoMain.png" style="width:342.844px; height:212px; position: absolute; top: 0; left: 0;"/>
	             	<div class="state yellowBblackL">예정된 계획</div>
	            </div>
	            <div class="postInfoWrapper">
	              <div class="titleWrapper">
	               	${vo.title}
	              </div>
	              <div class="subWrapper">${vo.num_of_people }인 | ${vo.budget }원</div>
	              <div class="subsubWrapper">${vo.start_date } ~ ${(vo.end_date) }</div>
	              <div class="buttonsWrapper">
	              	<button class="smallBtn blueBwhiteL" onclick="editing(${vo.plan_pk })">수정하기</button>
	              	<button class="smallBtn redBwhiteL del" onclick="CallingAdeletion(${flag},${vo.plan_pk})">삭제하기</button>
	              </div>
	            </div>
	          </div>
		    	</c:forEach>
	    	</c:if>
	    	<c:if test="${result.totalCount eq 0 }">
	    		<div class="noneWrapper bigLetter bold">
    				계획된 여행이 없습니다.
	    		</div>
	    	</c:if>
    	</c:if>
    	<c:if test="${flag eq  '2'}">
    		<c:if test="${result.totalPage gt 0 }">
		    	<c:forEach var="vo" items="${result.list }">
		    		<div class="postWrapper">
		              <div class="photoWrapper" style="background-color: transparent; position:relative;">
		              	 <img src="${pageContext.request.contextPath}/image/client/${vo.imagename}" onerror="this.src='/main/image/logoMain.png'" style="width:342.844px; height:212px; position: absolute; top: 0; left: 0;"/>  
			    		  	<div class="state greenBblackL">종료된 계획</div>
		              </div>
		              <div class="postInfoWrapper">
		                <div class="titleWrapper">
		                 	${vo.title}
		                </div>
		                <div class="subWrapper">${vo.num_of_people }인 | ${vo.budget }원</div>
		                <div class="subsubWrapper">${vo.start_date } ~ ${(vo.end_date) }</div>
		                <div class="buttonsWrapper">
		                <c:choose>
		                	<c:when test="${vo.reviewed == 1 }">
		                		<c:choose>
		                			<c:when test="${vo.reviewed2 == 0 }">
		                				<button class="smallBtn blueBwhiteL" style="color:black; cursor:default">한줄평 완료</button>
		                				<button class="smallBtn blueBwhiteL" onclick="moveTOTotalReview(${vo.plan_pk})">후기 쓰기</button>
		                			</c:when>
		                			<c:otherwise>
		                				<button class="smallBtn blueBwhiteL" style="color:black; background-color:#9B9B9B; cursor:default">한줄평 완료</button>
		                				<button class="smallBtn blueBwhiteL" style="color:black; background-color:#9B9B9B; cursor:default"">후기 완료</button>
		                			</c:otherwise>
		                		</c:choose>	
		                	</c:when>
		                	<c:otherwise>
		                		<c:choose>
		                			<c:when test="${vo.reviewed2 == 0 }">
			                			<button class="smallBtn blueBwhiteL" onclick="callingWritingReview(${vo.plan_pk})">한줄평 쓰기</button>
				                		<button class="smallBtn blueBwhiteL" onclick="moveTOTotalReview(${vo.plan_pk})">후기 쓰기</button>
			                		</c:when>
				                	<c:otherwise>
				                		<button class="smallBtn blueBwhiteL" onclick="callingWritingReview(${vo.plan_pk})">한줄평 쓰기</button>
			                			<button class="smallBtn blueBwhiteL" style="color:black; background-color:#9B9B9B; cursor:default"">후기 완료</button>
				                	</c:otherwise>
		                		</c:choose>	
		                	</c:otherwise>
		                </c:choose>	
		                </div>
		              </div>
		            </div>
		    		</c:forEach>
		    	</c:if>
		    	<c:if test="${result.totalCount eq 0 }">
		    		<div class="noneWrapper bigLetter bold">
	    				다녀온 여행이 없습니다.
		    		</div>
		    	</c:if>
	    	</c:if>
	    	<c:if test="${flag eq  '3'}">
	    		<c:if test="${result.totalCount gt 0}">
			    	<c:forEach var="vo" items="${result.list }">
			    		<div class="postWrapper">
			              <div class="photoWrapper" style="background-color: transparent; position:relative;">
			              	<img src="/main/image/logoMain.png" style="width:342.844px; height:212px; position: absolute; top: 0; left: 0;"/>
				    		  		<div class="state lightblueBblackL">임시저장됨</div>
			              </div>
			              <div class="postInfoWrapper">
			                <div class="titleWrapper">
			                 	${vo.title}
			                </div>
			                <div class="subWrapper">${vo.num_of_people }인 | ${vo.budget }원</div>
			                <div class="subsubWrapper">${vo.start_date } ~ ${(vo.end_date) }</div>
			                <div class="buttonsWrapper">    	
			                	<button class="smallBtn blueBwhiteL" onclick="editing(${vo.plan_pk })">수정하기</button>
			                	<button class="smallBtn redBwhiteL del" onclick="CallingAdeletion(${flag},${vo.plan_pk})">삭제하기</button>
			                </div>
			              </div>
			            </div>
			    	</c:forEach>
			    </c:if>
		    	<c:if test="${result.totalCount eq 0 }">
		    		<div class="noneWrapper bigLetter bold">
	    				임시저장된 여행이 없습니다.
		    		</div>
		    	</c:if>
	    	</c:if>   
        </div>
        
		<div class="pagenate clear">
          <ul class='paging'>
          <c:if test="${flag eq '1' }">
          	<c:if test="${result.prev == true }">
               <li><a href="index.do?page=${result.startPage-1 }"> &lt </a></li>
             </c:if>
             <c:forEach begin="${result.startPage }" end="${result.endPage }" var="num">
               <li class="pagenationNumbers"><a href='index.do?page=${num }' <c:if test="${noticeVO.page == num }">class='current'</c:if>>${num }</a></li>
             </c:forEach>
             <c:if test="${result.next == true }">
                <li><a href="index.do?page=${result.endPage+1 }"> &gt </a></li>
             </c:if>
          </c:if>
          <c:if test="${flag eq '2' }">
          	<c:if test="${result.prev == true }">
               <li><a href="reviewing.do?page=${result.startPage-1 }"> &lt </a></li>
             </c:if>
             <c:forEach begin="${result.startPage }" end="${result.endPage }" var="num">
               <li class="pagenationNumbers"><a href='reviewing.do?page=${num }' <c:if test="${noticeVO.page == num }">class='current'</c:if>>${num }</a></li>
             </c:forEach>
             <c:if test="${result.next == true }">
                <li><a href="reviewing.do?page=${result.endPage+1 }"> &gt </a></li>
             </c:if>
          </c:if>
          <c:if test="${flag eq '3' }">
          	<c:if test="${result.prev == true }">
               <li><a href="tempSaved.do?page=${result.startPage-1 }"> &lt </a></li>
             </c:if>
             <c:forEach begin="${result.startPage }" end="${result.endPage }" var="num">
               <li class="pagenationNumbers"><a href='tempSaved.do?page=${num }' <c:if test="${noticeVO.page == num }">class='current'</c:if>>${num }</a></li>
             </c:forEach>
             <c:if test="${result.next == true }">
                <li><a href="tempSaved.do?page=${result.endPage+1 }"> &gt </a></li>
             </c:if>
          </c:if>  
          </ul> 
        </div>
    
  </div>
  
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>
<script>
	if (${flag} == 1) {
		$('#plan').addClass('selectButton');
		$('#review').removeClass('selectButton');
		$('#tempSave').removeClass('selectButton');
	}
	else if (${flag} == 2) {
		$('#plan').removeClass('selectButton');
		$('#review').addClass('selectButton');
		$('#tempSave').removeClass('selectButton');
	}
	else if (${flag} == 3) {
		$('#plan').removeClass('selectButton');
		$('#review').removeClass('selectButton');
		$('#tempSave').addClass('selectButton');
	}
</script>
</html>