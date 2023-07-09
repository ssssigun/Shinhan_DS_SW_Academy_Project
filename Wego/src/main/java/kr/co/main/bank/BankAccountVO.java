package kr.co.main.bank;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class BankAccountVO {
	String card_num;
	long amount_payment;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date date;
	String content;
	String address;
}
