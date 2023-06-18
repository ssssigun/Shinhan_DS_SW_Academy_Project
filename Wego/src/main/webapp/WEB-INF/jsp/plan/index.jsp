<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=l8m4oe0ivu"></script>
    <script type="text/javascript" src="/main/js/plan/modal.js"></script>
    <title>Document</title>
    <script>
    	// 여행 세부 계획 임시 저장
    	
    
        // 각 지역별 대표 좌표
        var regionPoint = {};
        regionPoint['1'] = new naver.maps.LatLng(37.514575, 127.0495556);
        regionPoint['2'] = new naver.maps.LatLng(37.74692907, 126.4878417);
        regionPoint['3'] = new naver.maps.LatLng(36.3506295, 127.3848616);
        regionPoint['4'] = new naver.maps.LatLng(35.82692778, 128.5350639);
        regionPoint['5'] = new naver.maps.LatLng(37.42949814, 127.2551569);
        regionPoint['6'] = new naver.maps.LatLng(35.20916389, 128.9829083);
        regionPoint['7'] = new naver.maps.LatLng(35.54404265, 129.3301754);
        regionPoint['8'] = new naver.maps.LatLng(36.479522, 127.289448);
        regionPoint['9'] = new naver.maps.LatLng(37.14691389, 127.0796417);
        regionPoint['10'] = new naver.maps.LatLng(37.74913611, 128.8784972);
        
    	var region = 1;
    	var category = '-1';

        $(function() {
        	$('.planCards').on('click', '.spotDetail', function() {
        		var pk = $(this).attr('id');
            	console.log(pk);
            	$.ajax({
            		url: 'spotDetail.do?location_pk=' + pk,
            		method: 'GET',
            		dataType: 'json',
            		success: function(data) {
            			var modalContent = $('#modalContent');
                        modalContent.empty(); // 기존 내용 초기화

                        var listItem = $('<li>').html('<div class="bold">' + data.location_name + '</div>'); // JSON 데이터의 필드에 따라 내용을 조정할 수 있습니다.
                        modalContent.append(listItem);
                        var sTime = new Date(data.start_time).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }).replace(/(AM|PM)/, '').trim();
                        var eTime = new Date(data.end_time).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }).replace(/(AM|PM)/, '').trim();
                        listItem = $('<li>').html('<div class="bold"> 영업시간 : ' + sTime + ' AM ~' + eTime + ' PM</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="bold"> 주소 : ' + data.address + '</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="bold"> 연락처 : ' + data.location_tel + '</div>');
                        modalContent.append(listItem);
                        $(".spotModal").fadeIn();
            		},
            		error: function() {
            			alert('데이터를 가져오는 데 실패했습니다.');
            		}
            	})
           		$(".spotModal").fadeIn();
        	    // 클릭 이벤트 처리 로직을 여기에 작성하세요
        	    
        	    // ...
        	  });
        	
        	// 최초로 plancard를 만들어주는 ajax
        	$.ajax({
        	    url: 'filter.do?region=' + 1 + '&category=' + -1, // JSON 데이터를 가져올 API의 URL을 입력하세요.
        	    method: 'GET',
        	    dataType: 'json',
        	    success: function(data) {
        	      $.each(data, function(index, location) {
        	        var planCard = $('<div>').addClass('planCard');
        	        var planPhoto = $('<div>').addClass('planPhoto');
        	        var plan = $('<div>').addClass('plan');
        	        var boldText = $('<div>').addClass('bold').text(location.location_name);
        	        var categoryText = $('<div>').text(location.category_name);
        	        var spotDetail = $('<div>').addClass('spotDetail cardButtonWrapper').attr('id', location.location_pk);
        	        var locationDetailBtn = $('<button>').addClass('locationDetailBtn').attr('name', 'locationDetailBtn');
        	        var image = $('<img>').attr('src', '/main/image/plan/Vector.png').attr('width', '20');

        	        locationDetailBtn.append(image);
        	        spotDetail.append(locationDetailBtn);
        	        plan.append(boldText, categoryText);
        	        planCard.append(planPhoto, plan, spotDetail);
        	        $('.planCards').append(planCard);
        	      });
        	    },
        	    error: function() {
        	      alert('데이터를 가져오는 데 실패했습니다.');
        	    }
        	  });
        	
            // jquery 달력 불러옴
            $( ".datepicker" ).datepicker();

            // regionSelect 변경시 지도 해당 도시로 이동
            var selectBox = $("#region");
            selectBox.on("change", function(){
                map.setCenter(regionPoint[$("#region option:selected").val()])
                $('.planCards').empty(); // 기존 내용 초기화
            	region = $("#region option:selected").val();
                $.ajax({
            		url: 'filter.do?region=' + region + '&category=' + category,
            		method: 'GET',
            		dataType: 'json',
            		success: function(data) {
            			$.each(data, function(index, location) {
                	        var planCard = $('<div>').addClass('planCard');
                	        var planPhoto = $('<div>').addClass('planPhoto');
                	        var plan = $('<div>').addClass('plan');
                	        var boldText = $('<div>').addClass('bold').text(location.location_name);
                	        var categoryText = $('<div>').text(location.category_name);
                	        var spotDetail = $('<div>').addClass('spotDetail cardButtonWrapper').attr('id', location.location_pk);
                	        var locationDetailBtn = $('<button>').addClass('locationDetailBtn').attr('name', 'locationDetailBtn');
                	        var image = $('<img>').attr('src', '/main/image/plan/Vector.png').attr('width', '20');

                	        locationDetailBtn.append(image);
                	        spotDetail.append(locationDetailBtn);
                	        plan.append(boldText, categoryText);
                	        planCard.append(planPhoto, plan, spotDetail);
                	        $('.planCards').append(planCard);
                	      });
            		},
            		error: function() {
            			alert('데이터를 가져오는 데 실패했습니다.');
            		}
            	})
            })
            
            // 모달 관련
            $(".spotDetail").click(function () {
            	var pk = $(this).attr('id');
            	console.log(pk);
            	$.ajax({
            		url: 'spotDetail.do?location_pk=' + pk,
            		method: 'GET',
            		dataType: 'json',
            		success: function(data) {
            			var modalContent = $('#modalContent');
                        modalContent.empty(); // 기존 내용 초기화

                        var listItem = $('<li>').html('<div class="bold">' + data.location_name + '</div>'); // JSON 데이터의 필드에 따라 내용을 조정할 수 있습니다.
                        modalContent.append(listItem);
                        var sTime = new Date(data.start_time).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }).replace(/(AM|PM)/, '').trim();
                        var eTime = new Date(data.end_time).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }).replace(/(AM|PM)/, '').trim();
                        listItem = $('<li>').html('<div class="bold"> 영업시간 : ' + sTime + ' AM ~' + eTime + ' PM</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="bold"> 주소 : ' + data.address + '</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="bold"> 연락처 : ' + data.location_tel + '</div>');
                        modalContent.append(listItem);
                        $(".spotModal").fadeIn();
            		},
            		error: function() {
            			alert('데이터를 가져오는 데 실패했습니다.');
            		}
            	})
           		$(".spotModal").fadeIn();
            });
            $(".spotModalContent").click(function (e) {
            // e.preventDefault();
            	e.stopPropagation();
            });
            $(".spotModal").click(function (e) {
           		$(".spotModal").fadeOut();
            });
            $(".spotModalOutButton").click(function (e) {
            	$(".spotModal").fadeOut();
            });
            
            // 카테고리 버튼 관련
            $(".categoryBtn").click(function () {
                $('.planCards').empty(); // 기존 내용 초기화
            	categoryInput = $(this).attr('id');
             	if (category === categoryInput) {
             		$(this).removeClass('blueBwhiteL');
             		$(this).addClass('softblueBwhiteL');
             		category = '-1';
             	} else {
             		category = categoryInput;
             		$(".blueBwhiteL").addClass('softblueBwhiteL');
             		$(".blueBwhiteL").removeClass('blueBwhiteL');
             		$(this).addClass('blueBwhiteL');
             		$(this).removeClass('softblueBwhiteL');
             	}
            	$.ajax({
            		url: 'filter.do?region=' + region + '&category=' + category,
            		method: 'GET',
            		dataType: 'json',
            		success: function(data) {
            			$.each(data, function(index, location) {
                	        var planCard = $('<div>').addClass('planCard');
                	        var planPhoto = $('<div>').addClass('planPhoto');
                	        var plan = $('<div>').addClass('plan');
                	        var boldText = $('<div>').addClass('bold').text(location.location_name);
                	        var categoryText = $('<div>').text(location.category_name);
                	        var spotDetail = $('<div>').addClass('spotDetail cardButtonWrapper').attr('id', location.location_pk);
                	        var locationDetailBtn = $('<button>').addClass('locationDetailBtn').attr('name', 'locationDetailBtn');
                	        var image = $('<img>').attr('src', '/main/image/plan/Vector.png').attr('width', '20');

                	        locationDetailBtn.append(image);
                	        spotDetail.append(locationDetailBtn);
                	        plan.append(boldText, categoryText);
                	        planCard.append(planPhoto, plan, spotDetail);
                	        $('.planCards').append(planCard);
                	      });
            		},
            		error: function() {
            			alert('데이터를 가져오는 데 실패했습니다.');
            		}
            	})
            })
        });
    </script>
    <link rel="stylesheet" href="/main/css/reset.css">
    <link rel="stylesheet" href="/main/css/common.css">
    <link rel="stylesheet" href="/main/css/plan/index.css?abcdfe">
</head>
<body>
    <div class="wrap">
      <div class="spotModal">
        <div class="spotModalContent">
          <div class="spotLeftContainer">
          	<div class="spotMainPhoto"></div>
          	<div class="spotDetails">
          	  <ul id="modalContent"></ul>
          	</div>
          	<div class="spotSubPhoto"></div>
          	<div class="spotInputWrapper">
          	  <div class="timeInput">
          	  		<select class="select selectInput" name="startTime" form="timeForm">
          	        <c:forEach var="tmp" begin="0" end="23" step="1" varStatus="st">
                        <option value="${st.count - 1 }">${st.count - 1 }:00</option>
                    </c:forEach>
                    </select>
                    ~
                    <select class="select selectInput" name="endTime" form="timeForm">
                    <c:forEach var="tmp" begin="0" end="23" step="1" varStatus="st">
                        <option value="${st.count - 1 }">${st.count - 1 }:00</option>
                    </c:forEach>
                    </select>
          	  </div>
          	  <div class="inputWrapper budgetInput">
          	  예산: 
          	  <!-- input 태그 삽입시 가운데 정렬이 안돼서 'flex-grow: 1;' 부분만 빼고 budgetTextInput에 복붙함 -->
          	  <input class="budgetTextInput" type="text" name="budget" placeholder="숫자만 입력"> 원
          	  </div>
          	</div>
          </div>
          <div class="spotRightContainer">
          	<div class="commentCardWrapper">
          	</div>
          	<div class="spotButtonWrapper">
          		<button class="btn lightskyBblackL categoryBtn" style="font-size:18px;">돌아가기</button>
            	<button class="btn blueBwhiteL categoryBtn" style="font-size:18px;">추가하기</button>
          	</div>
          </div>
        </div>
      </div>
        <div class="leftContainer">
            <div class="pageSettingWrapper">
            	<div class="inputWrapper">
                <input class="input textInput" type="text" name="Title" placeholder="여행 일정 제목을 입력하세요.">
                </div>
                <div class="selectionWrapper">
                    <select class="select selectInput" id="region" name="Region" form="regionForm">
                        <option value="1">서울</option>
                        <option value="2">인천</option>
                        <option value="3">대전</option>
                        <option value="4">대구</option>
                        <option value="5">광주</option>
                        <option value="6">부산</option>
                        <option value="7">울산</option>
                        <option value="8">세종</option>
                        <option value="9">경기도</option>
                        <option value="10">강원도</option>
                    </select>
                    <select class="select selectInput" name="Number_of_people" form="peopleForm">
                        <option value="1">1</option>
                        <option value="2">2</option>
                        <option value="3">3</option>
                        <option value="4">4</option>
                        <option value="5">5</option>
                        <option value="6">6</option>
                        <option value="7">7</option>
                        <option value="8">8</option>
                        <option value="9">9</option>
                        <option value="10">10</option>
                    </select>
                </div>
                <div class="select dateWrapper">
                    <input class="dateInput datepicker" type="text" name="Start_date">
                    ~
                    <input class="dateInput datepicker" type="text" name="End_date">
                </div>
            </div>

            <div class="spotWrapper">
                <div class="categoryWrapper">
                    <button class="btn softblueBwhiteL categoryBtn" id="1">음식점</button>
                    <button class="btn softblueBwhiteL categoryBtn" id="2">숙박</button>
                    <button class="btn softblueBwhiteL categoryBtn" id="3">쇼핑</button>
                </div>
                <div class="categoryWrapper">
                    <button class="btn softblueBwhiteL categoryBtn" style="font-size:18px;" id="4">문화활동</button>
                    <button class="btn softblueBwhiteL categoryBtn" id="5">관광지</button>
                    <button class="btn softblueBwhiteL categoryBtn" id="6">레포츠</button>
                </div>
                <div class="searchWrapper searchSize">
                    <input class="input searchInput" type="text" name="Title" placeholder="여행 일정 제목을 입력하세요.">
                    <button class="btn searchBtn" name="searchBtn">검색</button>
                </div>
                <div class="planCardWrapper">
                    <div class="planCards">
                    </div>
                    <div class="pageWrapper">
                        
                    </div>
                </div>
            </div>
        </div>
        <div class="rightContainer">
            <div class="mapContainer">
                <div id="map" style="width:100%;height:100%;"></div>
            </div>
            <div class="bottomContainer">
            	<div class="pageController">< 1일차 ></div>
            	<div class="timeTable">
            	</div>
            	<div class="bottomWrapper">
            	<div class="totalBudget bold">총 예산: 1,400,000 원</div>
            	</div>
            	<div class="bottomButtonWrapper">
            		<button class="btn lightskyBblackL categoryBtn" style="font-size:18px;">임시저장</button>
            		<button class="btn blueBwhiteL categoryBtn">완료</button>
            	</div>
            </div>
        </div>
    </div>
    <script>
        // 좌표로 맵 만들어주는 네이버 API
        var mapOptions = {
            center: new naver.maps.LatLng(37.514575, 127.0495556),
            zoom: 11,
            mapDataControl: false
        };
        
        var map = new naver.maps.Map('map', mapOptions);
        map.Position = 3;
    </script>
</body>
</html>