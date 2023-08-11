<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  <link rel="stylesheet" href="/main/css/main.css?after">
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

  <title>We go</title>
</head>
<script>
	var planCount = ${planCount};
	var page_num = 0;
	//세션에 있는 pk값 확인
	console.log(${loginSession.user_pk});
	function selectPlan(user_pk, page_num) {
		console.log("page_num:" + page_num);
		$.ajax({
			url: 'selectPlan.do?user_pk=' + user_pk + '&page_num=' + page_num,
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				console.log(data);
				$('.plansContainer').empty();
				$('.plansContainer').append(''
 					+'<div class="planContentAddWrapper" onclick="location.href=\'/main/plan/index.do\';">'
 					+'	<div class="bigLetter bold planContentAdd">나의 여행 일정<br>만들기</div>'
 					+'	<button class="addButton"><img src="/main/image/review/BsFillPlusCircleFill.png"></button>'
 					+'</div>'
        );
				data.forEach(function(plan) {
					$('.plansContainer').append(''
					  +'<div class="planContentWrapper" onclick="location.href=\'/main/plan/plan.do?plan_pk='+plan.plan_pk+'\';">'
					  +'  <div class="photoWrapper">'
					  +'    <div class="planPhoto">'
					  +'      <div class="photoCover">'
					  +'      </div>'
					  +'    </div>'
					  +'  </div>'
					  +'  <div class="planContent">'
					  +'    <div class="letter bold">'+plan.title+'</div>'
					  +'    <div class="letter">'+plan.num_of_people+' 인</div>'
					  +'    <div class="letter">'+plan.start_date+' - '+plan.end_date+'</div>'
					  +'  </div>'
					 	+'</div>'
					)
				});
				
				if (page_num + 6 >= planCount) {
					$('#nextPage').css({"background": "#D9D9D9", "cursor": "default"});
				} else {
					$('#nextPage').removeAttr("style");
				}
				if (0 == page_num) {
					$('#beforePage').css({"background": "#D9D9D9", "cursor": "default"});
				} else {
					$('#beforePage').removeAttr("style");
				}
			}
		});
	}
	
	function beforePage() {
		if (page_num - 6 >= 0) {
			page_num -= 6;
			selectPlan(${user_pk}, page_num);
		}
	}
	function nextPage() {
		if (page_num + 6 < planCount) {
			page_num += 6;
			selectPlan(${user_pk}, page_num);
		}
	}
	
	if (planCount > 0) {
		selectPlan(${user_pk}, page_num);
	}
</script>
<body>
<jsp:include page='/WEB-INF/jsp/include/header.jsp'/>

  <div class="contents">
  	<div class="wrapper">
  		<div class="planWrapper">
  			<h3 class="bigbigLetter bold">나의 여행 계획</h3>
  			<div class="planContainer">
  				<c:if test="${planCount eq 0}">
  					<div class="noneContentsWrapper">
  						<div class="bigLetter bold">여행 계획을 작성해주세요</div>
  						<button class="addButton" onclick="location.href = '/main/plan/index.do'"><img src="/main/image/review/BsFillPlusCircleFill.png"></button>
  					</div>
  				</c:if>
  				<c:if test="${planCount gt 0}">
  					<div class="plansContainer">
  					
  					</div>
	          <div class="pageButtonWrapper">
	            <button class="pageButton" id="beforePage" onclick="beforePage()"><img src="/main/image/MdNavigateBefore.png"/></button>
	            <button class="pageButton" id="nextPage" onclick="nextPage()"><img src="/main/image/MdNavigateNext.png"/></button>
	          </div>
  				</c:if>
  			</div>
  		</div>
  		<div class="reviewWrapper">
  			<h3 class="bigbigLetter bold">최신 후기</h3>
  			<div class="reviewContainer">
  				<c:forEach var="review" items="${reviewList}">
  					<div class="mainPostWrapper" onclick="location.href='/main/review/view.do?review_pk=${review.review_pk}';">
  						<div class="photo">
	          		<img src="${pageContext.request.contextPath}/image/client/${review.imagename}" onerror="this.src='/main/image/logoMain.png'" style="width:100%; height:100%;"/> 
  							<div class="bigbigLetter bold title" style="position: absolute;">
  								${review.title}
  							</div>
  						</div>
  						<div class="contentsWrapper">
  							<div class="letter">${review.nickname} 님</div>
  							<div class="letter">${review.regdate}</div>
  						</div>
  					</div>
  				</c:forEach>
  			</div>
  		</div>
  	</div>
    <!-- 이 부분에 헤더 푸터 사이에 들어가는 것들 넣어주세요. -->
    <!-- 정렬이 페이지마다 조금씩 달라서 wrapper 역할을 할 div(width: 100%, height: 100% + 원하는 정렬 등) 넣고 그 안에 요소들 넣으면 될 것 같습니다. -->
    <!-- common.css 파일은 수정하지 않고 새로운 css 파일을 추가 후 스타일 작성 -->
  </div>
  
<jsp:include page='/WEB-INF/jsp/include/footer.jsp'/>
</body>
</html>
