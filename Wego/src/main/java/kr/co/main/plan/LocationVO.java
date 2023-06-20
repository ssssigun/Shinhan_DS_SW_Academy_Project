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
	
	// 페이지네이션을 위한 변수
	private String sword; // 검색어
	private int startIdx; // limit 시작인덱스
	private int page; // 사용자가 요청한 페이지
	private int rowPerPage;
	
	public LocationVO() {
		this.region = -1;
		this.category = -1;
		this.page = 1;
		this.startIdx = 0;
		this.rowPerPage = 5;
	}
}
