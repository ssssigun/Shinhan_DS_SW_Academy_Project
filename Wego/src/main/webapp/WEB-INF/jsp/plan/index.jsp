<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="icon" href="/main/image/ShinhanLogo.png"/>
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=l8m4oe0ivu"></script>
<title>여행 계획</title>
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
	var polylinePath = [];
	var polyline = new naver.maps.Polyline();
	var test = [];
	var cancelBudget = [0, 0, 0, 0, 0, 0, 0];
	var tmpPlanPK = -1;
	<c:if test="${not empty plan}">
		tmpPlanPK = ${plan.plan_pk};
	</c:if>
	<c:forEach var="pd" items="${planDetail}">
		$.ajax({
		    url: "spotDetail.do?location_pk=" + ${pd.location_pk},
		    method: "GET",
		    dataType: "json",
		    success: function (data) {
				var tmpDay = ${pd.day};
				var tmpStart = Number("${pd.start_time}".split(' ')[3].split(':')[0]);
				var tmpEnd = Number("${pd.end_time}".split(' ')[3].split(':')[0]);
				var tmpBudget = ${pd.budget};
				totalBudget += tmpBudget;
				var isFirst = true;
				var priorDay = 1;
				var priorHour = 0;
				var priorPK = 0;
				cancelBudget[Number(data[0].category)] += Number(tmpBudget);
		    	for (var i = tmpStart; i <= tmpEnd; i++) {
		    		if (!(details.hasOwnProperty(tmpDay))) {
		    			details[tmpDay] = {};
		    		}
		    		details[tmpDay][i] = [tmpStart, tmpEnd, data[0].location_pk, data[0].longitude, data[0].latitude, 0, data[0].location_name, tmpBudget, data[0].category];
		    	}
		    }
		  });
	</c:forEach>

	// 장소 리스트 받아오는 함수
	function fetchData(
	  page,
	  region,
	  category,
	  sword,
	  max_lat,
	  max_lng,
	  min_lat,
	  min_lng
	) {
	  $.ajax({
	    url:
	      "filter.do?page=" +
	      page +
	      "&region=" +
	      region +
	      "&category=" +
	      category +
	      "&sword=" +
	      sword +
	      "&max_lat=" +
	      max_lat +
	      "&min_lat=" +
	      min_lat +
	      "&max_lng=" +
	      max_lng +
	      "&min_lng=" +
	      min_lng,
	    method: "GET",
	    dataType: "json",
	    success: function (data) {
	      // 기존 마커과 장소 정보들 지움
	      for (var i = 0; i < markerList.length; i++) {
	        markerList[i].setMap(null);
	      }
	      $(".planCards").empty();
	
	      // 마커와 장소 정보들 새로 생성
	      $.each(data.locationList, function (index, location) {
	        var planCard = $("<div>").addClass("planCard");
	        var planPhoto = $("<div>").addClass("planPhoto");
	        if (location.location_pic_url == "") {
	          var imgSrc = "/main/image/logoMain.png";
	        } else {
	          var imgSrc = location.location_pic_url;
	        }
	        var planImage = $("<img>").attr("src", imgSrc);
	        planImage.css({
	          "max-width": "100%",
	          "max-height": "100%",
	          width: "auto",
	          height: "auto",
	          display: "block",
	          margin: "0 auto",
	        });
	        planPhoto.append(planImage);
	        var plan = $("<div>").addClass("plan");
	        var boldText = $("<div>").addClass("bold").text(location.location_name);
	        var categoryText = $("<div>").text(location.category_name);
	        var idx = $("<div>").addClass("index").text(index);
	        var spotDetail = $("<div>")
	          .addClass("spotDetail cardButtonWrapper")
	          .attr("id", location.location_pk + " " + index);
	        var locationDetailBtn = $("<button>")
	          .addClass("locationDetailBtn")
	          .attr("name", "locationDetailBtn");
	        var image = $("<img>")
	          .attr("src", "/main/image/plan/Vector.png")
	          .attr("width", "20");
	
	        locationDetailBtn.append(image);
	        spotDetail.append(locationDetailBtn);
	        plan.append(boldText, categoryText, idx);
	        planCard.append(planPhoto, plan, spotDetail);
	        $(".planCards").append(planCard);
	
	        var marker = new naver.maps.Marker({
	          position: new naver.maps.LatLng(
	            location.latitude,
	            location.longitude
	          ),
	          map: map,
	        });
	
	        var infoWindow = new naver.maps.InfoWindow({
	          content:
	            '<div style="padding:10px;">' + location.location_name + "</div>", // 마커에 표시할 텍스트 내용
	        });
	
	        naver.maps.Event.addListener(marker, "mouseover", function () {
	          infoWindow.open(map, marker);
	        });
	        
			naver.maps.Event.addListener(marker, 'mouseout', function() {
			  infoWindow.close();
			});
	
	        markerList.push(marker);
	      });
	
	      $(".index").hide();
	
	      // 페이지네이션
	      $(".pageWrapper").empty();
	      var paging = $("<ul>").addClass("paging");
	      if (data.prev) {
	        var pageItem = $("<li>").html(
	          '<div class="prevPage" id="' +
	            (Number(data.startPage) - 1) +
	            '"><</div>'
	        );
	        paging.append(pageItem);
	        var pageItem = $("<li>").html('<div class="blank">&nbsp;</div>');
	        paging.append(pageItem);
	      }
	      for (var i = Number(data.startPage); i <= Number(data.endPage); i++) {
	        var pageItem = $("<li>").html('<div class="movePage">' + i + "</div>");
	        if (page == i) {
	          pageItem.addClass("selectLetter");
	        }
	        paging.append(pageItem);
	      }
	      if (data.next) {
	        var pageItem = $("<li>").html('<div class="blank">&nbsp;</div>');
	        paging.append(pageItem);
	        var pageItem = $("<li>").html(
	          '<div class="nextPage" id="' +
	            (Number(data.endPage) + 1) +
	            '">></div>'
	        );
	        paging.append(pageItem);
	      }
	
	      $(".pageWrapper").append(paging);
	    },
	    error: function () {
	      alert("데이터를 가져오는 데 실패했습니다.");
	    },
	  });
	}
	// 지도 움질일때마다 마커 새로 그리고 장소 받아오는 함수
	function moveMap() {
		bounds = map.getBounds(); // 현재 지도 영역의 좌표 범위 가져오기
		max_lat = bounds._max['_lat'];
		max_lng = bounds._max['_lng'];
		min_lat = bounds._min['_lat'];
		min_lng = bounds._min['_lng'];
		page = 1;
		fetchData(1, region, category, sword, max_lat, max_lng, min_lat,
				min_lng);
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
					var mergeCount = details[day][hour][1]
							- details[day][hour][0] + 1;
					$(".planPerHour").append(
							"<td colspan=" + mergeCount + ">" + "<ul>" + "<li>"
									+ details[day][hour][6] + "</li>" + "<li>"
									+ details[day][hour][7] + "원 </li>" + "<li class='planPerHourBottom'>"
									+ "<img src='/main/image/plan/cross.png' style='cursor: pointer;' width='20' class='deleteSpot' value='"+ details[day][hour][0] +","+ details[day][hour][1] + "," + details[day][hour][7]+ "'>&nbsp</li>"
									+ "</ul>" + "</td>");
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

	// 첫번째 완료 눌렀을 때 전체적으로 일차별 계획 시간표 보여주는 함수
	function generateFinTimetable(details, day, period) {
		$(".finTimetableWrapper").empty();
		for (var day2 = 1; day2 <= period; day2++) {
			$(".finTimetableWrapper")
					.append(
							"<div class='"+ day2 + "bottomContainer finContainer'></div>");
			$("." + day2 + "bottomContainer").append(
					"<div class='"+ day2 +"pageController finDay'>" + day2
							+ " 일차</div>");
			$("." + day2 + "bottomContainer")
					.append(
							"<div class='"+ day2 +"timeTableWrapper timeTableWrapper'></div>");
			$("." + day2 + "timeTableWrapper").append(
					"<table class='"+ day2 +"timeTable timeTable'></table>");
			$("." + day2 + "timeTable").append(
					"<thead><tr>" + "<th>00:00</th>" + "<th>01:00</th>"
							+ "<th>02:00</th>" + "<th>03:00</th>"
							+ "<th>04:00</th>" + "<th>05:00</th>"
							+ "<th>06:00</th>" + "<th>07:00</th>"
							+ "<th>08:00</th>" + "<th>09:00</th>"
							+ "<th>10:00</th>" + "<th>11:00</th>"
							+ "<th>12:00</th>" + "<th>13:00</th>"
							+ "<th>14:00</th>" + "<th>15:00</th>"
							+ "<th>16:00</th>" + "<th>17:00</th>"
							+ "<th>18:00</th>" + "<th>19:00</th>"
							+ "<th>20:00</th>" + "<th>21:00</th>"
							+ "<th>22:00</th>" + "<th>23:00</th>"
							+ "</tr></table>");
			$("." + day2 + "timeTable")
					.append(
							"<tbody class='" + day2 + "planPerHour planPerHour'></tbody>");
			if (!(details.hasOwnProperty(day2))) {
				for (hour = 0; hour <= 23; hour++) {
					$("." + day2 + "planPerHour").append("<td></td>");
				}
			} else {
				for (hour = 0; hour <= 23; hour++) {
					if (details[day2].hasOwnProperty(hour)) {
						var mergeCount = details[day2][hour][1]
								- details[day2][hour][0] + 1;
						$("." + day2 + "planPerHour").append(
								"<td colspan=" + mergeCount + ">" + "<ul>"
										+ "<li>" + details[day2][hour][6]
										+ "</li>" + "<li>"
										+ details[day2][hour][7] + "원 </li>"
										+ "</ul>" + "</td>");
						hour = hour + mergeCount - 1;
					} else {
						$("." + day2 + "planPerHour").append("<td></td>");
					}
				}
			}
		}
	}

	// 여행 기간 지정하거나 변경했을 때 시간표 위에 있는 일차 정보 갱신하는 함수
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

	// 세이브 마커 찍는 함수
	function createMarker(day, details, map, savedList) {
		// 마우스오버 이벤트 걸기 위한 리스트
		var savedInfo = [];
		// 기존에 저장된 세이브 마커 제거
		for (var i = 0; i < savedList.length; i++) {
			savedList[i].setMap(null);
		}

		// 해당 일자에 해당하는 계획 탐색하며 마커 찍음
		if (details.hasOwnProperty(day)) {
			for (var hour = 0; hour <= 23; hour++) {
				if (details[day].hasOwnProperty(hour)) {
					var cnt = details[day][hour][1] - details[day][hour][0] + 1;
					hour = hour + cnt - 1;
					var markerOptions = {
						position : new naver.maps.LatLng(details[day][hour][4],
								details[day][hour][3]),
						map : map,
						icon : {
							url : '/main/image/plan/saveMarker.png',
						},
						zIndex : 2
					};

					var marker = new naver.maps.Marker(markerOptions);
					var infoWindow = new naver.maps.InfoWindow({
						content : '<div style="padding:10px;">'
								+ details[day][hour][6] + '</div>'
					});
					savedList.push(marker);
					savedInfo.push({
						marker : marker,
						infoWindow : infoWindow
					});
				}
			}

			for (var i = 0; i < savedInfo.length; i++) {
				(function(index) {
					var marker = savedInfo[index].marker;
					var infoWindow = savedInfo[index].infoWindow;

					naver.maps.Event.addListener(marker, 'mouseover',
							function() {
								infoWindow.open(map, marker);
							});
					naver.maps.Event.addListener(marker, 'mouseout', 
							function() {
						  		infoWindow.close();
							});
				})(i);
			}
		}
	}

	// 경로 그리는 함수
	function createOrUpdatePolyline(day, details, map) {
		var init = 0;
		var prior = 0;
		var polylinePath = [];
		if (details.hasOwnProperty(day)) {
			for (var hour = 0; hour <= 23; hour++) {
				if (details[day].hasOwnProperty(hour)) {
					var cnt = details[day][hour][1] - details[day][hour][0] + 1;
					hour = hour + cnt - 1;
					if (init == 1) {
						var path = findRoute(details[day][prior][3], details[day][prior][4], details[day][hour][3], details[day][hour][4]);
						for (var i = 0; i < path.length; i++) {
							polylinePath.push(new naver.maps.LatLng(
									path[i][1], path[i][0]));
						}
					} else {
						init = 1;
					}
					prior = hour;
				}
			}
		}

		if (polyline && polyline.getMap()) {
			polyline.setMap(null); // 기존 polyline 객체를 지도에서 제거
		}

		polyline = new naver.maps.Polyline({
			path : polylinePath,
			strokeColor : '#FF0000',
			strokeOpacity : 0.8,
			strokeWeight : 3,
			map : map
		});

		return polyline;
	}

	// 마지막 총 계산하는 함수, 나중에 유저 pk 받아오자!
	function calculate(details) {

		var dataArray = [];
		// details를 for문으로 탐색해서 json형태로 dataArray에 넣어줄 것!
		for ( var d in details) {
			for ( var h in details[d]) {
				var data = {
					'day' : d,
					'hour' : h,
					'info' : details[d][h]
				}
				dataArray.push(data);
			}
		}

		$.ajax({
			url : 'calculate.do',
			method : 'POST',
			contentType : 'application/json; charset=utf-8',
			traditional : true,
			data : JSON.stringify({
				details : dataArray
			}),
			dataType : 'json',
			success : function(response) {
				for (var i = 1; i < 8; i++) {
					$(".ori" + i).empty();
					$(".point" + i).empty();
					$(".ori" + i).append(response[0][i]);
					$(".point" + i).append(response[1][i]);
				}
			},
			error : function() {
				alert('데이터를 가져오는 데 실패했습니다.');
			}

		});
	}
	
	
	// 세부 경로 그리는 함수
	function findRoute(start_long, start_lat, end_long, end_lat) {
		$.ajax({
			url : 'findRoute.do?start_long=' + start_long + '&start_lat=' + start_lat + '&end_long=' + end_long + '&end_lat=' + end_lat,
			async: false,
			method : 'GET',
			success : function(response) {
				path = response;
			},
			error : function() {
				alert('데이터를 가져오는 데 실패했습니다.');
			}

		});
		
		return path;
	}
	
	function createCommentCard(Left, Right, InfoRight) {
		  // commentCardWrapper 요소 선택
		  var commentCardWrapper = document.querySelector('.commentCardWrapper');
		  // commentCard 요소 생성
		  var commentCard = document.createElement('div');
		  commentCard.classList.add('commentCard');

		  // comment 요소 생성
		  var comment = document.createElement('div');
		  comment.classList.add('comment');

		  // commentLeft 요소 생성
		  var commentLeft = document.createElement('div');
		  commentLeft.classList.add('commentLeft');
		  commentLeft.textContent = Left;
		  comment.appendChild(commentLeft);

		  // commentRight 요소 생성
		  var star = '';
		  for (var i = 0; i < Number(Right); i++) {
			  star += '★';
		  }
		  for (var i = 0; i < 5 - Number(Right); i++) {
			  star += '☆';
		  }
		  var commentRight = document.createElement('div');
		  commentRight.classList.add('commentRight');
		  commentRight.textContent = star;
		  comment.appendChild(commentRight);

		  // comment 요소를 commentCard에 추가
		  commentCard.appendChild(comment);

		  // commentInfo 요소 생성
		  var commentInfo = document.createElement('div');
		  commentInfo.classList.add('commentInfo');

		  var dbDate = InfoRight;
		  var dateObject = new Date(dbDate);
		  var formattedDate = dateObject.toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' });
		  // commentInfoRight 요소 생성
		  var commentInfoRight = document.createElement('div');
		  commentInfoRight.classList.add('commentInfoRight');
		  commentInfoRight.textContent = formattedDate;
		  commentInfo.appendChild(commentInfoRight);

		  // commentInfo 요소를 commentCard에 추가
		  commentCard.appendChild(commentInfo);

		  // commentCard를 commentCardWrapper에 추가
		  commentCardWrapper.appendChild(commentCard);
	}
	
	// 임시저장 혹은 저장 하는 함수
	function submitPlan(_state, _plan_pk, cancelBudget) {
	  var user_pk = 1; // 나중에 유저 pk 받아오게 변환
	  var title = $(".textInput").val();
	  var num_of_people = $('.number_of_people').val();
	  var start_date = $('.startDate').val();
	  var end_date = $('.endDate').val();
	
	  var plan_details = [];
	  for (var day = 1; day <= period; day++) {
	    if (details.hasOwnProperty(day)) {
	      for (hour = 0; hour <= 23; hour++) {
	        if (details[day].hasOwnProperty(hour)) {
	          var cnt = details[day][hour][1] - details[day][hour][0] + 1;
	          hour = hour + cnt - 1;
	
	          var location_pk = details[day][hour][2];
	          var start_time = details[day][hour][0];
	          var end_time = details[day][hour][1];
	          var budget = details[day][hour][7];
	          var category = details[day][hour][8];
	          var plan_detail = [location_pk, start_time, end_time, budget, day, category];
	          plan_details.push(plan_detail);
	        }
	      }
	    }
	  }
	  
	  if (plan_details.length == 0) {
		  alert('최소 하나 이상의 여행지를 선택해주세요.');
		  return;
	  }
	  
	  <c:if test="${not empty plan}">
	  $.ajax({
		    url: 'delete.do?plan_pk=' + ${plan.plan_pk},
		    method: 'GET',
		    success: function (response) {
				console.log('삭제');
		    },
		    error: function (xhr, status, error) {
		      alert('데이터를 가져오는 데 실패했습니다.\n에러 메시지: ' + error);
		    }
		  });
	  insertOrUpdate = 1;
	  	<c:if test="${plan.state == 0}">
		  $.ajax({
			    url: 'subtract.do?food=' + cancelBudget[1] + '&accommodation=' + cancelBudget[2] + '&shopping=' + cancelBudget[3] + '&culture=' + cancelBudget[4] + '&tour=' + cancelBudget[5] + '&leisure=' + cancelBudget[6],
			    method: 'GET',
			    success: function (response) {
					console.log('뺴기');
			    },
			    error: function (xhr, status, error) {
			      alert('데이터를 가져오는 데 실패했습니다.\n에러 메시지: ' + error);
			    }
			  });
	  	</c:if>
	  </c:if>
	
	  $.ajax({
	    url: 'submit.do',
	    method: 'POST',
	    contentType: 'application/json; charset=utf-8',
	    traditional: true,
	    data: JSON.stringify({
	      user_pk: user_pk,
	      title: title,
	      num_of_people: num_of_people,
	      start_date: start_date,
	      end_date: end_date,
	      plan_details: plan_details,
	      state: _state,
	      plan_pk: _plan_pk,
	    }),
	    dataType: 'json',
	    success: function (response) {
	      window.location.href = '/main/myRecord/plan/index.do';
	    },
	    error: function (xhr, status, error) {
	      alert('데이터를 가져오는 데 실패했습니다.\n에러 메시지: ' + error);
	    }
	  });
	  
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
		<c:if test="${not empty plan}">
		var monthMap = {
				  "Jan": "01",
				  "Feb": "02",
				  "Mar": "03",
				  "Apr": "04",
				  "May": "05",
				  "Jun": "06",
				  "Jul": "07",
				  "Aug": "08",
				  "Sep": "09",
				  "Oct": "10",
				  "Nov": "11",
				  "Dec": "12",
				};
		
	    // "plan" 값이 존재하는 경우에 실행될 제이쿼리 코드
	    	var plan_pk = ${plan.plan_pk};
			var inputDate = "${plan.start_date}";
			var dateParts = inputDate.split(" ");
			var year = dateParts[5]; // "2023"
			var month = monthMap[dateParts[1]]; // "07"
			var tmpday = ("0" + dateParts[2]).slice(-2); // "02"
			var startDate = year + "-" + month + "-" + tmpday;

			var inputDate = "${plan.end_date}";
			var dateParts = inputDate.split(" ");
			var year = dateParts[5]; // "2023"
			var month = monthMap[dateParts[1]]; // "07"
			var tmpday = ("0" + dateParts[2]).slice(-2); // "02"
			var endDate = year + "-" + month + "-" + tmpday;
			
			var plan = {
	    		title: "${plan.title}",
	    		num_of_people: ${plan.num_of_people},
	    		start_date: startDate,
	    		end_date: endDate
	    	};
			
			$('.textInput').val("${plan.title}");
			$('.number_of_people').val(${plan.num_of_people});
			$('.startDate').val(startDate);
			$('.endDate').val(endDate);
			var start = new Date($(".startDate").val());
			var end = new Date($(".endDate").val());

			var timeDiff = Math.abs(start.getTime() - end.getTime());
			var diffDays = Math.ceil(timeDiff / (1000 * 60 * 60 * 24)) + 1;
			if (diffDays > 0) {
				period = diffDays;
			}

		</c:if>

		generateDay(day, period);
		setTimeout(function() {
			createMarker(day, details, map, savedList);
			polyline = createOrUpdatePolyline(day, details, map);
			generateDay(day, period);
			console.log(cancelBudget);
		}, 1000);

		//나가기 버튼 눌렀을 때 메인으로 반환
		$(".outBtn").click(function(e) {
			window.location.href = '/main/main.do';
		});
		//


		// 일차에서 다음 버튼 눌렀을때
		$('.pageController').on('click', '.canNextClick', function() {
			day = day + 1;
			createMarker(day, details, map, savedList);
			polyline = createOrUpdatePolyline(day, details, map);
			generateDay(day, period);
		})

		// 일차에서 이전 버튼 눌렀을때
		$('.pageController').on('click', '.canPrevClick', function() {
			day = day - 1;
			createMarker(day, details, map, savedList);
			polyline = createOrUpdatePolyline(day, details, map);
			generateDay(day, period);
		})

		// 모달 관련
		$(".planCards").on("click", ".spotDetail", function () {
		  var visited = {};
		  var visitedReview = {};
		  var tmp = $(this).attr("id").split(" ");
		  var pk = tmp[0];
		  var order = tmp[1];
		  $.ajax({
		    url: "spotDetail.do?location_pk=" + pk,
		    method: "GET",
		    dataType: "json",
		    success: function (data) {
		      var spotMainPhoto = $(".spotMainPhoto");
		      spotMainPhoto.empty();
		      $('.budgetTextInput').val('');
			  if (Number(data[0].category) == 2) {
				  $('.budgetTextInput').prop('readonly', true);
				  $('.budgetTextInput').attr('placeholder', '숙박은 예산 입력 불가');
			  } else {
				  $('.budgetTextInput').prop('readonly', false);
				  $('.budgetTextInput').attr('placeholder', '숫자만 입력');				  
			  }
		      if (data[0].location_pic_url == "") {
		        var mainSrc = "/main/image/logoMain.png";
		      } else {
		        var mainSrc = data[0].location_pic_url;
		      }
		
		      var mainImage = $("<img>").attr("src", mainSrc);
		      mainImage.css({
		        "max-width": "100%",
		        "max-height": "100%",
		        width: "auto",
		        height: "auto",
		        display: "block",
		        margin: "0 auto",
		      });
		      spotMainPhoto.append(mainImage);
		
		      var spotSubPhoto = $(".spotSubPhoto");
		      spotSubPhoto.empty();
		      
			  var commentCardWrapper = document.querySelector('.commentCardWrapper');
			  commentCardWrapper.innerHTML = '';
	
		      for (var i = 0; i < data.length; i++) {
		    	if (visitedReview[Number(data[i].location_review_pk)] != 1 && Number(data[i].location_review_pk) != 0) {
		    		createCommentCard(data[i].location_content, data[i].star, data[i].regdate);
		    		visitedReview[Number(data[i].location_review_pk)] = 1;
			    }  
		    	if (visited[data[i].location_pic_url] == 1) {
		    		continue;
		    	}
		    	visited[data[i].location_pic_url] = 1;
			    if (data[i].location_pic_url == "") {
					var subSrc = "/main/image/logoMain.png";
				} else {
				    var subSrc = data[i].location_pic_url;
				}		    	  
		        var subPhoto = $("<img>").attr("src", subSrc);
		        subPhoto.css({
		          padding: "30px",
		          height: "70%",
		        });
		        spotSubPhoto.append(subPhoto);
		      }
		      
		      var modalContent = $("#modalContent");
		      modalContent.empty(); // 기존 내용 초기화
		
		      var listItem = $("<li>").html(
		        '<div class="location_name bold">' + data[0].location_name + "</div>"
		      ); // JSON 데이터의 필드에 따라 내용을 조정할 수 있습니다.
		      modalContent.append(listItem);
		      var sTime = new Date(data[0].start_time)
		        .toLocaleTimeString("en-US", {
		          hour: "2-digit",
		          minute: "2-digit",
		        })
		        .replace(/(AM|PM)/, "")
		        .trim();
		      var eTime = new Date(data[0].end_time)
		        .toLocaleTimeString("en-US", {
		          hour: "2-digit",
		          minute: "2-digit",
		        })
		        .replace(/(AM|PM)/, "")
		        .trim();
		      listItem = $("<li>").html(
		        '<div class="bold"> 영업시간 : ' + sTime + " AM ~" + eTime + " PM</div>"
		      );
		      modalContent.append(listItem);
		      listItem = $("<li>").html(
		        '<div class="bold"> 주소 : ' + data[0].address + "</div>"
		      );
		      modalContent.append(listItem);
		      listItem = $("<li>").html(
		        '<div class="bold"> 연락처 : ' + data[0].location_tel + "</div>"
		      );
		      modalContent.append(listItem);
		      listItem = $("<li>").html('<div class="location_pk">' + pk + "</div>");
		      modalContent.append(listItem);
		      listItem = $("<li>").html(
		        '<div class="location_longitude">' + data[0].longitude + "</div>"
		      );
		      modalContent.append(listItem);
		      listItem = $("<li>").html(
		        '<div class="location_latitude">' + data[0].latitude + "</div>"
		      );
		      modalContent.append(listItem);
		      listItem = $("<li>").html('<div class="order">' + order + "</div>");
		      modalContent.append(listItem);
		      listItem = $("<li>").html(
		        '<div class="location_category">' + data[0].category + "</div>"
		      );
		      modalContent.append(listItem);
		      $(".location_pk").hide();
		      $(".location_longitude").hide();
		      $(".location_latitude").hide();
		      $(".order").hide();
		      $(".location_category").hide();
		    },
		    error: function () {
		      alert("데이터를 가져오는 데 실패했습니다.");
		    },
		  });
		  $(".spotModal").fadeIn();
		});


		// 모달 관련
		$(".spotModalContent").click(function(e) {
			// e.preventDefault();
			e.stopPropagation();
		});
		$(".spotModalOutButton").click(function(e) {
			$(".spotModal").fadeOut();
		});
		$(".spotModal").click(function(e) {
			$(".spotModal").fadeOut();
		});

		$(".finBtn").click(function(e) {
			$(".finModal").fadeIn();
			generateFinTimetable(details, day, period);
		});

		$(".finContent").click(function(e) {
			// e.preventDefault();
			e.stopPropagation();
		});

		$(".finModal").click(function(e) {
			$(".finModal").fadeOut();
		});

		$(".finModalOutButton").click(function(e) {
			$(".finModal").fadeOut();
		});

		$(".finNext").click(function(e) {
			$(".finModal").fadeOut();
			$(".lastModal").fadeIn();

			// 미완
			calculate(details);
		});

		$(".lastContent").click(function(e) {
			// e.preventDefault();
			e.stopPropagation();
		});

		$(".lastModal").click(function(e) {
			$(".lastModal").fadeOut();
		});

		$(".lastModalOutButton").click(function(e) {
			$(".lastModal").fadeOut();
		});

		// 최초로 plancard를 만들어주는 ajax
		fetchData(page, region, category, sword, max_lat, max_lng, min_lat,
				min_lng);

		// jquery 달력 불러옴
		$(".datepicker").datepicker({
			dateFormat : 'yy-mm-dd'
		});

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
		selectBox.on("change", function() {
			region = $("#region option:selected").val();
			map.setCenter(regionPoint[$("#region option:selected").val()]);
			sword = '';
			$(".searchInput").val('');
			// 네이버 지도에서 이벤트 처리하는 걸로 변경
		})

		// 카테고리 버튼 클릭시 해당 카테고리 장소만 노출됨
		$(".categoryBtn").click(
				function() {
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
					fetchData(page, region, category, sword, max_lat, max_lng,
							min_lat, min_lng);
				})

		// 페이지 이동
		$(document).on(
				"click",
				".movePage",
				function() {
					page = $(this).text();
					fetchData(page, region, category, sword, max_lat, max_lng,
							min_lat, min_lng);
				});

		$(document).on(
				"click",
				".nextPage",
				function() {
					page = $(this).attr('id');
					fetchData(page, region, category, sword, max_lat, max_lng,
							min_lat, min_lng);
				});

		$(document).on(
				"click",
				".prevPage",
				function() {
					page = $(this).attr('id');
					fetchData(page, region, category, sword, max_lat, max_lng,
							min_lat, min_lng);
				});

		// 검색 기능
		$(".searchBtn").click(
				function() {
					sword = $('.searchInput').val();
					fetchData(page, region, category, sword, max_lat, max_lng,
							min_lat, min_lng);
				})

		// 여행 세부 계획 임시 저장
		$(".submitDetail").click(
				function() {
					var lName = $(".location_name").text();
					var lBudget = Number($(".budgetTextInput").val());
					var sTime = Number($(".startTime").val());
					var eTime = Number($(".endTime").val());
					var lPk = $(".location_pk").text();
					var lLong = $(".location_longitude").text();
					var lLat = $(".location_latitude").text();
					var saveIndex = Number($(".order").text());
					var lCategory = $(".location_category").text();
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
						details[day][hour] = [ sTime, eTime, lPk, lLong, lLat,
								saveIndex, lName, lBudget, lCategory ];
					}

					markerList[saveIndex].setMap(null);

					// 마커 찍기
					createMarker(day, details, map, savedList);

					// 경로 갱신
					polyline = createOrUpdatePolyline(day, details, map);
					// 시간표 갱신
					generatePlanTable(details, totalBudget);

					$(".spotModal").fadeOut();

				})
				
		//마지막 제출 눌렀을 때 DB에 plan, plan_detail 삽입
		$(".submitBtn").click(function(e) {
			submitPlan(0, tmpPlanPK, cancelBudget);
		});
		//
		
		// 임시저장 버튼
		$(".tmpBtn").click(function(e) {
			submitPlan(2, tmpPlanPK, cancelBudget);
		});
		// 계획 삭제
		$(".planPerHour").on("click", ".deleteSpot", function(e) {
		  var start_end = $(this).attr("value").split(',');
		  for (var i = start_end[0]; i <= start_end[1]; i++) {
			  delete details[day][i];
		  }
		  totalBudget -= start_end[2];
			// 마커 찍기
			createMarker(day, details, map, savedList);
			// 경로 갱신
			polyline = createOrUpdatePolyline(day, details, map);
			// 시간표 갱신
			generatePlanTable(details, totalBudget);
		});
	});
</script>
<link rel="stylesheet" href="/main/css/reset.css">
<link rel="stylesheet" href="/main/css/common.css">
<link rel="stylesheet" href="/main/css/plan/index.css?adcdddddddd">
</head>
<body>
	<div class="wrap">
		<!-- 장소 세부 사항 모달 부분-->
		<div class="spotModal">
			<div class="spotModalContent">
				<div class="spotLeftContainer">
					<div class="spotMainPhoto"></div>
					<div class="spotDetails">
						<ul id="modalContent"></ul>
					</div>
					<div class="spotSubPhoto swiper"></div>
					<div class="spotInputWrapper">
						<div class="timeInput">
							<select class="select selectInput startTime" name="startTime"
								form="timeForm">
								<c:forEach var="tmp" begin="0" end="23" step="1" varStatus="st">
									<option value="${st.count - 1 }">${st.count - 1 }:00</option>
								</c:forEach>
							</select> ~ <select class="select selectInput endTime" name="endTime"
								form="timeForm">
								<c:forEach var="tmp" begin="0" end="23" step="1" varStatus="st">
									<option value="${st.count - 1 }">${st.count - 1 }:59</option>
								</c:forEach>
							</select>
						</div>
						<div class="inputWrapper budgetInput">
							예산:
							<!-- input 태그 삽입시 가운데 정렬이 안돼서 'flex-grow: 1;' 부분만 빼고 budgetTextInput에 복붙함 -->
							<input class="budgetTextInput" type="text" name="budget"
								placeholder="숫자만 입력"> 원
						</div>
					</div>
				</div>
				<div class="spotRightContainer">
					<div class="commentCardWrapper">
					</div>
					<div class="spotButtonWrapper">
						<button class="btn lightskyBblackL spotSaveBtn spotModalOutButton"
							style="font-size: 18px;">돌아가기</button>
						<button class="btn blueBwhiteL spotSaveBtn submitDetail"
							style="font-size: 18px;">추가하기</button>
					</div>
				</div>
			</div>
		</div>
		<!-- 장소 세부 사항 모달 부분-->

		<!-- 첫 완료 모달 부분-->
		<div class="modalTemplate finModal">
			<div class="contentTemplate finContent">
				<div class="wrapperTemplate finTimetableWrapper"></div>
				<div class="spotButtonWrapper">
					<button class="btn lightskyBblackL spotSaveBtn finModalOutButton"
						style="font-size: 18px;">돌아가기</button>
					<button class="btn blueBwhiteL spotSaveBtn finNext"
						style="font-size: 18px;">다음</button>
				</div>
			</div>
		</div>
		<!-- 첫 완료 모달 부분-->

		<!-- 마지막 완료 모달 부분 -->
		<div class="modalTemplate lastModal">
			<div class="contentTemplate lastContent">
				<div class="wrapperTemplate lastTableWrapper">
					<table border="1">
						<thead>
							<tr>
								<th></th>
								<th>예산</th>
								<th>예상 포인트</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>총 식비:</td>
								<td class="money"><span class="ori1"></span>원</td>
								<td class="money"><span class="point1"></span>원</td>
							</tr>
							<tr>
								<td>총 숙박비:</td>
								<td class="money"><span class="ori2"></span>원</td>
								<td class="money"><span class="point2"></span>원</td>
							</tr>
							<tr>
								<td>총 쇼핑비:</td>
								<td class="money"><span class="ori3"></span>원</td>
								<td class="money"><span class="point3"></span>원</td>
							</tr>
							<tr>
								<td>총 문화시설비:</td>
								<td class="money"><span class="ori4"></span>원</td>
								<td class="money"><span class="point4"></span>원</td>
							</tr>
							<tr>
								<td>총 관광지비:</td>
								<td class="money"><span class="ori5"></span>원</td>
								<td class="money"><span class="point5"></span>원</td>
							</tr>
							<tr>
								<td>총 레포츠비:</td>
								<td class="money"><span class="ori6"></span>원</td>
								<td class="money"><span class="point6"></span>원</td>
							</tr>
							<tr style="border-top: 2px solid black; margin-top: 10px; height: 80px; line-height: 80px;">
								<td>총 금액:</td>
								<td class="money"><span class="ori7"></span>원</td>
								<td class="money"><span class="point7"></span>원</td>
							</tr>
						</tbody>
					</table>


				</div>
				<div class="spotButtonWrapper">
					<button class="btn lightskyBblackL spotSaveBtn lastModalOutButton"
						style="font-size: 18px;">돌아가기</button>
					<button class="btn blueBwhiteL spotSaveBtn submitBtn"
						style="font-size: 18px;">다음</button>
				</div>
			</div>
		</div>
		<!-- 마지막 완료 모달 부분 -->
		<div class="leftContainer">
			<div class="pageSettingWrapper">
				<div class="inputWrapper">
					<input class="input textInput" type="text" name="Title"
						placeholder="여행 일정 제목을 입력하세요.">
				</div>
				<div class="selectionWrapper">
					<select class="select selectInput" id="region" name="Region"
						form="regionForm">
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
					</select> <select class="select selectInput number_of_people" name="Number_of_people"
						form="peopleForm">
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
					<input class="dateInput datepicker startDate" type="text"
						name="Start_date"> ~ <input
						class="dateInput datepicker endDate" type="text" name="End_date">
				</div>
			</div>

			<div class="spotWrapper">
				<div class="categoryWrapper">
					<button class="btn softblueBwhiteL categoryBtn" id="1">음식점</button>
					<button class="btn softblueBwhiteL categoryBtn" id="2">숙박</button>
					<button class="btn softblueBwhiteL categoryBtn" id="3">쇼핑</button>
				</div>
				<div class="categoryWrapper">
					<button class="btn softblueBwhiteL categoryBtn"
						style="font-size: 18px;" id="4">문화활동</button>
					<button class="btn softblueBwhiteL categoryBtn" id="5">관광지</button>
					<button class="btn softblueBwhiteL categoryBtn" id="6">레포츠</button>
				</div>
				<div class="searchWrapper searchSize">
					<input class="input searchInput" type="text" name="Title"
						placeholder="여행 일정 제목을 입력하세요.">
					<button class="btn searchBtn" name="searchBtn">검색</button>
				</div>
				<div class="planCardWrapper">
					<div class="planCards"></div>
					<div class="pageWrapper"></div>
				</div>
			</div>
		</div>
		<div class="rightContainer">
			<div class="mapContainer">
				<div id="map" style="width: 100%; height: 100%;"></div>
			</div>
			<div class="bottomContainer">
				<div class="pageController">
					<div class="prevDayBtn" style="display: inline; cursor: pointer;"><</div>
					<div class="day" style="display: inline;"></div>
					<div class="nextDayBtn" style="display: inline; cursor: pointer;">></div>
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
					<button class="btn lightskyBblackL btnSize outBtn"
						style="font-size: 18px;">나가기</button>
					<button class="btn lightskyBblackL btnSize tmpBtn"
						style="font-size: 18px;">임시저장</button>
					<button class="btn blueBwhiteL btnSize finBtn">완료</button>
				</div>
			</div>
		</div>
	</div>
	<script>
		// 좌표로 맵 만들어주는 네이버 API
		var mapOptions = {
			center : new naver.maps.LatLng(37.514575, 127.0495556),
			zoom : 15,
			mapDataControl : false
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