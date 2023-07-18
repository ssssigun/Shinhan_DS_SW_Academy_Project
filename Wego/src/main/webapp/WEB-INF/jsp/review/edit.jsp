<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="google" content="notranslate" />
    <link rel="icon" href="/main/image/ShinhanLogo.png"/>
		<link rel="stylesheet" href="/main/css/common.css">
		<link rel="stylesheet" href="/main/css/footer.css">
		<link rel="stylesheet" href="/main/css/header.css">
    <link rel="stylesheet" href="/main/css/myRecord/review_update.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <title>common</title>
    <script>
	    function goBack() {
			  var yesORnot = confirm("목록으로 돌아가시겠습니까?\n"
					  +"※주의)저장하지 않고 이동 시, 작성한 내용이 사라집니다.");
			  if(yesORnot){
				  history.go(-1); // A로 되돌아감
			  }
	    }
	    
	    function confirmation(){
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
	    
	    function validateForm() {
		    var inputs = document.querySelectorAll('input[type="text"]');
		    for (var i = 0; i < inputs.length; i++) {
		      if (inputs[i].value === "") {
		        return false;
		      }
		    }
		    return true;
		  }
	    
	    const fileInput = document.getElementById('fileInput');
	    const uploadButton = document.getElementById('')
	
     	function goSave() {
    		//유효성처리했다치고
    		$("#frm").submit();
    		
    	}
 
    </script>
  </head>
  <body>
  <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
  <c:choose>
  	<c:when test="${flag== 'jv' }">
	  	<div class="contents">
	      <div class="ContentsContainer">
	        <h3 class="title">작성한 전체 후기</h3>
	      </div>
	      <div class="writeWrapper">
	        <div class="writeTable">
	          <div class="titleWrapper">
	            <h3 class="title">제목</h3>
	            <input disabled value="${result.title}" name="title" type="text" class="preFrame"/>
	          </div>
	          	<h3 class="title">내용</h3>
	          	<input name="plan_pk" type="hidden" value="${plan_pk }"/>
	          	<textarea disabled name="contents" class="contentsWrapper">${result.content}</textarea>
	          <div class="attachmentWrapper">
	            <div class="Frame63">
	              <h3 class="imgattach">사진 첨부</h3>
	              <h3 class="imgattachExplain">
	                무작위의 사진이 목록에서 대표사진으로 보여집니다.
	              </h3>
	            </div>
	             <div class="photo">
	              <div class="photoWrapper"> 
	              <div class="imageContainer" style="display:flex;">
	              	<c:forEach var="picno" items="${ photos.list}">
	              		<c:set var="filePath" value="${filePath }"/>
	              		<c:set var="fileName" value="${picno.filename_save }"/>
	              		<c:set var="imgPath" value="${filePath}/${fileName}" />
	              		<c:url value="${imgPath}" var="imgUrl" />
	              		<c:import url="${imgUrl}" var="imgContent" />
	              		
	              		<c:choose>
						    <c:when test="${not empty imgContent}">
						      <img src="${imgUrl}" alt="Image" /> <!-- 이미지 파일이 존재하는 경우 이미지 출력 -->
						    </c:when>
						    <c:otherwise>
						      <p>Image not found.</p> <!-- 이미지 파일이 존재하지 않는 경우 메시지 출력 -->
						    </c:otherwise>
					  	</c:choose>
	              	</c:forEach>
	              </div>
		              <div class="Frame62">
			              <input type="file" id="fileInput" name="file" style="display:none;" multiple/>
			              	<img class="addingPhoto" src="/main/image/review/BsFillPlusCircleFill.png"/>             	
		              </div>
	              </div>
	          </div>
	        </div>   
	      </div>
	    </div>
	    <div class="bottomWrapper">
	        <div class="btn lightskyBblackL" onclick="goBack()">나가기</div>
	        <div class="btn blueBwhiteL">후기 수정</div>
	      </div>
	    </div>
  	</c:when>
  	
  	
  	
  	<c:otherwise>
  		<div class="contents">
	      <div class="ContentsContainer">
	        <h3 class="title">전체 후기 수정</h3>
	      </div>
	      <form method="post" name="frm" id="frm" action="update.do" enctype="multipart/form-data">
	      <div class="writeWrapper">
	        <div class="writeTable">
	          <div class="titleWrapper">
	            <h3 class="title">제목</h3>
	            <input name="title" type="text" class="preFrame" value="${data.title }"/>
	          </div>
	          	<h3 class="title">내용</h3>
	          	<textarea name="contents" class="contentsWrapper">${data.content }</textarea>
	          <div class="attachmentWrapper">
	            <div class="Frame63">
	              <h3 class="imgattach">사진 첨부</h3>
	              <h3 class="imgattachExplain">
	                 무작위의 사진이 목록에서 대표사진으로 보여집니다.
	              </h3>
	            </div>
	             <div class="photo">
	              <div class="photoWrapper"> 
	              <div class="imageContainer" style="display:flex;"></div>
	              <div class="Frame62">
	              <input type="file" id="fileInput" name="file" style="display:none;" multiple/>
	              <label for="fileInput">
	              	<img class="addingPhoto" src="/main/image/review/BsFillPlusCircleFill.png"/>
	              </label>              	
	              </div>
	              </div>
	          </div>
	        </div>   
	      </div>
	    </div>
	    </form>
	    <div class="bottomWrapper">
	        <div class="btn lightskyBblackL" onclick="goBack();">나가기</div>
	        <div class="btn blueBwhiteL" onclick="goSave();">저장</div>
	      </div>
	    </div>
  	</c:otherwise>
  </c:choose>
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
  </body>
<script>
	

  document.getElementById("fileInput").addEventListener("change", function() {
    document.querySelector(".imageContainer").innerHTML = "";
    const fileInput = document.getElementById("fileInput");
    const files = fileInput.files;
    for (let i = 0; i < files.length; i++) {
      let file = files[i];
      let reader = new FileReader();
      console.log(files[i]);
      

      reader.onload = function(e) {
        let img = document.createElement("img");
        img.src = e.target.result;
        img.width = 215;
        img.height = 169;

        let div = document.createElement("div");
        div.classList.add("imageWrapper");
        div.appendChild(img);

        document.querySelector(".imageContainer").appendChild(div);
       
      };
      reader.readAsDataURL(file);
    }
   	if (files.length > 0){
    	$(".photoWrapper").addClass("photoExist");
   	} else {
   		$(".photoWrapper").removeClass("photoExist");
   	}
  });
  
  
</script>
</html>