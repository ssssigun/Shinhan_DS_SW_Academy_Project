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
    <link rel="icon" href="../image/ShinhanLogo.png" />
    <link rel="stylesheet" href="../css/common.css" />
    <link rel="stylesheet" href="../css/header.css" />
    <link rel="stylesheet" href="../css/footer.css" />
    <link rel="stylesheet" href="../css/review/review.css" />

    <script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
    <script>
 // 페이지네이션
    $('.pageWrapper').empty();
    var paging = $('<ul>').addClass('paging');
    if (data.prev) {
  	  var pageItem = $('<li>').html('<div class="prevPage" id="'+(Number(data.startPage) - 1)+'"><</div>');
      paging.append(pageItem);
      var pageItem = $('<li>').html('<div class="blank">&nbsp;</div>');
        paging.append(pageItem);
    }
    for (var i = Number(data.startPage); i <= Number(data.endPage); i++) {
      var pageItem = $('<li>').html('<div class="movePage">' + i + '</div>');
      if (page == i) {
        pageItem.addClass('selectLetter');
      }
      paging.append(pageItem);
    }
    if (data.next) {
  	var pageItem = $('<li>').html('<div class="blank">&nbsp;</div>');
        paging.append(pageItem);
      var pageItem = $('<li>').html('<div class="nextPage" id="'+(Number(data.endPage) + 1)+'">></div>');
      paging.append(pageItem);
    }

    $('.pageWrapper').append(paging);
  },
  error: function() {
    alert('데이터를 가져오는 데 실패했습니다.');
  }
});
}
    </script>
    

    <title>common</title>
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
        <li class="menu"><p><a href="">여행 후기</a></p></li>
        <li class="menu"><p><a href="">나의 기록</a></p></li>
      </ul>

    </div>
  </div>
    <div class="contents">
      <div class="ContentsContainer">
        <div class="title">후기 게시판</div>
        
        <div class="postsWrapper">
          <div class="postWrapper">
            <div class="photoWrapper">
              
            </div>
            <div class="postInfoWrapper">
              <div class="titleWrapper">
                제주도 너무 좋아용
                <div class="iconsWrapper">
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsHandThumbsUpFill.png" />
                    10
                  </div>
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsEye.png" />
                    10
                  </div>
                </div>
              </div>
              <div class="subWrapper">성진박</div>
              <div class="subsubWrapper">2023-08-08</div>
              <div class="buttonsWrapper">
                <button class="smallBtn blueBwhiteL">후기보기</button>
              </div>
            </div>
          </div>
          <div class="postWrapper">
            <div class="photoWrapper">

            </div>
            <div class="postInfoWrapper">
              <div class="titleWrapper">
                제주도 너무 좋아용
                <div class="iconsWrapper">
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsHandThumbsUpFill.png" />
                    10
                  </div>
                  <div class="iconWrapper">
                     <img class="icon" src="../image/review/BsEye.png" />
                    10
                  </div>
                </div>
              </div>
              <div class="subWrapper">성진박</div>
              <div class="subsubWrapper">2023-08-08</div>
              <div class="buttonsWrapper">
                <button class="smallBtn blueBwhiteL">후기보기</button>
              </div>
            </div>
          </div>
          <div class="postWrapper">
            <div class="photoWrapper">
              
            </div>
            <div class="postInfoWrapper">
              <div class="titleWrapper">
                제주도 너무 좋아용
                <div class="iconsWrapper">
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsHandThumbsUpFill.png" />
                    10
                  </div>
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsEye.png" />
                    10
                  </div>
                </div>
              </div>
              <div class="subWrapper">성진박</div>
              <div class="subsubWrapper">2023-08-08</div>
              <div class="buttonsWrapper">
                <button class="smallBtn blueBwhiteL">후기보기</button>
              </div>
            </div>
          </div>
          <div class="postWrapper">
            <div class="photoWrapper">
              
            </div>
            <div class="postInfoWrapper">
              <div class="titleWrapper">
                제주도 너무 좋아용
                <div class="iconsWrapper">
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsHandThumbsUpFill.png" />
                    10
                  </div>
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsEye.png" />
                    10
                  </div>
                </div>
              </div>
              <div class="subWrapper">성진박</div>
              <div class="subsubWrapper">2023-08-08</div>
              <div class="buttonsWrapper">
                <button class="smallBtn blueBwhiteL">후기보기</button>
              </div>
            </div>
          </div>
          <div class="postWrapper">
            <div class="photoWrapper">
              
            </div>
            <div class="postInfoWrapper">
              <div class="titleWrapper">
                제주도 너무 좋아용
                <div class="iconsWrapper">
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsHandThumbsUpFill.png" />
                    10
                  </div>
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsEye.png" />
                    10
                  </div>
                </div>
              </div>
              <div class="subWrapper">성진박</div>
              <div class="subsubWrapper">2023-08-08</div>
              <div class="buttonsWrapper">
                <button class="smallBtn blueBwhiteL">후기보기</button>
              </div>
            </div>
          </div>
          <div class="postWrapper">
            <div class="photoWrapper">
              
            </div>
            <div class="postInfoWrapper">
              <div class="titleWrapper">
                제주도 너무 좋아용
                <div class="iconsWrapper">
                  <div class="iconWrapper">
                     <img class="icon" src="../image/review/BsHandThumbsUpFill.png" />
                    10
                  </div>
                  <div class="iconWrapper">
                    <img class="icon" src="../image/review/BsEye.png" />
                    10
                  </div>
                </div>
              </div>
              <div class="subWrapper">성진박</div>
              <div class="subsubWrapper">2023-08-08</div>
              <div class="buttonsWrapper">
                <button class="smallBtn blueBwhiteL">후기보기</button>
              </div>
            </div>
            
          </div>
          </div>
       <div class="pageWrapper">
                        
                    </div>
        <div class="pageControllerWrapper">
          <div class="pageController">
            <div class="MdNavigateBefore">
              <img src="../image/review/MdNavigateBefore.png" />
            </div>
            <div class="number">
              <a href="" class="smallLetter selectLetter">1</a>
              <a href="" class="smallLetter">2</a>
              <a href="" class="smallLetter">3</a>
              <a href="" class="smallLetter">4</a>
              <a href="" class="smallLetter">5</a>
              <a href="" class="smallLetter">6</a>
              <a href="" class="smallLetter">7</a>
              <a href="" class="smallLetter">8</a>
              <a href="" class="smallLetter">9</a>
              <a href="" class="smallLetter">10</a>
            </div>

            <div class="MdNavigateNext">
              <img src="../image/review/MdNavigateNext.png" />
            </div>
          </div>
        </div>
        
        <hr />
        <div class="search">
          <div class="searchWrapper">
            <select class="select">
              <option>전체</option>
              <option>제목</option>
              <option>내용</option>
            </select>
            <input class="input" placeholder="검색어를 입력하세요" />
            <button class="btn yellowBblackL">검색</button>
          </div>
        </div>
      </div>

      <!-- 이 부분에 헤더 푸터 사이에 들어가는 것들 넣어주세요. -->
      <!-- 정렬이 페이지마다 조금씩 달라서 wrapper 역할을 할 div(width: 100%, height: 100% + 원하는 정렬 등) 넣고 그 안에 요소들 넣으면 될 것 같습니다. -->
      <!-- common.css 파일은 수정하지 않고 새로운 css 파일을 추가 후 스타일 작성 -->
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
