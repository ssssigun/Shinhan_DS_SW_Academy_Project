<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <meta name="google" content="notranslate" />
    <link rel="icon" href="../image/ShinhanLogo.png" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/header.css" />
    <link rel="stylesheet" href="../css/footer.css" />
    <link rel="stylesheet" href="../css/review/review_update.css" />
    <title>common</title>
    <script>
    	function goSave() {
    		//유효성처리했다치고
    		$("#frm").submit();
    		
    	}
    </script>
    <script>
    	
    </script>
  </head>
  <body>
      <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
  
   
  
  <c:choose>
   <c:when test="${flag== 'jv' }">
    <div class="contents">
      <div class="ContentsContainer">
        <h3 class="title">전체 후기 수정</h3>
      </div>
      <form method="post" name="frm" id="frm" action="update.do" enctype="multipart/form-data" >
      <input type="hidden" name="review_pk" value="${data.review_pk }">
      <div class="writeWrapper">
        <div class="writeTable">
          <div class="titleWrapper">
            <h3 class="title">제목</h3>
            
            
              
              <input type="text" name="title" id="title" class="bigbitLetter tit" value="${data.title }"/>
            
          </div>
          <hr />
          <div class="contentsWrapper">
            <h3 class="title">내용</h3>
            <div class="FrameCon">
              
              <textarea cols="130" rows="100" name="content" id="content" class="FrameCon letter text">${data.content }</textarea>
            </div>
          </div>
          <div class="attachmentWrapper">
            <div class="Frame63">
            <div class="attachcount">
              <h3 class="imgattach">사진 첨부</h3>
              </div>
              <h3 class="imgattachExplain">
                가장 앞의 사진이 목록에서 대표사진으로 보여집니다.
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
        <div class="btn lightskyBblackL"><a href="/main/myRecord/plan/index.do">나가기</a></div>
        <div class="btn blueBwhiteL"><a href="javascript:goSave();">저장</a></div>
    </div>
   </form>
  </div>
 </c:when>
 
 <c:otherwise>
	  <div class="contents">
      <div class="ContentsContainer">
        <h3 class="title">전체 후기 수정</h3>
      </div>
      <form method="post" name="frm" id="frm" action="update.do" enctype="multipart/form-data" >
      <input type="hidden" name="review_pk" value="${data.review_pk }">
      <div class="writeWrapper">
        <div class="writeTable">
          <div class="titleWrapper">
            <h3 class="title">제목</h3>
            
            
              
              <input type="text" name="title" id="title" class="bigbitLetter tit" value="${data.title }"/>
            
          </div>
          <hr />
          <div class="contentsWrapper">
            <h3 class="title">내용</h3>
            <div class="FrameCon">
              
              <textarea cols="130" rows="100" name="content" id="content" class="FrameCon letter text">${data.content }</textarea>
            </div>
          </div>
          <div class="attachmentWrapper">
            <div class="Frame63">
            <div class="attachcount">
              <h3 class="imgattach">사진 첨부</h3>
              </div>
              <h3 class="imgattachExplain">
                가장 앞의 사진이 목록에서 대표사진으로 보여집니다.
              </h3>
            </div>

          
          
          
            <div class="photo">
	              <div class="photoWrapper"> 
	              <div class="imageContainer" style="display:flex;"></div>
	              <div class="Frame62">
	              <input type="file" id="fileInput" name="filename"  multiple/>
	              <label for="fileInput">
	              	<img class="addingPhoto" src="/main/image/review/BsFillPlusCircleFill.png"/>
	              </label>              	
	              </div>
	              </div>
	          </div>
        </div>
      </div>  
     </div>
    <div class="bottomWrapper">
        <div class="btn lightskyBblackL"><a href="/main/myRecord/plan/index.do">나가기</a></div>
        <div class="btn blueBwhiteL"><a href="javascript:goSave();">저장</a></div>
    </div>
   </form>
  </div>
 </c:otherwise>
</c:choose>

  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
  
  </body>
  
  
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
	    
	    //const fileInput = document.getElementById('fileInput');
	    //const uploadButton = document.getElementById('')
	
 
    </script>  
<script>
	

  document.getElementById("fileInput").addEventListener("change", function() {
    document.querySelector(".imageContainer").innerHTML = "";
    const fileInput = document.getElementById("fileInput");
    const files = fileInput.files;
    console.log("files.length"+files.length);
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
  });
  
  
</script>
</html>
