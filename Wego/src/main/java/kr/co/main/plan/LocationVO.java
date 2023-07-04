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
	
	// 맵에서 보이는 영역
	private String max_lng;
	private String max_lat;
	private String min_lat;
	private String min_lng;
	
	// 사진 정보
	private String location_pic_url;
	private String state;
	
	public LocationVO() {
		this.region = -1;
		this.category = -1;
		this.page = 1;
		this.startIdx = 0;
		this.rowPerPage = 5;
		this.max_lat = "-1";
		this.max_lng = "-1";
		this.min_lat = "-1";
		this.min_lng = "-1";
	}
}
