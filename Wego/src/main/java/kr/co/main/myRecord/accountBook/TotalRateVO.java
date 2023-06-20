package kr.co.main.myRecord.accountBook;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class TotalRateVO {
	private int total;
	private int food;
	private int accommodation;
	private int shopping;
	private int culture;
	private int tour;
	private int leisure;
	
	private int radar_food;
	private int radar_accommodation;
	private int radar_shopping;
	private int radar_culture;
	private int radar_tour;
	private int radar_leisure;
}
