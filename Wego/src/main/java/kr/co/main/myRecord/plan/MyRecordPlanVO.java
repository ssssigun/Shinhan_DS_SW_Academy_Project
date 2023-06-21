package kr.co.main.myRecord.plan;



import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MyRecordPlanVO {
	private String title;
	private int number_of_people;
	private Date start_date;
	private Date end_date;
	private int budget;
	
	private int rowPerPage =6;
	private int page = 1;
	private int startIdx = 0;
}