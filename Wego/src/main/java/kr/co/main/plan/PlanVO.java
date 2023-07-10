package kr.co.main.plan;

import java.sql.Timestamp;
import java.util.Date;

import lombok.Data;

@Data
public class PlanVO {
	private int plan_pk;
	private int user_pk;
	private String title;
	private int num_of_people;
	private Date start_date;
	private Date end_date;
	private int state;
	
	private long startDate;
	private long endDate;
}
