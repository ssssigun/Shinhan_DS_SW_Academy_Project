
package kr.co.main.review;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;





@Mapper
public interface ReviewMapper {
	//로그인 정보 받아오기
	// XML 파일 id이름과 메서드명 똑같이 사용
	List<ReviewVO> test();
	
	//void insertReviewComment(Map<String,Object> map);
	
	

	//=======================
	// review
	//=======================

	//글목록
	List<ReviewVO> list(ReviewVO vo);
	//글조회
	ReviewVO reviewWatch(ReviewVO vo);
	
	//글추천수
	ReviewVO reviewRecommend(ReviewVO vo);
	
	//글추천수추가
	int reviewRecommendPlus(ReviewVO vo);
	
	//글조회수추가
	int reviewWatchPlus(ReviewVO vo);
	
	boolean insertReviewSue(ReviewVO vo);
 
	int count(ReviewVO vo);

	ReviewVO view(ReviewVO vo);

	void increaseViews(int review_pk);
	
	int update(ReviewVO vo);
	
	//댓글등록
	int insertReviewComment(ReviewVO vo);
	
	
	
	
	//댓글 보기
	List<ReviewVO> getReviewComments(int review_pk);

	int deleteReviewComment(ReviewVO vo);
	
	
	
	
	//이미지 출력
	public List<ReviewVO> getAttachList(int review_image_pk);

	int getUpdatedRecommendCount(String review_pk);

	int commentUpdate(ReviewVO vo);
	
	
	
	
	
	
	
	

//	int updateViewcount(int user_pk);
	
//	int insert(DefaultVO vo); //
//	int update(DefaultVO vo); //업데이트
//	int delete(DefaultVO vo); //삭제
//	int count(DefaultVO vo);
//	List<DefaultVO> list(DefaultVO vo);
//	DefaultVO view(DefaultVO vo);
//	int viewCount(int no); //조회수
}
	