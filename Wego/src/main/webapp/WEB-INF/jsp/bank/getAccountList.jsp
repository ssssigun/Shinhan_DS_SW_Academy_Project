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
						+		'<td colspan="6">'+object.plan_pk+'</td>'
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
				var planPkList = data['planPkList'];
				
				planPkList.forEach(function(object) {
					var accountList = data[object];
					console.log(accountList);

					accountList.forEach(function(account) {
						$('#plan_pk'+account.plan_pk).after(''
							+ '<tr class="'+account.account_pk+'">'
							+ 	'<td>'+account.user_pk+'</td>'
							+ 	'<td>'+account.plan_detail_pk+'</td>'
							+ 	'<td>'+account.address+'</td>'
							+ 	'<td>'+account.amount_payment+'</td>'
							+ 	'<td>'+account.content+'</td>'
							+ 	'<td>'+account.date+'</td>'
							+ '</tr>'
						)
						
						if (!account.plan_detail_pk) {
							console.log("."+account.account_pk);
							$("."+account.account_pk).css("background-color", "#FFF59F");
						}
					})
				});
			},
			error: function(error) {
				console.log(error);
			},
			beforeSend: function() {
				$('.loading').removeClass('display-none');
			},
			complete: function() {
				$('.loading').addClass('display-none');
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
	<div class="display-none loading">
		<img src="/main/image/loading.gif">
	</div>
	<div class="contentsWrapper">
		<div class="buttonsWrapper">
			<button class="blueBwhiteL btn" onclick="selectPlanForInsert()">1.종료 여행<br>가져오기</button>
			<button class="blueBwhiteL btn" onclick="selectAccountListForInsert()">2. bank_account,<br>plan_detail 매핑</button>
			<button class="blueBwhiteL btn" onclick="insertUsage()">3. DB에 넣기</button>
		</div>
		<div class="tablesWrapper">
			<table class="table">
			</table>
		</div>
	</div>
</body>
</html>