<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

  <title>common</title>
</head>
<body>
  <div class="header">
    <div class="headerTop">
      <div class="topText">
        <p><a href="">로그아웃</a></p>
        <p><a href="">마이 페이지</a></p>
      </div>
    </div>
    <div class="headerBottom">
      <div class="picBottom">
        <a href=""><img src="/main/image/logoMain.png" alt=""></a>
        <img class="admin" src="/main/image/logo_admin.png" alt="">
      </div>
      <ul>
        <li class="menu a"><p><a href="">여행 계획</a></p></li>
        <li class="menu"><p><a href="">여행 후기</a></p></li>
        <li class="menu"><p><a href="">나의 기록</a></p></li>
      </ul>

    </div>
  </div>
  
  <script>
  	
  </script>
  
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
	    		<button type="button" class="plan btn blueBwhiteL" onClick="location.href='willdo.do'">계획</button>
	    		<button class="review btn blueBwhiteL">후기</button>
	    		<button class="tempSave btn blueBwhiteL">임시저장</button>
    		</div>
    	
    	
    	<div class="postsPerLine">
            <div class="postWrapper">
              <div class="photoWrapper">
	              <span class="btn yellowBblackL willdo">예정계획</span>
	    		  <span class="btn greenBblackL alldone">종료계획</span>
              </div>
              <div class="postInfoWrapper">
                <div class="titleWrapper">
                 	${list[0].title }
                </div>
                <div class="subWrapper">${list[0].number_of_people }인 | ${list[0].budget }원</div>
                <div class="subsubWrapper">${list[0].start_date } ~ ${(list[0].end_date) }</div>
                <div class="buttonsWrapper">
                	<button class="smallBtn redBwhiteL">삭제하기</button>
                	<button class="smallBtn blueBwhiteL">수정하기</button>
                	<button class="smallBtn blueBwhiteL">후기 쓰기</button>
                </div>
              </div>
            </div>
        </div>
            
            
            <div class="myRecordPlanPaging">
		    	<a href="" class="jiwon-left">&lt</a>
				<a href="" class="jiwon-numbers">1 2 3 4 5</a>
				<a href="" class="jiwon-right">&gt</a>
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