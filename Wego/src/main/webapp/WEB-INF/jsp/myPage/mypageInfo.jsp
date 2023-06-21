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
  <link rel="stylesheet" href="/main/css/myPage/mypageInfo.css">
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

  <title>MyInfo</title>
  
  <script>
  function check(){
		if($('#nickName').val()==""){
			$('#alarm').text('닉네임을 입력해주세요!');
			$('#alarm').css('color','red');
			$('#alarm').css('display', 'block');
			$('#nickName').focus();
			return;
  		}
  		$.ajax({
  			type: 'get',
  			url: '/main/check.do',
  			data:{
  				nickName: $('#nickName').val()
  			},
  			success:function(res){
  				if(1===res){
	  				$('#alarm').text('이미 존재하는 닉네임입니다!');
	  				$('#alarm').css('color','red');
	  				$('#alarm').css('display', 'block');
  				}else if(0===res){
	  				$('#alarm').text('사용 가능한 닉네임입니다!');
	  				$('#alarm').css('color','green');
	  				$('#alarm').css('display', 'block');
  				}
				return;
  			}
  		})
  	}
  </script>
</head>
<body>
<jsp:include page='/WEB-INF/jsp/include/header.jsp'/>
  <div class="contents">
    <div class="contentTop">
      <p class="title">마이페이지</p>
    </div>
    <div class="contentBottom">
      <div class="infoUser">
        <p class="bigLetter">정보 수정</p>
        <div class="inputWrapper inputBox">
          <span class="letter">닉네임</span>
          <input class="input" type="text" name="nickName" id="nickName" placeholder="[원래 닉네임]">
          <input class="btnCommon btn blueBwhiteL" type="button" name="btn" id="btn" value="중복확인" onclick="check()">
          <input class="btnCommon btn lightblueBblackL" type="button" name="btn2" id="btn2" value="수정" >
        </div>
        <p class="smallLetter" id="alarm">알림 텍스트</p>
        <p class="bigLetter cardTitle">카드 정보</p>
      </div>
      <div class="infoCard">
        <div class="card">
          <div class="cardImg">
            <img src="/main/image/CardImg.png" alt="">
          </div>
          <div class="cardText">
            <ul>
              <li><p class="bigLetter bold">신한카드 We go</p></li>
              <li><img src="/main/image/PointImg.png" alt=""> <span class="letter">여행 총 경비 2.5% 포인트 적립</span></li>
              <li><img src="/main/image/PointImg.png" alt=""> <span class="letter">무이자 할부 6개월</span></li>
              <li><img src="/main/image/PointImg.png" alt=""> <span class="letter">계획 이행시 0.5% 포인트 추가 적립</span></li>
            </ul>
          </div>
        </div>
      </div>
    </div>
  </div>
<jsp:include page='/WEB-INF/jsp/include/footer.jsp'/>
</body>
</html>
