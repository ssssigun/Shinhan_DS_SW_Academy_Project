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
  
  <script>
	  function setInputValue(input) {
	    var value = input.value;	    
	    input.setAttribute("value", value);
	  }
	  
	  function submitFormWithConfirmation() {
	    // 확인 창 표시
	    var confirmed = confirm("저장하시겠습니까?");
	    
	    // 사용자가 "확인"을 선택한 경우에만 form 전송
	    if (confirmed && validateForm()) {
	      document.getElementById("datas").submit();
	      alert("저장 완료하였습니다.");
	    }else if(confirmed && ~validateForm()){
	    	alert("모든 입력란을 채워주세요.");
	    }else{
	    	
	    }
	  }
	  
	  function goBack2() {
		  var yesORnot = confirm("목록으로 돌아가시겠습니까?\n"
				  +"※주의)저장하지 않고 이동 시, 작성한 내용이 사라집니다.");
		  if(yesORnot){
			  history.go(-1); // A로 되돌아감
		  }
	    }
	  
	  function goBack2() {
		  var yesORnot = confirm("목록으로 돌아가시겠습니까?");
		  if(yesORnot){
			  history.go(-1); // A로 되돌아감
		  }
	    }
	  
	  function validateForm() {
		    var inputs = document.querySelectorAll('input[type="text"]');
		    for (var i = 0; i < inputs.length; i++) {
		      if (inputs[i].value === "") {
		        return false;
		      }
		    }
		    return true;
		  }
	</script>
  <title>장소별 한줄 평 작성</title>
</head>
<body>
  <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
	
	<c:choose>
		<c:when test="${flag == 'jv' }">
			<div class="contents">
		    <div class="ContentsContainer">
		        <h3 class="title">장소 별 한줄평 작성</h3>
		      <div class="writeWrapper">
		      
		      <c:forEach var="vo" items="${result}">
			      <div class="oneLocation">
			      	<div class="info">
			      		<div class="day">
			      			${vo.day }일차
			      		</div>
			      		<div class="firstLine">
			      		<c:choose>
			      			<c:when test="${vo.region eq '1'}">
			      				장소명 : [서울]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '2'}">
			      				장소명 : [인천]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '3'}">
			      				장소명 : [대전]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '4'}">
			      				장소명 : [대구]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '5'}">
			      				장소명 : [광주]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '6'}">
			      				장소명 : [부산]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '7'}">
			      				장소명 : [울산]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '8'}">
			      				장소명 : [세종]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '9'}">
			      				장소명 : [경기도]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '10'}">
			      				장소명 : [강원도]-[${vo.location_Name }]	  
			      			</c:when>	      				      		    		
			      		</c:choose>
				      		<div class="scoring">
				      			별점
					      		<select disabled name="scores">
									<option value="1" ${vo.star eq '1' ? 'selected' : ''}>★☆☆☆☆</option>
									<option value="2" ${vo.star eq '2' ? 'selected' : ''}>★★☆☆☆</option>
									<option value="3" ${vo.star eq '3' ? 'selected' : ''}>★★★☆☆</option>
									<option value="4" ${vo.star eq '4' ? 'selected' : ''}>★★★★☆</option>
									<option value="5" ${vo.star eq '5' ? 'selected' : ''}>★★★★★</option>
								</select>
				      		</div>
				      	</div>
				      	<div class="secondLine">
				      	    한줄평
				      	    <input disabled name="oneLineReviews" type="text" value="${vo.location_content}"/>
				      	</div>
			      	</div>
			      </div>      
		      </c:forEach>
		    </div>
		   </div>
		   <div class="bottomWrapper">
			      <button class="btn lightskyBblackL" type="button" onclick="goBack2()">나가기</button>
			</div>
		  </div>
		</c:when>
	
	<c:otherwise>
		<div class="contents">
		    <div class="ContentsContainer">
		        <h3 class="title">장소 별 한줄평 작성</h3>
		      <div class="writeWrapper">
		      <form action="/main/myRecord/plan/reviewing1.do" id="datas" method="post" name="reviewForm" onsubmit="return validateForm()">
		      <c:forEach var="vo" items="${result}" varStatus="loop">
			      <div class="oneLocation">
			      	<div class="info">
			      		<div class="day">
			      			${vo.day }일차
			      			<input name="pks" type="hidden" value="${vo.location_pk }"/>
			      			<input name="plan_pk" type="hidden" value="${plan_pk }"/>
			      		</div>
			      		<div class="firstLine">
			      		<c:choose>
			      			<c:when test="${vo.region eq '1'}">
			      				장소명 : [서울]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '2'}">
			      				장소명 : [인천]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '3'}">
			      				장소명 : [대전]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '4'}">
			      				장소명 : [대구]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '5'}">
			      				장소명 : [광주]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '6'}">
			      				장소명 : [부산]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '7'}">
			      				장소명 : [울산]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '8'}">
			      				장소명 : [세종]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '9'}">
			      				장소명 : [경기도]-[${vo.location_Name }]	  
			      			</c:when>
			      			<c:when test="${vo.region eq '10'}">
			      				장소명 : [강원도]-[${vo.location_Name }]	  
			      			</c:when>	      				      		    		
			      		</c:choose>
				      		<div class="scoring">
				      			별점
					      			<select name="scores">
					      				<option value="1">★☆☆☆☆</option>
					      				<option value="2">★★☆☆☆</option>
					      				<option value="3">★★★☆☆</option>
					      				<option value="4">★★★★☆</option>
					      				<option value="5">★★★★★</option>
					      			</select>
				      		</div>
				      	</div>
				      	<div class="secondLine">
				      	    한줄평
				      	    <input name="oneLineReviews" type="text" onchange="setInputValue(this)"/>
				      	</div>
			      	</div>
			      </div>      
		      </c:forEach>
		      </form>
		    </div>
		   </div>
		   <div class="bottomWrapper">
			      <button class="btn blueBwhiteL" type="button" onclick="submitFormWithConfirmation()">저장</button>
			      <button class="btn lightskyBblackL" type="button" onclick="goBack()">나가기</button>
			</div>
		  </div>		
	</c:otherwise>
	</c:choose>
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>
</html>