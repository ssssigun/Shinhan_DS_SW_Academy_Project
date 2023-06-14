package kr.co.main;

import java.sql.Timestamp;

import lombok.Data;

@Data	
public class DefaultVO {
	//변수 만들어서 사용
	private int Location_pk;
	private int Region;
	private String Address;
	private int Category;
	private String Location_name;
	private long Longitude;
	private long Latitude;
	private String Location_tel;
	private Timestamp Start_time;
	private Timestamp End_time;
}
