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
    <title>Document</title>
    <script>
	// 변수 초기 설정
    var region = 1;
	var category = '-1';
	var sword = '';
	var day = 1;
	var period = 1;
	var markerList = [];
	var savedList = [];
	var details = {};
	var totalBudget = 0;

	
    	// 장소 리스트 받아오는 함수
    	function fetchData(page, region, category, sword, max_lat, max_lng, min_lat, min_lng) {
    	  $.ajax({
    	    url: 'filter.do?page=' + page + '&region=' + region + '&category=' + category + '&sword=' + sword + '&max_lat=' + max_lat + '&min_lat=' + min_lat + '&max_lng=' + max_lng + '&min_lng=' + min_lng,
    	    method: 'GET',
    	    dataType: 'json',
    	    success: function(data) {
    	    	
    	      // 기존 마커과 장소 정보들 지움
    	      for (var i = 0; i < markerList.length; i++) {
    	        markerList[i].setMap(null);
    	      }
    	      $('.planCards').empty();
    	      
    	      // 마커와 장소 정보들 새로 생성
    	      $.each(data.locationList, function(index, location) {
    	        var planCard = $('<div>').addClass('planCard');
    	        var planPhoto = $('<div>').addClass('planPhoto');
    	        var plan = $('<div>').addClass('plan');
    	        var boldText = $('<div>').addClass('bold').text(location.location_name);
    	        var categoryText = $('<div>').text(location.category_name);
    	        var idx = $('<div>').addClass('index').text(index);
    	        var spotDetail = $('<div>').addClass('spotDetail cardButtonWrapper').attr('id', location.location_pk + ' ' + index);
    	        var locationDetailBtn = $('<button>').addClass('locationDetailBtn').attr('name', 'locationDetailBtn');
    	        var image = $('<img>').attr('src', '/main/image/plan/Vector.png').attr('width', '20');

    	        locationDetailBtn.append(image);
    	        spotDetail.append(locationDetailBtn);
    	        plan.append(boldText, categoryText, idx);
    	        planCard.append(planPhoto, plan, spotDetail);
    	        $('.planCards').append(planCard);

    	        var marker = new naver.maps.Marker({
    	          position: new naver.maps.LatLng(location.latitude, location.longitude),
    	          map: map
    	        });
    	        markerList.push(marker);
    	      });

    	      $('.index').hide();

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
    	
    	function moveMap() {
            bounds = map.getBounds(); // 현재 지도 영역의 좌표 범위 가져오기
            max_lat = bounds._max['_lat'];
            max_lng = bounds._max['_lng'];
            min_lat = bounds._min['_lat'];
            min_lng = bounds._min['_lng'];
            page = 1;
            fetchData(1, region, category, sword, max_lat, max_lng, min_lat, min_lng);
    	}
    	
    	// 시간표 갱신 함수
    	function generatePlanTable(details, totalBudget) {
    		  $(".planPerHour").empty();
    		  $(".planPerHour").append("<tr>");
			  if (!(details.hasOwnProperty(day))) {
				for (hour = 0; hour <= 23; hour++) {
		    	  $(".planPerHour").append("<td></td>");
		    	}
			  } else {
    		    for (hour = 0; hour <= 23; hour++) {
    		      if (details[day].hasOwnProperty(hour)) {
    		        var mergeCount = details[day][hour][1] - details[day][hour][0] + 1;
    		        $(".planPerHour").append("<td colspan=" + mergeCount + ">" + details[day][hour][6] + "</td>");
    		        hour = hour + mergeCount - 1;
    		      } else {
    		        $(".planPerHour").append("<td></td>");
    		      }
    		    }
			  }

    		  $(".planPerHour").append("</tr>");

    		  $(".totalBudget").empty();
    		  $(".totalBudget").append("총 예산: " + totalBudget + " 원");
    	}
    	
    	function generateDay(day, period) {
    		$(".day").empty();
        	$('.nextDayBtn').removeClass(function(index, className) {
        		  return (className.match(/\b(?!nextDayBtn)\S+/g) || []).join(' ');
        		});
        	$('.prevDayBtn').removeClass(function(index, className) {
        		  return (className.match(/\b(?!prevDayBtn)\S+/g) || []).join(' ');
        		});
        	$(".day").append(day + "일차");
        	if (day < period) {
        		$(".nextDayBtn").addClass("canNextClick");
        	}
        	if (day > 1) {
        		$(".prevDayBtn").addClass("canPrevClick");
        	}
        	
        	generatePlanTable(details, totalBudget)
    	}
    
        // 각 지역별 대표 좌표
        var regionPoint = {};
        regionPoint['1'] = new naver.maps.LatLng(37.514575, 127.0495556);
        regionPoint['2'] = new naver.maps.LatLng(37.4562557, 126.7052062);
        regionPoint['3'] = new naver.maps.LatLng(36.3506295, 127.3848616);
        regionPoint['4'] = new naver.maps.LatLng(35.82692778, 128.5350639);
        regionPoint['5'] = new naver.maps.LatLng(35.1595454, 126.8526012);
        regionPoint['6'] = new naver.maps.LatLng(35.20916389, 128.9829083);
        regionPoint['7'] = new naver.maps.LatLng(35.54404265, 129.3301754);
        regionPoint['8'] = new naver.maps.LatLng(36.479522, 127.289448);
        regionPoint['9'] = new naver.maps.LatLng(37.14691389, 127.0796417);
        regionPoint['10'] = new naver.maps.LatLng(37.74913611, 128.8784972);

        $(function() {
    		
    		// 최초 일차 작성
    		generateDay(day, period);
    		
    		// 일차에서 다음 버튼 눌렀을때
    		$('.pageController').on('click', '.canNextClick', function() {
            	day = day + 1;
            	console.log(day);
            	generateDay(day, period);
            })
            
            // 일차에서 이전 버튼 눌렀을때
    		$('.pageController').on('click', '.canPrevClick', function() {
            	day = day - 1;
            	generateDay(day, period);
            })
        	
        	// 모달 관련
        	$('.planCards').on('click', '.spotDetail', function() {
        		var tmp = $(this).attr('id').split(' ');
        		var pk = tmp[0];
        		var order = tmp[1];
            	$.ajax({
            		url: 'spotDetail.do?location_pk=' + pk,
            		method: 'GET',
            		dataType: 'json',
            		success: function(data) {
            			var modalContent = $('#modalContent');
                        modalContent.empty(); // 기존 내용 초기화

                        var listItem = $('<li>').html('<div class="location_name bold">' + data.location_name + '</div>'); // JSON 데이터의 필드에 따라 내용을 조정할 수 있습니다.
                        modalContent.append(listItem);
                        var sTime = new Date(data.start_time).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }).replace(/(AM|PM)/, '').trim();
                        var eTime = new Date(data.end_time).toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit' }).replace(/(AM|PM)/, '').trim();
                        listItem = $('<li>').html('<div class="bold"> 영업시간 : ' + sTime + ' AM ~' + eTime + ' PM</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="bold"> 주소 : ' + data.address + '</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="bold"> 연락처 : ' + data.location_tel + '</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="location_pk">' + pk + '</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="location_longitude">' + data.longitude + '</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="location_latitude">' + data.latitude + '</div>');
                        modalContent.append(listItem);
                        listItem = $('<li>').html('<div class="order">' + order + '</div>');
                        modalContent.append(listItem);
                        $(".location_pk").hide();
                        $(".location_longitude").hide();
                        $(".location_latitude").hide();
                        $(".order").hide();
            		},
            		error: function() {
            			alert('데이터를 가져오는 데 실패했습니다.');
            		}
            	})
           		$(".spotModal").fadeIn();
        	  });
        	
        	// 모달 관련
            $(".spotModalContent").click(function (e) {
            // e.preventDefault();
            	e.stopPropagation();
            });
            $(".spotModalOutButton").click(function (e) {
            	$(".spotModal").fadeOut();
            });
        	
        	// 최초로 plancard를 만들어주는 ajax
        	fetchData(page, region, category, sword, max_lat, max_lng, min_lat, min_lng);
        	
            // jquery 달력 불러옴
            $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});
            
            $('.datepicker').change(function() {
            	var start = new Date($(".startDate").val());
           		var end = new Date($(".endDate").val());
           		var timeDiff = Math.abs(start.getTime() - end.getTime());
	           	var diffDays = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)) + 1;
    	       	if (diffDays > 0) {
    	       		period = diffDays;
    	       	}
    	       	generateDay(day, period);
            });

            // regionSelect 변경시 지도 해당 도시로 이동
            var selectBox = $("#region");
            selectBox.on("change", function(){
            	region = $("#region option:selected").val();
                map.setCenter(regionPoint[$("#region option:selected").val()]);
                sword = '';
                $(".searchInput").val('');
                // 네이버 지도에서 이벤트 처리하는 걸로 변경
            })
            
            // 카테고리 버튼 클릭시 해당 카테고리 장소만 노출됨
            $(".categoryBtn").click(function () {
            	categoryInput = $(this).attr('id');
             	if (category === categoryInput) {
             		$(this).removeClass('blueBwhiteL');
             		$(this).removeClass('categorySelected');
             		$(this).addClass('softblueBwhiteL');
             		category = '-1';
             	} else {
             		category = categoryInput;
             		$(".categorySelected").addClass('softblueBwhiteL');
             		$(".categorySelected").removeClass('blueBwhiteL');
             		$(this).addClass('blueBwhiteL');
             		$(this).addClass('categorySelected');
             		$(this).removeClass('softblueBwhiteL');
             	}
             	page = 1;
             	fetchData(page, region, category, sword, max_lat, max_lng, min_lat, min_lng);
            })
            
            // 페이지 이동
            $(document).on("click", ".movePage", function() {
    			page = $(this).text();
    			fetchData(page, region, category, sword, max_lat, max_lng, min_lat, min_lng);
  			});
            
            $(document).on("click", ".nextPage", function() {
    			page = $(this).attr('id');
    			fetchData(page, region, category, sword, max_lat, max_lng, min_lat, min_lng);
  			});
            
            $(document).on("click", ".prevPage", function() {
    			page = $(this).attr('id');
    			fetchData(page, region, category, sword, max_lat, max_lng, min_lat, min_lng);
  			});
            
            // 검색 기능
            $(".searchBtn").click(function() {
            	sword = $('.searchInput').val();
            	fetchData(page, region, category, sword, max_lat, max_lng, min_lat, min_lng);
            })
            
            
         	// 여행 세부 계획 임시 저장
        	$(".submitDetail").click(function () {
        		var lName = $(".location_name").text();
        		var lBudget = Number($(".budgetTextInput").val());
        		var sTime = Number($(".startTime").val());
        		var eTime = Number($(".endTime").val());
        		var lPk = $(".location_pk").text();
        		var lLong = $(".location_longitude").text();
        		var lLat = $(".location_latitude").text();
        		var saveIndex = Number($(".order").text());
        		if (!details.hasOwnProperty(day)) {
        			details[day] = {};
        		}
        		
        		if (sTime > eTime) {
        			alert('시작 시점이 종료 시점보다 늦습니다.');
        			$(".spotModal").fadeOut();
        			return;
        		}
        		
        		for (hour = sTime; hour <= eTime; hour++) {
        			if (details[day].hasOwnProperty(hour)) {
        				alert('이미 해당 시간에 다른 여행계획이 있습니다.');
        				$(".spotModal").fadeOut();
        				return;
        			}
    			}
        		
        		totalBudget += lBudget;
        		
        		for (hour = sTime; hour <= eTime; hour++) {
    				details[day][hour] = [sTime, eTime, lPk, lLong, lLat, saveIndex, lName, lBudget];
    			}
        		
        		markerList[saveIndex].setMap(null);
        		
        		
        		var markerOptions = {
        			position: new naver.maps.LatLng(lLat, lLong),
        			map: map,
        			icon: {
        	        url: '/main/image/plan/saveMarker.png',
        	    	},
        	    	zIndex: 2
        		
        		};
        		
        		var marker = new naver.maps.Marker(markerOptions);
        		savedList.push(marker);
        		
        		
        		// 시간표 갱신
        		generatePlanTable(details, totalBudget);
        		
        		$(".spotModal").fadeOut();
        		
        	})
        });
    </script>
    <link rel="stylesheet" href="/main/css/reset.css">
    <link rel="stylesheet" href="/main/css/common.css">
    <link rel="stylesheet" href="/main/css/plan/index.css?aa">
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
          	  		<select class="select selectInput startTime" name="startTime" form="timeForm">
          	        <c:forEach var="tmp" begin="0" end="23" step="1" varStatus="st">
                        <option value="${st.count - 1 }">${st.count - 1 }:00</option>
                    </c:forEach>
                    </select>
                    ~
                    <select class="select selectInput endTime" name="endTime" form="timeForm">
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
          		<button class="btn lightskyBblackL spotSaveBtn spotModalOutButton" style="font-size:18px;">돌아가기</button>
            	<button class="btn blueBwhiteL spotSaveBtn submitDetail" style="font-size:18px;">추가하기</button>
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
                    <input class="dateInput datepicker startDate" type="text" name="Start_date">
                    ~
                    <input class="dateInput datepicker endDate" type="text" name="End_date">
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
            	<div class="pageController">
            	<div class="prevDayBtn" style="display:inline; cursor:pointer;"><</div>
            	<div class="day" style="display:inline;"></div> 
            	<div class="nextDayBtn" style="display:inline; cursor:pointer;">></div>
            	</div>
            	<div class="timeTableWrapper">
            	<table class="timeTable" border="1">
            		<thead>
            		<tr>
            		<th>00:00</th>
            		<th>01:00</th>
            		<th>02:00</th>
            		<th>03:00</th>
            		<th>04:00</th>
            		<th>05:00</th>
            		<th>06:00</th>
            		<th>07:00</th>
            		<th>08:00</th>
            		<th>09:00</th>
            		<th>10:00</th>
            		<th>11:00</th>
            		<th>12:00</th>
            		<th>13:00</th>
            		<th>14:00</th>
            		<th>15:00</th>
            		<th>16:00</th>
            		<th>17:00</th>
            		<th>18:00</th>
            		<th>19:00</th>
            		<th>20:00</th>
            		<th>21:00</th>
            		<th>22:00</th>
            		<th>23:00</th>
            		</tr>
            		</thead>
            		<tbody class="planPerHour">
            		</tbody>
            	</table>
            	</div>
            	<div class="bottomWrapper">
            	<div class="totalBudget bold"></div>
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
            zoom: 15,
            mapDataControl: false
        };
        
        var map = new naver.maps.Map('map', mapOptions);
        map.Position = 3;
        var bounds = map.getBounds(); // 현재 지도 영역의 좌표 범위 가져오기
        var max_lat = bounds._max['_lat'];
        var max_lng = bounds._max['_lng'];
        var min_lat = bounds._min['_lat'];
        var min_lng = bounds._min['_lng'];
        var page = 1;
        
     // 지도의 영역이 변경되었을 때 이벤트 리스너 등록
        naver.maps.Event.addListener(map, 'idle', function() {
            moveMap();
        });
    </script>
</body>
</html>