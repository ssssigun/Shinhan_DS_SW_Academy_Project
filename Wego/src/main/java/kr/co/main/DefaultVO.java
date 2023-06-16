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
	
	
	
	
	//====================
	//1. review (여행 후기)
	//====================
	private int Review_pk;
//	private int Plan_pk; //다른 pk 안들어가지 않음?
//	private int User_pk; //다른 pk 안들어가지 않음?
	
	private String Title;
	private String Content;
	private Timestamp Regdate; //컬럼 이름이 똑같아서 중복인데
	
	private int State;
	
	//=====================
	//2. review_comment (여행 후기 댓글)
	//=========================
	
	private int Review_comment_pk;
//	private int User_pk;
//	private int Review_pk;
//	private int Plan_pk;
	
	private Timestamp Regdate_comment; //as 하면 됨
	
	
	//====================
	//3. review_image (여행 후기 사진)
	//====================
	private int Review_image_pk;
//	Plan_pk
//	Review_pk
	private String Filename_org;
	private String Filename_save;
	private String Filesize;
	
	//====================
	//4. review_recommend (여행 후기 추천)
	//====================
	private int Review_recommend_pk;
//	Review_pk , User_pk , Plan_pk
	
	//====================
	//5. review_sue (여행 후기 신고)
	//====================
	private int Review_sue_pk;
//	User_pk , Review_pk , Plan_pk
	
	//====================
	//6. review_watch (여행 후기 조회)
	//====================
	private int Review_watch_pk;
//	Review_pk , User_pk , Plan_pk
	
	
	
	
}
