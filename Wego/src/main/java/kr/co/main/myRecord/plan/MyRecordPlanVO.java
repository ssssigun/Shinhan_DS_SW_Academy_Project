package kr.co.main.myRecord.plan;



import java.sql.Date;
import java.sql.Timestamp;

import lombok.Data;

@Data
public class MyRecordPlanVO {
	private int plan_pk;
	private int user_pk;
	private String title;
	private int num_of_people;
	private Date start_date;
	private Date end_date;
	private int budget;
	private Timestamp regdate;
	private int reviewed;
	private int reviewed2;
	
	private int location_pk;
	private String region;
	private String location_Name;
	private String day;
	private int star;
	private String location_content;
	
	//private String title;
	private String content;
	private int state;
	
	private int review_pk;
	private String imagename;
	private String filename_org;
	private String filename_save;
	private long filesize;
	private int filestate;
	
	private int rowPerPage =8;
	private int page = 1;
	private int startIdx = 0;
}