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
 	var ch = false;	
 	//닉네임 유효성 검사
  	function check(){
  		if($('#nickName').val()==""){
			$('#alarm').text('닉네임을 입력해주세요!');
			$('#alarm').css('color','red');
			$('#nickName').focus();
			return;
  		}
  		$.ajax({
  			type: 'get',
  			url: 'check.do',
  			data:{
  				nickName: $('#nickName').val()
  			},
  			success:function(res){
  				if(1===res){
	  				$('#alarm').text('이미 존재하는 닉네임입니다!');
	  				$('#alarm').css('color','red');
	  				ch=false;
  				}else if(0===res){
	  				$('#alarm').text('사용 가능한 닉네임입니다!');
	  				$('#alarm').css('color','green');
	  				ch=true;
  				}
				return;
  			}
  		})
  	}
  	//약관 및 닉네임 유효성 검사 후 등록
  	function register(){ 
		if(!$('#agree1').is(":checked") || !$('#agree2').is(":checked")){
 				alert("We go 서비스 이용약관에 대한 내용 확인 후 동의해주세요.");
 				return
		}
  		if(confirm("등록하시겠습니까?")){
  			if(""=== $('#nickName').val()){
  				alert("닉네임을 입력해주세요!");
  				$('#nickName').focus();
			}else if(!ch){
				alert("닉네임을 다시 입력해주세요!")
 				$('#nickName').focus();
  			}
  			else{
  				$.ajax({
  					type:'get',
  					url:'main.do',
  					date:{
  		  				nickName: $('#nickName').val()
  					}
  				});
  			}
  		}
  		return;
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
        <input class="checkB select" type="checkbox" id="agree1" name="agree1" value="agree">
        <label for=agree1><span class="letter">서비스 이용 약관에 동의합니다. (필수)</span></label> 
      </div>
    </div>
    <div class="textBox">
      <p class="title textBoxTitle">개인 정보 이용 동의</p>
      <div class="agreeText">
      
      </div>
      <div class="selectArea">
        <input class="checkB select" type="checkbox" id="agree2" name="agree2" value="agree">
        	<label for='agree2'><span class="letter">개인정보 이용 약관에 동의합니다. (필수)</span></label>
      </div>
    </div>
    <div class="inputWidth">
      <div class="inputWrapper inputBox">
          <span class="letter">닉네임</span>
          <input class="inputNick input" type="text" id="nickName" name ="nickName" placeholder="닉네임을 입력해주세요.">
          <input class="btn blueBwhiteL btnCheck" type="button" value="중복확인" onclick='check()'>
      </div>
      <p class="smallLetter" id="alarm">알림 텍스트</p>
    </div>
      <div class="btnArea">
        <input class="btn yellowBblackL btnRegister" type="button" value="등록" onclick='register()'>
      </div>
  </div>
<jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>
</html>
