package kr.co.main.myRecord.plan;



import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MyRecordPlanVO {
	private int plan_pk;
	private String title;
	private int number_of_people;
	private Date start_date;
	private Date end_date;
	private int budget;
	
	private int location_pk;
	private String region;
	private String location_Name;
	private String day;
	
	private int rowPerPage =8;
	private int page = 1;
	private int startIdx = 0;
}