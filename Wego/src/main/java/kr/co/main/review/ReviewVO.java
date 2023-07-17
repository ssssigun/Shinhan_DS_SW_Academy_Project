
package kr.co.main.review;

import java.sql.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;

import lombok.Data;

@Data	
public class ReviewVO {
	
	
	
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
	private int review_pk;
//	private int Plan_pk; //다른 pk 안들어가지 않음?
//	private int User_pk; //다른 pk 안들어가지 않음?
	
	private String title;
	private String content;
//	private Timestamp regdate; //컬럼 이름이 똑같아서 중복인데
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	Date regdate;
	
	private int state;
	
	//=====================
	//2. review_comment (여행 후기 댓글)
	//=========================
	
//	private int review_comment_pk;
	private int review_comment_pk;
	private String comment_content;
//	private int User_pk;
//	private int Review_pk;
//	private int Plan_pk;


	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date regdate_comment; //as 하면 됨
	
	
	//====================
	//3. review_image (여행 후기 사진)
	//====================
	private int review_image_pk;
//	Plan_pk
//	Review_pk
	private String imagename;
	private String filename_org;
	private String filename_save;
	private long filesize;
	private int filestate;
	
	//====================
	//4. review_recommend (여행 후기 추천)
	//====================
	private int review_recommend_pk;
//	Review_pk , User_pk , Plan_pk
	private int review_recommend_count;
	
	//====================
	//5. review_sue (여행 후기 신고)
	//====================
	private int review_sue_pk;
//	User_pk , Review_pk , Plan_pk
	
	//====================
	//6. review_watch (여행 후기 조회)
	//====================
	private int review_watch_pk;
//	Review_pk , User_pk , Plan_pk
	private int review_watch_count;
	
	
	
	//====================
	//6. user (회원 조인위해)
	//====================
	private int user_pk;
	private String username;
	private String email;
	private String nickname;
//	private Timestamp regdate; 컬럼중복
	private int role;
	private int banpost;
	private String secretkey;
	
	
	
	
	//7.plan (댓글 등록 위해)
	private int plan_pk;
//	private int user_pk;
	
	
	
public ReviewVO() { //지들이 생성하면서 초기화도
		
		this.page = 1;
		this.rowPerPage = 8; //초기화되지만 그 이후 setRowPerPage 20으로 바뀐다는데
		this.startIdx = 0;
	}



public void setComment_content() {
	// TODO Auto-generated method stub
	
}


	
	
	
	
}