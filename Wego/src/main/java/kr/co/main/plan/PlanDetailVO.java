package kr.co.main.plan;

import java.util.Date;

import lombok.Data;

@Data
public class PlanDetailVO {
	private int location_pk;
	private Date start_time;
	private Date end_time;
	private int budget;
	private int day;
	private int plan_pk;
}