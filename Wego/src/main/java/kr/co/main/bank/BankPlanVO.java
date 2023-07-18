package kr.co.main.bank;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class BankPlanVO {
	String cardnum;
	int plan_pk;
	int user_pk;
	String title;
	int num_of_people;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date start_date;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date end_date;
	int state;
}
