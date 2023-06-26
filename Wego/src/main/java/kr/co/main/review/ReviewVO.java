
package kr.co.main.review;

import java.sql.Timestamp;

import lombok.Data;

@Data	
public class ReviewVO {
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
	
	
	//추가한거 파라미터가 다른용도로
		private String stype; // 검색타입 (all:전체, title:제목, content:내용)
		private String sword; // 검색어 사용자로 부터 파라미터 담기기때문 (넣어주는게 편함)
		private int startIdx; //limit 시작인덱스 mysql에서는 0부터 시작함
		private int page; //사용자가 요청한 페이지
		private int rowPerPage; //페이지당로우수 로우가 몇개나 들어가냐 사용자로부터 이름의 파라미터 전달
		// 들어가게
	
	
	
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