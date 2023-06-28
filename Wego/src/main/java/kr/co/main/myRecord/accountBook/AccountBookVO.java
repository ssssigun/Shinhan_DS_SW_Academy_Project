package kr.co.main.myRecord.accountBook;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class AccountBookVO {
	int plan_pk;
	int category;
	String categoryName;
	String location_name;
	long amount;
	long budget;
	int rate;
	String content;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date usage_date;
	int sum;
}
