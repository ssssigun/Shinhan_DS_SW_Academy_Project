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
  <link rel="stylesheet" href="/main/css/first_login.css">
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

  <title>signOn</title>
  <script>
  	function check(){
  		$.ajax({
  			type: 'get',
  			url: 'check.do',
  			data:{
  				nickName: $('#nickName').val()
  			},
  			success:function(res){
  				alert(res);
				return;
  			}
  		})
  	}
  </script>
</head>
<body>
  <div class="header">
    <div class="headerBottom">
      <div class="picBottom">
        <a href=""><img src="/main/image/logoMain.png" alt=""></a>
        <img class="admin" src="/main/image/logo_admin.png" alt="">
      </div>
    </div>
  </div>
  <div class="contents">
    <div class="textBox">
      <p class="title textBoxTitle">서비스 이용 동의</p>
      <div class="agreeText"></div>
      <div class="selectArea">
        <input class="checkB select" type="checkbox" id="agree1" name="agree1">
        <span class="letter">서비스 이용 약관에 동의합니다.</span>
      </div>
    </div>
    <div class="textBox">
      <p class="title textBoxTitle">개인 정보 이용 동의</p>
      <div class="agreeText"></div>
      <div class="selectArea">
        <input class="checkB select" type="checkbox" id="agree2" name="agree2">
        <span class="letter">개인정보 이용 약관에 동의합니다.</span>
      </div>
    </div>
    <div class="inputWidth">
      <div class="inputWrapper inputBox">
          <span class="letter">닉네임</span>
          <input class="inputNick input" type="text" id="nickName" name ="nickName" placeholder="닉네임을 입력해주세요.">
          <input class="btn blueBwhiteL btnCheck" type="button" value="중복확인" onclick='check()'>
      </div>
    </div>
      <div class="btnArea">
        <input class="btn yellowBblackL btnRegister" type="submit" value="등록">
      </div>
  </div>
<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>
</html>
