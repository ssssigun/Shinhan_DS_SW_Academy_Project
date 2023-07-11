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
    	document.getElementById("fileInput").addEventListener("change",function(){
    		document.querySelector(".imageContainer").innerHTML = "";
    		for(var i = 0; i<this.files.length; i++){
    			var file = this.files[i];
        		var reader = new FileReader();
        		
        		reader.onload = function(e){
        			var img = document.createElement("img");
        			img.src = e.target.result;
        			img.width= 215;
        			img.height = 169;
        			
        			var div = document.createElement("div");
        			div.classList.add("imageWrapper");
        			div.appendChild(img);
        			
        			
        			document.querySelector(".imageContainer").appendChild(div);
        		};
        		
        		reader.readAsDataURL(file);
    		}
    	});
    </script>
  </head>
  <body>
    <div class="header">
    <div class="headerTop">
      <div class="topText">
        <p><a href="">로그아웃</a></p>
        <p><a href="/main/myPage/check.do">마이 페이지</a></p>
      </div>
    </div>
    <div class="headerBottom">
      <div class="picBottom">
        <a href="/main/main.do"><img src="/main/image/logoMain.png" alt=""></a>
        <img class="admin" src="/main/image/logo_admin.png" alt="">
      </div>
      <ul>
        <li class="menu"><p><a href="/main/plan/index.do">여행 계획</a></p></li>
        <li class="menu"><p><a href="/main/review/index.do">여행 후기</a></p></li>
        <li class="menu"><p><a href="/main/myRecord/plan/index.do">나의 기록</a></p></li>
      </ul>

    </div>
  </div>
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
              <h3 class="imgcount">1/10</h3>
              </div>
              <h3 class="imgattachExplain">
                가장 앞의 사진이 목록에서 대표사진으로 보여집니다.
              </h3>
            </div>
             <div class="photo">
              <div class="photoWrapper">              
                <img class="photo" src=${data.filename_org } />
                <button class="rmBtn">
                  <img src="../image/review/delete.png" />
                </button>
              </div>
              <div class="Frame62">
                <img src="../image/review/BsFillPlusCircleFill.png" />
              </div>
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
      
      
      
      <div class="inputArea">
	<label for="filename_org">이미지</label>
	<input type="file" id="filename_org" name="file" />
	<div class="select_img"><img src="" /></div>
	
	<script>
		$("#filename_org").change(function(){
			if(this.files && this.files[0]) {
				var reader = new FileReader;
				reader.onload = function(data) {
					$(".select_img img").attr("src", data.target.result).width(500);								
				}
				reader.readAsDataURL(this.files[0]);
			}
		});
	</script>
	
	<%=request.getRealPath("/") %>
	
</div>

<div class="inputArea">
	<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
</div>



<div class="inputArea">
	<label for="filename_org">이미지</label>
	<input type="file" id="filename_org" name="file" />
	<div class="select_img"><img src="" /></div>
	
	<script>
		$("#filename_org").change(function(){
			if(this.files && this.files[0]) {
				var reader = new FileReader;
				reader.onload = function(data) {
					$(".select_img img").attr("src", data.target.result).width(500);								
				}
				reader.readAsDataURL(this.files[0]);
			}
		});
	</script>
	
	<%=request.getRealPath("/") %>
	
</div>

<div class="inputArea">
	<button type="submit" id="register_Btn" class="btn btn-primary">등록</button>
</div>
      
      
      
      
      
      
      
    </div>
    
    
    
    
    

    
    
    
    
    
    
    
    <div class="bottomWrapper">
        <div class="btn lightskyBblackL"><a href="/main/myRecord/plan/index.do">나가기</a></div>
        <div class="btn blueBwhiteL"><a href="javascript:goSave();">저장</a></div>
    </div>
</form>
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
