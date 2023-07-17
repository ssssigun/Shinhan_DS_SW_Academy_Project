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
  <link rel="stylesheet" href="/main/css/admin/adminLogin.css">
  <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>

  <title>AdminLogin</title>
  <script>
  	function login(){
  		if(""===$("#id").val()){
  			$("#alarm").css('color','red');
  			$("#alarm").text('아이디를 입력해주세요.');
  			$("#alarm").css('display','block')
  			$("#id").focus();
  			return;
  		}
  		if(""===$("#pwd").val()){
  			$("#alarm").css('color','red');
  			$("#alarm").text('비밀번호를 입력해주세요.');
  			$("#alarm").css('display','block')
  			$("#pwd").focus();
  			return;
  		}
  		$.ajax({
			  type:"post",
			  url:'http://192.168.0.132:8080/generateToken',
			  data:JSON.stringify({
				  'id': $("#id").val(),
				  'pwd': $("#pwd").val()
			  }),
			  dataType:"json",
			  contentType : "application/json; charset=utf-8",
			  success:function(res){
				  localStorage.setItem("accessToken", res["accessToken"]);
				  localStorage.setItem("refreshToken", res["refreshToken"]);
				  
			  		$.ajax({
						  type:"post",
						  url:'tokenCheck.do',
						  data:{
							  accessToken : res["accessToken"]
						  },
						  success:function(res){
									window.location.href=res+".do";
						  }
						  
			  		})
			  },
			  error : function(request, status, error) { // 결과 에러 콜백함수
		  			$("#alarm").css('color','red');
		  			$("#alarm").text('아이디 또는 비밀번호가 맞지 않습니다!');
		  			$("#alarm").css('display','block')
		  			console.log(error);
			  }
  		})
  		return;
  	}
  </script>
  
</head>
<body>
 <jsp:include page="/WEB-INF/jsp/include/headerLogin.jsp"/>
  <div class="contents">
    <div class="login">
      <p class="title">통합 로그인</p>
      <div class="loginInput">
        <div class="inputBox">
          <div class="idInput inputWrapper">
            <span class="letter inputText">아이디</span>
            <input class="input inputArea" type="text" name="id" id="id" placeholder="아이디를 입력해주세요.">
          </div>
          <div class="pwdInput inputWrapper">
            <span class="letter inputText">비밀번호</span>
            <input class="input inputArea" type="password" name="pwd" id="pwd" placeholder="비밀번호를 입력해주세요.">
          </div>
        </div>
        <input class="btn blueBwhiteL" type="button"  value="로그인" onclick="login()">
      </div>
      <p class="smallLetter" id="alarm">알림 텍스트</p>
    </div>
  </div>
<jsp:include page='/WEB-INF/jsp/include/footer.jsp'/>
</body>
</html>
