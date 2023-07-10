package kr.co.main.bank;


import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class BankAccountVO {
	String cardnum;
	long amount_payment;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date date;
	String content;
	String address;
}
