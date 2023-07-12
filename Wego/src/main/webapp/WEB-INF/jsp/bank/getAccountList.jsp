<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" href="/main/image/ShinhanLogo.png"/>
<link rel="stylesheet" href="/main/css/common.css">
<link rel="stylesheet" href="/main/css/bank/bank.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<title>결제내역 받아오기</title>
</head>
<script>
	function selectPlanForInsert() {
		$.ajax({
			url: 'selectPlanForInsert.do',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				console.log(data);
				$('.table').empty();
				data.forEach(function(object){
					$('.table').append(''
						+	'<tr id="plan_pk'+object.plan_pk+'" class="tableTitle bold">'
						+		'<td>'+object.plan_pk+'</td>'
						+ '</tr>'
					)
				});
			},
			error: function(error) {
				console.log(error);
			}
		});
	}
	
	function selectAccountListForInsert() {
		$.ajax({
			url: 'selectAccountListForInsert.do',
			method: 'GET',
			dataType: 'json',
			success: function(data) {
				console.log(data);
			}
		})
	}
	
	function insertUsage() {
		$.ajax({
			url: 'insertUsage.do',
			method: 'GET',
			dataType: 'json',
			success: function() {
				console.log("성공");
			}
		})
	}
	
</script>
<body>
	<div class="contentsWrapper">
		<div class="buttonsWrapper">
			<button class="blueBwhiteL btn" onclick="selectPlanForInsert()">1.종료 여행<br>가져오기</button>
			<button class="blueBwhiteL btn" onclick="selectAccountListForInsert()">1. bank_account & plan_detail</button>
			<button class="blueBwhiteL btn" onclick="insertUsage()">2. DB에 넣기</button>
		</div>
		<div class="tablesWrapper">
			<table class="table">
			</table>
		</div>
	</div>
</body>
</html>