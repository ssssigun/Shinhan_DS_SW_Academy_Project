<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
	<link rel="icon" href="/main/image/ShinhanLogo.png"/>
	<link rel="stylesheet" href="/main/css/common.css">
	<link rel="stylesheet" href="/main/css/bank/bank.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
	<title>결제 내역 데이터</title>
</head>
<script>
	<!-- 1.여행 종료 -->
	function updatePlanState() {
		$.ajax({
			url: 'updatePlanState.do',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				var update = data["updatePlanState"];
				var insert = data["insertBankPlanChk"];
				
				if (update == insert) {
					alert(update + "개 여행의 state가 변경되었습니다.");
				} else {
					alert("plan state의 update 개수와 bank plan chk의 insert 개수가 다릅니다.\n데이터베이스를 확인해주십시오.");
				}
			}
		});
	}
	
	<!-- 2.종료된 여행 가져오기 -->
	function selectEndPlan() {
		$.ajax({
			url: 'selectEndPlan.do',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				console.log(data);
				$('.table').empty();
				$('.table').append(''
					+ '<tr class="tableTitle bold">'
					+		'<td width="4%">plan_pk</td>'
					+		'<td width="4%">user_pk</td>'
					+		'<td width="15%">title</td>'
					+		'<td width="15%">num_of_people</td>'
					+		'<td width="7%">start_date</td>'
					+		'<td width="7%">end_date</td>'
					+		'<td width="4%">state</td>'
					+		'<td></td>'
					+		'<td width="4%">card_num</td>'
					+		'<td width="7%">amount_payment</td>'
					+		'<td width="7%">date</td>'
					+		'<td width="15%">content</td>'
					+		'<td width="22%">address</td>'
					+	'</tr>'
				);
				data.forEach(function(object){
					$('.table').append(''
						+	'<tr id="plan_pk'+object.plan_pk+'">'
						+		'<td>'+object.plan_pk+'</td>'
						+		'<td>'+object.user_pk+'</td>'
						+		'<td>'+object.title+'</td>'
						+		'<td>'+object.num_of_people+'</td>'
						+		'<td>'+object.start_date+'</td>'
						+		'<td>'+object.end_date+'</td>'
						+		'<td>'+object.state+'</td>'
						+		'<td></td>'
						+		'<td></td>'
						+		'<td></td>'
						+		'<td></td>'
						+		'<td></td>'
						+		'<td></td>'
						+ '</tr>'
					)
				});
			}
		});
	}
	
	<!-- 랜덤결제 -->
	function insertAccount() {
		
	}
</script>
<body>
	<div class="contentsWrapper">
		<div class="buttonsWrapper">
			<button class="blueBwhiteL btn" onclick="updatePlanState()">1. 여행종료</button>
			<button class="blueBwhiteL btn" onclick="selectEndPlan()">2. 종료된 여행<br>가져오기</button>
			<button class="blueBwhiteL btn">3. 랜덤결제</button>
			<button class="blueBwhiteL btn">4. DB에 넣기</button>
		</div>
		<div class="tablesWrapper">
			<table class="table">
			</table>
		</div>
	</div>
</body>
</html>