package kr.co.main.myRecord.accountBook;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

@Data
public class ReportVO {
	int plan_pk;
	String title;
	int num_of_people;
	long total_usage;
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date start_date;
	@JsonFormat(pattern = "yyyy-MM-dd")
	Date end_date;
	
	int user_pk;
	int start_page;
}
