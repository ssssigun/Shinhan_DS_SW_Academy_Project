package kr.co.main.myRecord.accountBook;

import java.sql.Date;

import lombok.Data;

@Data
public class ReportVO {
	int plan_pk;
	String title;
	int num_of_people;
	long total_usage;
	Date start_date;
	Date end_date;
}
