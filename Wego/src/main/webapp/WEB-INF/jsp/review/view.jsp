<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="google" content="notranslate" />
    <link rel="icon" href="../image/ShinhanLogo.png" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/header.css" />
    <link rel="stylesheet" href="../css/footer.css" />
    <link rel="stylesheet" href="../css/review/review_comment_write.css"/>
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <title>common</title>
     <script>
    	function goSave() {
    		//유효성처리했다치고
    		$("#frm").submit();
    		
    	}
    	
    	//console.log(commentText);
    	

    	//추천수
    	var hasUserRecommended = false; // 사용자의 추천 여부를 추적하는 변수

    	function recommendOnClick() {
 	        $.ajax({
 	            url: 'reviewRecommendPlus.do',  // 서버 URL
 	            type: 'POST',  // 요청 방식 (GET, POST 등)
 	            data: { review_pk: '${review_pk}', user_pk: '${user_pk}' },  // 리뷰의 고유 식별자를 전달
 	            success: function(response) {
 	                // 성공적으로 응답 받았을 때 실행할 코드
 	                updateRecommendCount(response);  // 추천 수 업데이트 함수 호출
 	                hasUserRecommended = true; // 사용자가 추천했음을 표시
 	            },
 	            error: function(xhr, status, error) {
 	                // 요청이 실패했을 때 실행할 코드
 	                console.error(error);
 	            },
 	            complete: function() {
 	                isRecommendClicked = false; // 요청 완료 후 버튼 클릭 상태 초기화
 	            }
 	        });
    	}

    	function updateRecommendCount(count) {
    	    // 추천 수를 업데이트하는 코드 작성
    	    $('.bigLetter').text(count + Number($('.bigLetter').text()));
    	}

    	
    	//조회수
    	
    	$(document).ready(function() {
  // 리뷰 조회 시 호출되는 함수
  function addReviewWatch(reviewId) {
    $.ajax({
      url: 'reviewWatchPlus.do', // 리뷰 조회수 추가 API 엔드포인트
      type: 'POST',
      data: {
        review_pk: reviewId // 리뷰 ID를 전달
      },
      success: function(response) {
        // 응답 처리
        console.log('Review watch added successfully.');
        // 추가적인 동작을 수행하거나 메시지를 표시하는 등의 로직을 작성할 수 있습니다.
      },
      error: function(xhr, status, error) {
        // 에러 처리
        console.error('Error adding review watch:', error);
        // 오류 메시지를 표시하거나 기타 오류 처리 로직을 작성할 수 있습니다.
      }
    });
  }

  // 리뷰 링크 클릭 시 이벤트 처리
  $('.review-link').click(function(e) {
    e.preventDefault(); // 기본 동작 방지
    var reviewId = $(this).data('review-id'); // 클릭된 리뷰의 ID 가져오기
    addReviewWatch(reviewId); // 리뷰 조회수 추가 함수 호출
    window.location.href = $(this).attr('href'); // 링크 이동
  });
});

    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	//신고//
    	function reportReview() {
	    var user_pk = 1; // 사용자의 고유 식별자
	    var review_pk = 123; // 리뷰의 고유 식별자
	    var plan_pk = 456; // 해당 리뷰에 대한 계획의 고유 식별자
	
	    $.ajax({
	        url: 'insertReviewSue.do',
	        type: 'POST',
	        data: {
	            user_pk: user_pk,
	            review_pk: review_pk,
	            plan_pk: plan_pk
	        },
	        success: function(response) {
	            if (response) {
	                alert('리뷰 신고가 접수되었습니다.');
	            } else {
	                alert('리뷰 신고에 실패했습니다.');
	            }
	        },
	        error: function(xhr, status, error) {
	            console.error(error);
	        }
	    });
	}

    	
    	//신고//
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	//댓글수정창
    	
    	function editComment(button) {
    var commentContainer = button.closest('.commentContainer');
    var commentText = commentContainer.querySelector('.commentText');
    var commentContent = commentText.textContent;

    var textarea = document.createElement('textarea');
    textarea.value = commentContent;

    var saveButton = document.createElement('button');
    saveButton.textContent = '저장';
    saveButton.addEventListener('click', function() {
        var newCommentContent = textarea.value;

        // 서버로 수정된 댓글 내용을 전송하는 AJAX 요청
        // ...

        commentText.textContent = newCommentContent;
        commentText.style.display = 'block';
        textarea.parentNode.removeChild(textarea);
        saveButton.parentNode.removeChild(saveButton);
        cancelButton.parentNode.removeChild(cancelButton);
    });

    var cancelButton = document.createElement('button');
    cancelButton.textContent = '취소';
    cancelButton.addEventListener('click', function() {
        commentText.style.display = 'block';
        textarea.parentNode.removeChild(textarea);
        saveButton.parentNode.removeChild(saveButton);
        cancelButton.parentNode.removeChild(cancelButton);
    });

    commentText.style.display = 'none';
    commentContainer.appendChild(textarea);
    commentContainer.appendChild(saveButton);
    commentContainer.appendChild(cancelButton);
}

    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	//신고
    	function sueOnClick() {
		  // 신고 처리를 위한 AJAX 요청
		  $.ajax({
		    url: 'insertReviewSue.do', // 서버 URL
		    type: 'POST', // 요청 방식 (GET, POST 등)
		    data: { review_pk: ${review_pk}, user_pk: ${user_pk} }, // 신고할 리뷰의 ID 또는 필요한 정보
		    success: function(response) {
		      // 성공적으로 신고를 처리한 후 실행할 코드
		      if(response){
		    	  alert('신고가 접수되었습니다.');
		      }else {
		    	  alert('이미 신고한 게시물입니다.')
		      }
		      
		      
		    },
		    
		    error: function(xhr, status, error) {
		      // 요청이 실패했을 때 실행할 코드
		      console.error(error);
		    }
		  });
		}


    	//댓글 수정
    	function commentEdit(review_comment_pk){
    		console.log(review_comment_pk);
    		$( '#' + review_comment_pk )
            .replaceWith(''
            	  +'<form method="post" name="frm" id="frm" action="commentUpdate.do" enctype="multipart/form-data" >'
          		  +'<div class="editform">'
          		  +'  <textarea rows="3" cols="100" name="comment_content" id="content" class="FrameCon letter text">'
          		  +     $('#' + review_comment_pk).text()
          		  +'  </textarea>'
          		  + '    <input type="hidden" name="review_comment_pk" value="' + "${vo.review_comment_pk}" + '">'
          		  +'</div>' 
          		  +'<button class="editEnd smallBtn blueBwhiteL" type="submit">'
          		  +'수정완료'
          		  +'</button>'
          		  +'</form>'
            
            
            );
    		
    		
    	}
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	/*
    	//댓글 수정창 버튼 클릭 후 보임
    	$( document ).ready( function() {
        $( '.editButton' ).click( function() {
          $( '.commentcontents' )
          .replaceWith(''
        		  +'<div class="editform">'
        		  +'  <textarea rows="3" cols="100" name="comment_content" id="content" class="FrameCon letter text">'
        		  +$('.commentcontents').text();
        		  +'  </textarea>'
        		  +'</div>' );
        });
    	*/
    	
    	
    	$(document).ready(function() {
    		  $('.editButton').click(function() {
    		    var commentContainer = $(this).closest('.commentContainer');
    		    var commentText = commentContainer.find('.commentText');
    		    var commentContent = commentText.text();

    		    var textarea = $('<textarea rows="3" cols="100" name="comment_content" id="content" class="FrameCon letter text">' + commentContent + '</textarea>');
    		    var saveButton = $('<button class="saveButton">저장</button>');
    		    var cancelButton = $('<button class="cancelButton">취소</button>');

    		    commentText.hide();
    		    commentContainer.append(textarea, saveButton, cancelButton);

    		    saveButton.click(function() {
    		      var newCommentContent = textarea.val();

    		      // 서버로 수정된 댓글 내용을 전송하는 AJAX 요청
    		      // ...

    		      commentText.text(newCommentContent).show();
    		      textarea.remove();
    		      saveButton.remove();
    		      cancelButton.remove();
    		    });

    		    cancelButton.click(function() {
    		      commentText.show();
    		      textarea.remove();
    		      saveButton.remove();
    		      cancelButton.remove();
    		    });
    		  });
    		});


    	console.log(${vo.user_pk});

    </script>
  </head>
  <body>
      <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
    <div class="contents">
      <div class="ContentsContainer">
        <div class="writeWrapper">
          <div class="writeTable">
            <div class="titleWrapper">
              <h3 class="title">${data.title }</h3>
              <div class="viewCountWrapper">
                <img src="../image/review/BsEye.png" />
                <dt class="letter">${watch.review_watch_count }</dt>
              </div>
            </div>
            <hr />
            <div class="contentsWrapper">
              <div class="contentsTitleWrapper">
                <h3 class="smallsmallLetter">${data.regdate }</h3>
              </div>
              <div class="review_contents">
                <dd class="letter">${data.content }</dd>
                <div class="photoWrapper" style="background-color: transparent; position:relative;">
	              	 <img src="${pageContext.request.contextPath}/image/client/${data.imagename}" onerror="this.src='/main/image/logoMain.png'" style="width:342.844px; height:212px; position: absolute; top: 0; left: 0;"/>  
                </div>
                <div class="image">
                  ${data.filename_org }
                  <!-- <img src="../image/review/attachimg.png" />  -->
                </div>
              </div>
            </div>
          </div>
          <div class="contentsBottomWrapper">
            <div class="thumbsWrapper">
              <div class="thumbs">
              <button class="recommendplusbutton" onClick="recommendOnClick()"><img src="../image/review/thumbsup.png" /></button>
              <dd class="bigLetter">${recommend.review_recommend_count }</dd>
                
              
              </div>
            </div>
            
            <button class="reviewSueButton" onClick="sueOnClick()"><img src="../image/review/report.png" />
          </div>
        </div>
        
        <div class="com">
         <div class="c">
        <c:forEach var="comment" items="${comments}">
          <div class="commentWrapper">
            <div class="comment">
              <div class="nicknameWrapper">
                <h3 class="letter">${comment.nickname}</h3>
                
               
                <div class="menuWrapper">
				  <a href="#"><img src="../image/review/menuWrapper.png" /></a>
				  
				  <div class="buttonContainer">
				  	
				  	
				    <button class="editButton" onclick="commentEdit('comment${comment.review_comment_pk}')">수정</button>
				    
				    
				    <form method="get" name="frm" id="frm" action="commentDelete.do" enctype="multipart/form-data" >
					    <input type="hidden" name="review_comment_pk" value="${comment.review_comment_pk}">
					    <input type="hidden" name="user_pk" value="3"> <!-- user_pk 값을 여기에 설정 -->
         	 			<input type="hidden" name="review_pk" value="${review_pk }"> <!-- user_pk 값을 여기에 설정 -->
					    <button class="deleteButton" type="submit">삭제</button>
				    </form>
				  </div>
				</div>
			
				

              </div>
              <div class="contentsWrapper2">
                <div class="commentcontents" id="comment${comment.review_comment_pk}">${comment.comment_content}</div>
              </div>
              <h3 class="commentdate">${comment.regdate_comment}</h3>
            </div>
          </div>
          
     
          
          
          
          
          
          
          </c:forEach>
          </div>
         <form method="post" name="frm" id="frm" action="insertReviewComment.do" enctype="multipart/form-data" >
         	 <input type="hidden" name="user_pk" value="3"> <!-- user_pk 값을 여기에 설정 -->
         	 <input type="hidden" name="review_pk" value="${review_pk }"> <!-- user_pk 값을 여기에 설정 -->
	          <div class = "commentWrapper">
		          <div class="comment">
			          <div class="nicknameWrapper">
			          	<h3 class="letter">${vo.nickname}</h3>
			          	<div class="contentsWrapper2">
				          	<textarea rows="3" cols="55" name="comment_content" id="content" class="FrameCon letter text" maxlength="400">${insertReviewComment.content }</textarea>
				          	<button class="commentButton smallBtn blueBwhiteL" type="submit">등록</button>
				       </div>
			          </div>
			      </div>    
	          </div>
         </form>
        </div>
        

        <div class="bottomWrapper">
          <div class="btn blueBwhiteL"><a href="/main/review/index.do">목록</a></div>
          </div>
          <!-- <button type="button" onclick="">목록</button> -->
        </div>
      </div>
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
	    
	    const fileInput = document.getElementById('fileInput');
	    const uploadButton = document.getElementById('')
	
 
    </script>  
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
  });
  
  
</script>
</html>
