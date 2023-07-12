package kr.co.main.bank;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class BankPlanDetailVO {
	int plan_pk;
	int plan_detail_pk;
	long budget;
	int region;
	String location_name;
	int location_pk;
	String address;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date start_time;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date end_time;
	
	String cardnum;
	int category;
}
