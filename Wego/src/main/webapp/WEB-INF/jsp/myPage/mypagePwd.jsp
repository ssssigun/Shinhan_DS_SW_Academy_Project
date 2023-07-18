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
  <link rel="stylesheet" href="/main/css/myPage/mypagePwd.css">
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
  <script type="text/javascript">
  function check(){
	if(""===$("#pwd").val()){
		$("#alarm").css('color','red');
		$("#alarm").text('비밀번호를 입력해주세요.');
		$("#alarm").css('display','block')
		$("#pwd").focus();
	}else if ($("#pwd").val()=="1234"){
		location.href="/main/myPage/myInfo.do"
	}else{
		$("#alarm").css('color','red');
		$("#alarm").text('비밀번호가 맞지 않습니다.');
		$("#alarm").css('display','block')
		$("#pwd").focus();
	}
  }
	function before() {
	    var token = localStorage.getItem("accessToken");
	    $.ajax({
	        type: "GET",
	        url: "/api/me",
	        beforeSend: function (xhr) {
	            xhr.setRequestHeader("Authorization","bearer " + token);
	        },
	        data: {
	        	
	        },
	        success: function (res) {
	            console.log(res);
	        }
	    });
	    
	}
  </script>
  <title>MyPage</title>
</head>
<body>
<jsp:include page='/WEB-INF/jsp/include/header.jsp'/>
  <div class="contents">
    <div class="contentTop">
      <p class="title">마이페이지</p>
    </div>
    <div class="contentBottom">
      <div class="info">
        <div class="infoText">
          <p class="letter">마이페이지에 접속하려면</p>
          <p class="letter">비밀번호를 입력하셔야 합니다.</p>
        </div>
        <div class="inputWrapper inputBox">
          <input class="input" type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요.">
        </div>
        <p class="smallLetter" id="alarm">알림 텍스트</p>
        <div class="btnArea">
          <input class="inputBtn btn blueBwhiteL" type="submit" name="btn" id="btn" value="입력" onclick="check()">
        </div>
      </div>
    </div>
  </div>
<jsp:include page='/WEB-INF/jsp/include/footer.jsp'/>
</body>
</html>
