<%@page import="kr.co.main.myRecord.accountBook.ReportVO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.main.myRecord.accountBook.TotalRateVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="google" content="notranslate">
  <link rel="icon" href="/main/image/ShinhanLogo.png"/>
  <link rel="stylesheet" href="/main/css/common.css">
  <link rel="stylesheet" href="/main/css/myRecord/accountBook.css">
  <script src="https://cdn.jsdelivr.net/npm/chart.js@4.3.0/dist/chart.umd.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<script type="text/javascript" src="/main/js/myRecord/accountBook/modal.js"></script>
  <title>가계부</title>
</head>
<script>

	var user_pk = ${user_pk};
	var page_num = 0;
	var totalPage = ${totalPage};
	
	/* 상세보기 페이지를 위한 변수들 */
	var nth = 0;
	var totalNth = 0;
	var planPK = -1;
	var startDate = "";
	var endDate = "";
	
	/* 천 단위 콤마 */
	function addComma(num) {
		num = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return num;
	}
	
	/* 페이지 넘기는 버튼 */
	$(document).ready(function() {
		$("#beforePage").click(function(){
			if (page_num != 0){
				page_num -= 4;
				getReportList(user_pk, page_num);
			}
		})
		$("#nextPage").click(function(){
			if (page_num + 4 < totalPage){
				page_num += 4;
				getReportList(user_pk, page_num);
			}
		});
	});
	
	/* 상세보기 */
	function detail(plan_pk, start_date, end_date) {
		planPK = plan_pk;
		startDate = start_date;
		endDate = end_date;
		nth = 0;
		console.log(planPK, startDate, endDate, nth);
		$.ajax({
			url: 'getTotalNth.do?start_date='+startDate+'&end_date='+endDate,
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				totalNth = data;
				modalPage();
			}
		});
	}
	
	/* 모달 페이지 */
	function modalPage() {
		$('#modalPageNth').empty();
		if (nth < totalNth) {
			$('#modalPageNth').append((nth + 1) + "일차");
		} else {
			$('#modalPageNth').append("전체");
		}
		$("input:radio[name='modalRadio']:radio[id='usage']").prop('checked', true); 
		usage();
	}
	
	/* 사용 내역 */
	function usage() {
		$.ajax({
			url: 'getUsageForUsageList.do?plan_pk='+planPK+'&start_date='+startDate+'&end_date='+endDate+'&nth='+nth,
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				$('.resultWrapper').empty();
				$(".resultWrapper").append(''
					+'<table class="modalTable">'
					+  '<tr class="modalTableRow modalTableHead">'
					+	   '<td class="bigLetter bold mtb0 mtb">장소</td>'
					+	   '<td class="bigLetter bold mtb1 mtb">카테고리</td>'
					+    '<td class="bigLetter bold mtb2 mtb">내용</td>'
					+    '<td class="bigLetter bold mtb3 mtb">금액</td>'
					+  '</tr>'
					+'</table>'
				);
				var list = data['list'];
				list.forEach(function(object){
					$(".modalTable").append(''
						+  '<tr class="modalTableRow">'
						+	   '<td class="letter mtb0 mtb">'+object.location_name+'</td>'
						+    '<td class="letter mtb1 mtb">'+object.categoryName+'</td>'
						+    '<td class="letter mtb2 mtb">'+object.content+'</td>'
						+	   '<td class="letter mtb3 mtb">'+addComma(object.amount)+'</td>'
						+  '</tr>'
					)
				});
			}
		})
	}
	
	/* 비교 */
	function compare() {
		$.ajax({
			url: 'getCompareForUsageList.do?plan_pk='+planPK+'&start_date='+startDate+'&end_date='+endDate+'&nth='+nth,
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				var totalRate = data['totalRate'];
				var list = data['list'];
				
				$('.resultWrapper').empty();
				$('.resultWrapper').append(''
					+'<div class="modalContentWrapper">'
					+  '<div class="modalCompareTitle bigbigLetter bold">'
					+    '<div>예산</div>'
					+    '<div>실제 사용 금액</div>'
					+  '</div>'
					+  '<table class="tbl modalCompareTbl">'
					+    '<tr class="modalCompareTr">'
					+      '<td class="td letter modalStickGraphLeftText titleTd">전체</td>'
					+      '<td><div class="modalStickGraphWrapper"><div class="blueStick modalStickGraph letter ellipsis" style="width:'+totalRate.rate+'%;">'+addComma(totalRate.budget)+' 원</div><div class="yellowStick modalStickGraph letter ellipsis rightTd">'+addComma(totalRate.amount)+' 원</div></div></td>'
					+      '<td class="td rightTd letter modalStickGraphRightText titleTd">전체</td>'
					+    '</tr>'
					+  '</table>'
					+'</div>'
				);
				list.forEach(function(object) {
					$('.modalCompareTbl').append(''
							+    '<tr class="modalCompareTr">'
							+      '<td class="td letter ellipsis modalStickGraphLeftText titleTd">'+object.location_name+'</td>'
							+      '<td><div class="modalStickGraphWrapper">'+(object.budget > 0 ? '<div class="blueStick modalStickGraph letter ellipsis" style="width:'+object.rate+'%;">'+addComma(object.budget)+' 원</div>':'')+(object.amount > 0 ? '<div class="yellowStick modalStickGraph letter ellipsis rightTd">'+addComma(object.amount)+' 원</div>' : '')+'</div></td>'
							+      '<td class="td rightTd letter ellipsis modalStickGraphRightText titleTd">'+object.location_name+'</td>'
							+    '</tr>'
					)
				})
			},
			error: function(error){
				console.log(error);
			} 
		})
	}
	
	/* 통계 */
	function graph() {
		$.ajax({
			url: 'getGraphForUsageList.do?plan_pk='+planPK+'&start_date='+startDate+'&end_date='+endDate+'&nth='+nth,
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				$('.resultWrapper').empty();
				$('.resultWrapper').append(''
					+'<div class="modalContentWrapper">'
					+  '<table class="modalGraphTbl">'
					+    '<tr class="modalGraphTr">'
					+      '<td class="modalGraphTd">'+(data["1"].rate > 0 ? '<div class="modalGraphStick" style="height:'+data["1"].rate+'%;">'+addComma(data["1"].sum)+'</div>' : '')+'</td>'
					+      '<td class="modalGraphTd">'+(data["2"].rate > 0 ? '<div class="modalGraphStick" style="height:'+data["2"].rate+'%;">'+addComma(data["2"].sum)+'</div>' : '')+'</td>'
					+      '<td class="modalGraphTd">'+(data["3"].rate > 0 ? '<div class="modalGraphStick" style="height:'+data["3"].rate+'%;">'+addComma(data["3"].sum)+'</div>' : '')+'</td>'
					+      '<td class="modalGraphTd">'+(data["4"].rate > 0 ? '<div class="modalGraphStick" style="height:'+data["4"].rate+'%;">'+addComma(data["4"].sum)+'</div>' : '')+'</td>'
					+      '<td class="modalGraphTd">'+(data["5"].rate > 0 ? '<div class="modalGraphStick" style="height:'+data["5"].rate+'%;">'+addComma(data["5"].sum)+'</div>' : '')+'</td>'
					+      '<td class="modalGraphTd">'+(data["6"].rate > 0 ? '<div class="modalGraphStick" style="height:'+data["6"].rate+'%;">'+addComma(data["6"].sum)+'</div>' : '')+'</td>'
					+    '</tr>'
					+    '</hr>'
					+    '<tr class="modalGraphTitelTr">'
					+      '<td class="letter modalGraphTitleTd">식비</td>'
					+      '<td class="letter modalGraphTitleTd">숙박비</td>'
					+      '<td class="letter modalGraphTitleTd">쇼핑비</td>'
					+      '<td class="letter modalGraphTitleTd">문화시설비</td>'
					+      '<td class="letter modalGraphTitleTd">관광지비</td>'
					+      '<td class="letter modalGraphTitleTd">레포츠비</td>'
					+    '</tr>'
					+  '</table>'
					+'</div>'
				)
				console.log(data);
			},
			error: function(error){
				console.log(error);
			} 
		})
	}
	
	/* n일차 넘길 때마다 nth는 1씩 증가 */
	$(function() {
		$("#beforeModalPage").click(function() {
			if (nth != 0) {
				nth -= 1;
				console.log(nth);
				modalPage();
			}
		})
		$("#nextModalPage").click(function() {
			if (nth != totalNth) {
				nth += 1;
				console.log(nth);
				modalPage();
			}
		})
	});
	
	/* 하단 사용내역 게시물 불러오기 */
	function getReportList(user_pk, page_num) {
		console.log("page_num:" + page_num);
		$.ajax({
			url: 'getReportList.do?user_pk=' + user_pk + '&start_page=' + page_num,
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				console.log(user_pk, page_num);
				console.log(data);
				$('.postsWrapper').empty();
				var list = data['list'];
				list.forEach(function(object){
					$('.postsWrapper').append(''
						+'<div class="postWrapper">'
		        +	'<div class="photoWrapper">'
	          +   '</div>'
	          +   '<div class="postInfoWrapper">'
	          +   	'<div class="titleWrapper">'
	          +    	object.title
	          +    '</div>'
	          +    '<div class="subWrapper">'+ object.num_of_people +'인 | '+addComma(object.total_usage)+' 원</div>'
	          +    '<div class="subsubWrapper">'+object.start_date+' ~ ' + object.end_date + '</div>'
	          +    '<div class="buttonsWrapper"><button class="smallBtn blueBwhiteL" id="detail" onclick="detail('+object.plan_pk+',\''+object.start_date+'\',\''+object.end_date+'\');">상세보기</button></div>'
	          +  '</div>'
	          +'</div>'
	        );
				})
				
				if (page_num + 4 >= totalPage) {
					$('#nextPage').css({"background": "#D9D9D9", "cursor": "default"});
				} else {
					$('#nextPage').removeAttr("style");
				}
				if (0 == page_num) {
					$('#beforePage').css({"background": "#D9D9D9", "cursor": "default"});
				} else {
					$('#beforePage').removeAttr("style");
				}

				modal();
			}
		});

	}
	
	getReportList(user_pk, page_num);
	
</script>

<body>

	<!-- 모달 -->
  <div class="modal">
    <div class="modalContent">
      <div class="modalPageWrapper">
        <button class="modalPageBtn" id="beforeModalPage"><img src="/main/image/MdNavigateBefore.png"/></button>
        <div class="bigbigLetter bold" id="modalPageNth"></div>
        <button class="modalPageBtn" id="nextModalPage"><img src="/main/image/MdNavigateNext.png"/></button>
      </div>
      <div class="selectWrapper">
        <div class="radioButtons">
          <input type="radio" id="usage" name="modalRadio" onclick="usage()" checked><label for="usage">사용 내역</label>
          <input type="radio" id="compare" name="modalRadio" onclick="compare()"><label for="compare">비교</label>
          <input type="radio" id="graph" name="modalRadio" onclick="graph()"><label for="graph">통계</label>
        </div>
      </div>
      <div class="resultWrapper">

      </div>
    </div>
  </div>
  
  <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
  <div class="contents">
    <div class="contentsWrapper">
      <div class="smallMenuWrapper">
        <a href="" class="bigbigLetter">여행 기록</a>
        <a href="" class="bigbigLetter selectLetter">가계부</a>
      </div>
      <div class="infoWrapper">
      	<c:if test="${totalPage gt 0}">
	        <div class="topWrapper">
	          <div class="graphWrapper">
	            <canvas id="chart" width="400" height="400"></canvas>
	          </div>
	          <div class="topRightWrapper">
	            <table class="tbl">
	              <tr class="bigLetter bold">
	                <td class="td titleTd">
	                  전체
	                </td>
	                <td class="td" ><div class="stickGraphWrapper"><div class="blueStick" id="totalRate"></div></div></td>
	                <td class="td rightTd titleTd">
	                  전체
	                </td>
	              </tr>
	              <tr class="bigLetter">
	                <td class="td titleTd">
	                  식비
	                </td>
	                <td class="td" ><div class="stickGraphWrapper"><div class="blueStick" id="foodRate"></div></div></td>
	                <td class="td rightTd titleTd">
	                  식비
	                </td>
	              </tr>
	              <tr class="bigLetter">
	                <td class="td titleTd">
	                  쇼핑비
	                </td>
	                <td class="td" ><div class="stickGraphWrapper"><div class="blueStick" id="shoppingRate"></div></div></td>
	                <td class="td rightTd titleTd">
	                  쇼핑비
	                </td>
	              </tr>
	              <tr class="bigLetter">
	                <td class="td titleTd">
	                  문화시설비
	                </td>
	                <td class="td" ><div class="stickGraphWrapper"><div class="blueStick" id="cultureRate"></div></div></td>
	                <td class="td rightTd titleTd">
	                  문화시설비
	                </td>
	              </tr>
	              <tr class="bigLetter">
	                <td class="td titleTd">
	                  관광지비
	                </td>
	                <td class="td" ><div class="stickGraphWrapper"><div class="blueStick" id="tourRate"></div></div></td>
	                <td class="td rightTd titleTd">
	                  관광지비
	                </td>
	              </tr>
	              <tr class="bigLetter">
	                <td class="td titleTd">
	                  레포츠비
	                </td>
	                <td class="td" ><div class="stickGraphWrapper"><div class="blueStick" id="leisureRate"></div></div></td>
	                <td class="td rightTd titleTd">
	                  레포츠비
	                </td>
	              </tr>
	            </table>
	          </div>
	        </div>
	        <div class="bottomWrapper">
	          <div class="postsWrapper">
	
	          </div>
	          <div class="pageButtonWrapper">
	            <button class="pageButton" id="beforePage"><img src="/main/image/MdNavigateBefore.png"/></button>
	            <button class="pageButton" id="nextPage"><img src="/main/image/MdNavigateNext.png"/></button>
	          </div>
	        </div>
        </c:if>
        <c:if test="${totalPage eq 0}">
        	<div class="bigLetter bold">다녀온 여행이 없습니다.</div>
        </c:if>
      </div>
    </div>
  </div>
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>

<!-- 파란 노란 전체 통계를 보여주기 위한 스타일 -->
<c:if test="${totalPage gt 0}">
	<script type="text/javascript">
		<%
			TotalRateVO totalRate = (TotalRateVO) request.getAttribute("totalRate");
		%>
		document.getElementById("totalRate").style.width = <%= totalRate.getTotal() %> + "%";
		document.getElementById("foodRate").style.width = <%= totalRate.getFood() %> + "%";
		document.getElementById("shoppingRate").style.width = <%= totalRate.getShopping() %> + "%";
		document.getElementById("cultureRate").style.width = <%= totalRate.getCulture() %> + "%";
		document.getElementById("tourRate").style.width = <%= totalRate.getTour() %> + "%";
		document.getElementById("leisureRate").style.width = <%= totalRate.getLeisure() %> + "%";
	</script>
	
	<!-- chartjs 스크립트 -->
	<script>
		<%
			TotalRateVO totalRateRadar = (TotalRateVO) request.getAttribute("totalRateRadar");
		%>
	  Chart.defaults.font.size = 20;
	  const data = {
	    labels: [
	      '식비',
	      '숙박비',
	      '쇼핑비',
	      '문화시설비',
	      '관광지비',
	      '레포츠비'
	    ],
	    datasets: [{
	      data: [${totalRateRadar.radar_food}, ${totalRateRadar.radar_accommodation}, ${totalRateRadar.radar_shopping}, ${totalRateRadar.radar_culture}, ${totalRateRadar.radar_tour}, ${totalRateRadar.radar_leisure}],
	      fill: true,
	      backgroundColor: 'rgba(255, 99, 132, 0.2)',
	      borderColor: 'rgb(255, 99, 132)',
	      pointBackgroundColor: 'rgb(255, 99, 132)',
	      pointBorderColor: '#fff',
	      pointHoverBackgroundColor: '#fff',
	      pointHoverBorderColor: 'rgb(255, 99, 132)'
	    }]
	  }
	
	  const config = {
	    type: 'radar',
	    data: data,
	    options: {
	      scales: {
	        r: {
	          suggestedMin: 0,
	          suggestedMax: 100,
	          pointLabels: {
	            font: {
	              size: 14,
	              family: "'Noto Sans KR', 'sans-serif'",
	              weight: 400
	            }
	          },
	          ticks: {
	            display: false,
	            stepSize: 20
	          },
	          backgroundColor: '#FFFFFF',
	          grid: {
	            circular: true
	          },
	          angleLines: {
	            display: false
	          }
	        }
	      },
	      plugins: {
	        legend: {
	          display: false
	        },
	        tooltip: {
	          enabled: false
	        }
	      }
	    }
	  }
	</script>
	<script>
	  const chart = new Chart(
	    document.getElementById('chart'),
	    config
	  );
	</script>
</c:if>
</html>



