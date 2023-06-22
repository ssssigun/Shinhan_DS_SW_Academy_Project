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
  <title>가계부</title>
</head>
<script>
	var user_pk = 1;
	var page_num = 0;
	var totalPage = 0;
	
	/* 천 단위 콤마 */
	function addComma(num) {
		num = num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    return num;
	}
	
	/* 페이지 넘기는 버튼 */
	$(document).ready(function() {
		$("#beforePage").click(function(){
			if (page_num != 0){
				page_num -= 1;
				getReportList(user_pk, page_num);
			}
		})
		$("#nextPage").click(function(){
				if (page_num != totalPage){
					page_num += 1;
					getReportList(user_pk, page_num);
				}
		});
	});
	
	/* 하단 사용내역 게시물 불러오기 */
	function getReportList(user_pk, page_num) {
		$.ajax({
			url: 'getReportList.do?user_pk=' + user_pk + '&start_page=' + page_num,
			method: 'GET',
			dataType: 'json',
			success: function(data) {
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
	          +    '<div class="buttonsWrapper"><button class="smallBtn blueBwhiteL">상세보기</button></div>'
	          +  '</div>'
	          +'</div>'
	        );
				})
				totalPage = data['totalPage'];
				
				if (totalPage == page_num) {
					$('#nextPage').css({"background": "#D9D9D9", "cursor": "default"});
				}
				if (0 == page_num) {
					$('#beforePage').css({"background": "#D9D9D9", "cursor": "default"});
				}
			}
		})
	}
	
	getReportList(1, page_num);
	
</script>
<body>
  <jsp:include page="/WEB-INF/jsp/include/header.jsp"/>
  <div class="contents">
    <div class="contentsWrapper">
      <div class="smallMenuWrapper">
        <a href="" class="bigbigLetter">여행 기록</a>
        <a href="" class="bigbigLetter selectLetter">가계부</a>
      </div>
      <div class="infoWrapper">
        <div class="topWrapper">
          <div class="graphWrapper">
            <canvas id="chart" width="400" height="400"></canvas>
          </div>
          <div class="topRightWrapper">
            <table class="tbl">
              <tr class="bigLetter bold">
                <td class="td">
                  전체
                </td>
                <td><div class="stickGraphWrapper"><div class="blueStick" id="totalRate"></div></div></td>
                <td class="rightTd td">
                  전체
                </td>
              </tr>
              <tr class="bigLetter">
                <td class="td">
                  숙박
                </td>
                <td><div class="stickGraphWrapper"><div class="blueStick" id="accommodationRate"></div></div></td>
                <td class="rightTd td">
                  숙박
                </td>
              </tr>
              <tr class="bigLetter">
                <td class="td">
                  식비
                </td>
                <td><div class="stickGraphWrapper"><div class="blueStick" id="foodRate"></div></div></td>
                <td class="rightTd td">
                  식비
                </td>
              </tr>
              <tr class="bigLetter">
                <td class="td">
                  쇼핑비
                </td>
                <td><div class="stickGraphWrapper"><div class="blueStick" id="shoppingRate"></div></div></td>
                <td class="rightTd td">
                  쇼핑비
                </td>
              </tr>
              <tr class="bigLetter">
                <td class="td">
                  문화시설비
                </td>
                <td><div class="stickGraphWrapper"><div class="blueStick" id="cultureRate"></div></div></td>
                <td class="rightTd td">
                  문화시설비
                </td>
              </tr>
              <tr class="bigLetter">
                <td class="td">
                  관광지비
                </td>
                <td><div class="stickGraphWrapper"><div class="blueStick" id="tourRate"></div></div></td>
                <td class="rightTd td">
                  관광지비
                </td>
              </tr>
              <tr class="bigLetter">
                <td class="td">
                  레포츠비
                </td>
                <td><div class="stickGraphWrapper"><div class="blueStick" id="leisureRate"></div></div></td>
                <td class="rightTd td">
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
      </div>
    </div>
  </div>
  <jsp:include page="/WEB-INF/jsp/include/footer.jsp"/>
</body>

<!-- 파란 노란 전체 통계를 보여주기 위한 스타일 -->
<script type="text/javascript">
	<%
		TotalRateVO totalRate = (TotalRateVO) request.getAttribute("totalRate");
	%>
	document.getElementById("totalRate").style.width = <%= totalRate.getTotal() %> + "%";
	document.getElementById("accommodationRate").style.width = <%= totalRate.getAccommodation() %> + "%";
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
</html>



