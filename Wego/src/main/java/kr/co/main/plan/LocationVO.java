package kr.co.main.plan;

import java.sql.Timestamp;

import lombok.Data;

@Data	
public class LocationVO {
	//변수 만들어서 사용
	private int location_pk;
	private int region;
	private String address;
	private int category;
	private String location_name;
	private String longitude;
	private String latitude;
	private String location_tel;
	private Timestamp start_time;
	private Timestamp end_time;
	
	private String category_name;
	
	public LocationVO() {
		region = -1;
		category = -1;
	}
}
