package kr.co.main.bank;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class BankPlanDetailVO {
	int plan_pk;
	long budget;
	int region;
	String location_name;
	String address;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date start_time;
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm", timezone = "Asia/Seoul")
	Date end_time;
}
